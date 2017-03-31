//
//  TestAPIFaceFetcher.m
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import "TestAPIFaceFetcher.h"
#import "APIFaceAnalystEntity.h"

@interface TestAPIFaceFetcher()
@property (strong, nonatomic) NSMutableArray *results;
@end

@implementation TestAPIFaceFetcher

 - (id)init {
    self = [super init];
    if (self) {
         _results = [NSMutableArray new];
    }
    return self;
}
- (void)beginFetcherWithKey:(NSString *)key secret:(NSString *)secret imageFile:(UIImage*)image_file complete:(void (^)(NSArray *))completeTask error:(void (^)(NSError *))errorTask {
    NSString *strkey = @"ScocKy2GZ-4YRkCzWI8TaEcd84A-_mEB";
    NSString *strSecret = @"y4u40Tfk8mCp5lqiQQ3j_481y6brxo4j";
    NSString *urlDetect = @"https://api-us.faceplusplus.com/facepp/v3/detect";
    NSDictionary *parameters = @{@"api_key": strkey, @"api_secret":strSecret, @"return_landmark":@"1", @"return_attributes":@"gender,age,facequality"};
    
    //Init AFHTTPSessionManager to action with API
    AFHTTPSessionManager *sessionManager = [self httpSessionManager];
    
    //Call back method post from app to api
    [sessionManager POST:urlDetect parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //Is image file
        if (image_file) {
            
            //Upload file and add to form data
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image_file, 1.0)
                                        name:@"image_file"
                                    fileName:@"image.jpg"
                                    mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
         NSLog(@"Success: %@", responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {

            for (NSDictionary *itemDict in [responseObject objectForKey:@"faces"]) {
                APIFaceAnalystEntity *faceAnalyst = [[APIFaceAnalystEntity alloc] init];
                NSLog(@"age: %@", [[[itemDict objectForKey:@"attributes"] objectForKey:@"age"] objectForKey:@"value"]);
                [faceAnalyst setAge:[[[[itemDict objectForKey:@"attributes"] objectForKey:@"age"] objectForKey:@"value"] stringValue]];
                [faceAnalyst setFaceQuality:[[[[itemDict objectForKey:@"attributes"] objectForKey:@"facequality"] objectForKey:@"value"] stringValue]];
                [faceAnalyst setGender:[[[itemDict objectForKey:@"attributes"] objectForKey:@"gender"] objectForKey:@"value"]];
                    [_results addObject:faceAnalyst];
                
                //Get properties landmark
                NSDictionary *itemLandmark = [itemDict objectForKey:@"landmark"];
                
                //Get x and y of right_eye_center
                [faceAnalyst setRightEyeCenterX:[[[itemLandmark objectForKey:@"right_eye_center"] objectForKey:@"x"] integerValue]];
                [faceAnalyst setRightEyeCenterY:[[[itemLandmark objectForKey:@"right_eye_center"] objectForKey:@"y"] integerValue]];
            }
        }
        completeTask(_results);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        errorTask(error);
    }];
}

@end
