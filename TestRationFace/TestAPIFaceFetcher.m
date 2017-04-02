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
                
                //Get Attribute from API
                NSDictionary *itemAttribute = [itemDict objectForKey:@"attributes"];
                //Set age
                [faceAnalyst setAge:[[[itemAttribute objectForKey:@"age"] objectForKey:@"value"] stringValue]];
                //Set faceQuality
                [faceAnalyst setFaceQuality:[[[itemAttribute objectForKey:@"facequality"] objectForKey:@"value"] stringValue]];
                //Set Gender
                [faceAnalyst setGender:[[itemAttribute objectForKey:@"gender"] objectForKey:@"value"]];
                
                //Get properties of Face retangle from API
                NSDictionary *itemFaceRetangle = [itemDict objectForKey:@"face_rectangle"];
                //Set Width of Face
                [faceAnalyst setFaceRectangleWidth:[[itemFaceRetangle objectForKey:@"width"] integerValue]];
                //Set Heght of Face
                [faceAnalyst setFaceRectangleHeight:[[itemFaceRetangle objectForKey:@"height"] integerValue]];
                
                
                //Get properties landmark
                NSDictionary *itemLandmark = [itemDict objectForKey:@"landmark"];
                //Setting for Right eye
                [self settingLanmarkRightEyeWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                //Setting for left eye
                [self settingLanmarkLeftEyeWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                //Setting for Nose
                [self settingLanmarkNoseWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                //Setting for UpperLip
                [self settingLanmarkUpperLipWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                //Setting for Lower Lip
                [self settingLanmarkLowerLipWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                //Setting for Contour
                [self settingLanmarkContourWithEntity:faceAnalyst andItemsLandmak:itemLandmark];
                
                [_results addObject:faceAnalyst];
            }
        }
        completeTask(_results);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        errorTask(error);
    }];
}

/*!
 @abstract Setting for Right Eye
 */
- (void)settingLanmarkRightEyeWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of right_eye
    //Center
    [faceAnalyst setRightEyeCenterX:[[[itemLandmark objectForKey:@"right_eye_center"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeCenterY:[[[itemLandmark objectForKey:@"right_eye_center"] objectForKey:@"y"] integerValue]];
    //Top
    [faceAnalyst setRightEyeTopX:[[[itemLandmark objectForKey:@"right_eye_top"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeTopY:[[[itemLandmark objectForKey:@"right_eye_top"] objectForKey:@"y"] integerValue]];
    //Bottom
    [faceAnalyst setRightEyeBottomX:[[[itemLandmark objectForKey:@"right_eye_bottom"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeBottomY:[[[itemLandmark objectForKey:@"right_eye_bottom"] objectForKey:@"y"] integerValue]];
    //Right corner
    [faceAnalyst setRightEyeRightCornerX:[[[itemLandmark objectForKey:@"right_eye_right_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeRightCornerY:[[[itemLandmark objectForKey:@"right_eye_right_corner"] objectForKey:@"y"] integerValue]];
    //Left corner
    [faceAnalyst setRightEyeLeftCornerX:[[[itemLandmark objectForKey:@"right_eye_left_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeLeftCornerY:[[[itemLandmark objectForKey:@"right_eye_left_corner"] objectForKey:@"y"] integerValue]];
    //Right quarter
    [faceAnalyst setRightEyeUpperRightQuarterX:[[[itemLandmark objectForKey:@"right_eye_upper_right_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeUpperRightQuarterY:[[[itemLandmark objectForKey:@"right_eye_upper_right_quarter"] objectForKey:@"y"] integerValue]];
    //Left quarter
    [faceAnalyst setRightEyeUpperLeftQuarterX:[[[itemLandmark objectForKey:@"right_eye_upper_left_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyeUpperLeftQuarterY:[[[itemLandmark objectForKey:@"right_eye_upper_left_quarter"] objectForKey:@"y"] integerValue]];
    //Eyebrow Upper Right Quarter
    [faceAnalyst setRightEyebrowUpperRightQuarterX:[[[itemLandmark objectForKey:@"right_eyebrow_upper_right_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyebrowUpperRightQuarterY:[[[itemLandmark objectForKey:@"right_eyebrow_upper_right_quarter"] objectForKey:@"y"] integerValue]];
    //Eyebrow Upper Middle
    [faceAnalyst setRightEyebrowUpperMiddleX:[[[itemLandmark objectForKey:@"right_eyebrow_upper_middle"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setRightEyebrowUpperMiddleY:[[[itemLandmark objectForKey:@"right_eyebrow_upper_middle"] objectForKey:@"y"] integerValue]];
}

/*!
 @abstract Setting for Left Eye
 */
- (void)settingLanmarkLeftEyeWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of Left eye
    //Center
    [faceAnalyst setLeftEyeCenterX:[[[itemLandmark objectForKey:@"left_eye_center"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeCenterY:[[[itemLandmark objectForKey:@"left_eye_center"] objectForKey:@"y"] integerValue]];
    //Top
    [faceAnalyst setLeftEyeTopX:[[[itemLandmark objectForKey:@"left_eye_top"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeTopY:[[[itemLandmark objectForKey:@"left_eye_top"] objectForKey:@"y"] integerValue]];
    //Bottom
    [faceAnalyst setLeftEyeBottomX:[[[itemLandmark objectForKey:@"left_eye_bottom"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeBottomY:[[[itemLandmark objectForKey:@"left_eye_bottom"] objectForKey:@"y"] integerValue]];
    //Right corner
    [faceAnalyst setLeftEyeRightCornerX:[[[itemLandmark objectForKey:@"left_eye_right_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeRightCornerY:[[[itemLandmark objectForKey:@"left_eye_right_corner"] objectForKey:@"y"] integerValue]];
    //Left corner
    [faceAnalyst setLeftEyeLeftCornerX:[[[itemLandmark objectForKey:@"left_eye_left_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeLeftCornerY:[[[itemLandmark objectForKey:@"left_eye_left_corner"] objectForKey:@"y"] integerValue]];
    //Right quarter
    [faceAnalyst setLeftEyeUpperRightQuarterX:[[[itemLandmark objectForKey:@"left_eye_upper_right_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeUpperRightQuarterY:[[[itemLandmark objectForKey:@"left_eye_upper_right_quarter"] objectForKey:@"y"] integerValue]];
    //Left quarter
    [faceAnalyst setLeftEyeUpperLeftQuarterX:[[[itemLandmark objectForKey:@"left_eye_upper_left_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyeUpperLeftQuarterY:[[[itemLandmark objectForKey:@"left_eye_upper_left_quarter"] objectForKey:@"y"] integerValue]];
    
    //Eyebrow Upper Right Quarter
    [faceAnalyst setLeftEyebrowUpperRightQuarterX:[[[itemLandmark objectForKey:@"left_eyebrow_upper_right_quarter"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyebrowUpperRightQuarterY:[[[itemLandmark objectForKey:@"left_eyebrow_upper_right_quarter"] objectForKey:@"y"] integerValue]];
    //Eyebrow Upper Middle
    [faceAnalyst setLeftEyebrowUpperMiddleX:[[[itemLandmark objectForKey:@"left_eyebrow_upper_middle"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setLeftEyebrowUpperMiddleY:[[[itemLandmark objectForKey:@"left_eyebrow_upper_middle"] objectForKey:@"y"] integerValue]];

}

/*!
 @abstract Setting for nose
 */
- (void)settingLanmarkNoseWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of nose
    //Nose Coutour left 1.2.3
    [faceAnalyst setNoseContourLeft1X:[[[itemLandmark objectForKey:@"nose_contour_left1"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseContourLeft1Y:[[[itemLandmark objectForKey:@"nose_contour_left1"] objectForKey:@"y"] integerValue]];
    [faceAnalyst setNoseContourLeft2X:[[[itemLandmark objectForKey:@"nose_contour_left2"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseContourLeft2Y:[[[itemLandmark objectForKey:@"nose_contour_left2"] objectForKey:@"y"] integerValue]];
    [faceAnalyst setNoseContourLeft3X:[[[itemLandmark objectForKey:@"nose_contour_left3"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseContourLeft3Y:[[[itemLandmark objectForKey:@"nose_contour_left3"] objectForKey:@"y"] integerValue]];
    
    //Lower Middle
    [faceAnalyst setNoseContourLowerMiddleX:[[[itemLandmark objectForKey:@"nose_contour_lower_middle"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseContourLowerMiddleY:[[[itemLandmark objectForKey:@"nose_contour_lower_middle"] objectForKey:@"y"] integerValue]];
    //nose Tip
    [faceAnalyst setNoseTipX:[[[itemLandmark objectForKey:@"nose_tip"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseTipY:[[[itemLandmark objectForKey:@"nose_tip"] objectForKey:@"y"] integerValue]];
    //nose Left
    [faceAnalyst setNoseLeftX:[[[itemLandmark objectForKey:@"nose_left"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseLeftY:[[[itemLandmark objectForKey:@"nose_left"] objectForKey:@"y"] integerValue]];
    //nose Right
    [faceAnalyst setNoseRightX:[[[itemLandmark objectForKey:@"nose_Right"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setNoseRightX:[[[itemLandmark objectForKey:@"nose_Right"] objectForKey:@"y"] integerValue]];
}

/*!
 @abstract Setting Upper Lip
 */
- (void)settingLanmarkUpperLipWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of Upper Lip
    //Upper lip Top
    [faceAnalyst setMouthUpperLipTopX:[[[itemLandmark objectForKey:@"mouth_upper_lip_top"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthUpperLipTopY:[[[itemLandmark objectForKey:@"mouth_upper_lip_top"] objectForKey:@"y"] integerValue]];
    //Upper lip Top
    [faceAnalyst setMouthUpperLipBottomX:[[[itemLandmark objectForKey:@"mouth_upper_lip_bottom"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthUpperLipBottomY:[[[itemLandmark objectForKey:@"mouth_upper_lip_bottom"] objectForKey:@"y"] integerValue]];
    //Left Contour
    [faceAnalyst setMouthUpperLipLeftContour1X:[[[itemLandmark objectForKey:@"mouth_upper_lip_left_contour1"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthUpperLipLeftContour1Y:[[[itemLandmark objectForKey:@"mouth_upper_lip_left_contour1"] objectForKey:@"y"] integerValue]];
    //Right Contour
    [faceAnalyst setMouthUpperLipRightContour1X:[[[itemLandmark objectForKey:@"mouth_upper_lip_right_contour1"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthUpperLipRightContour1Y:[[[itemLandmark objectForKey:@"mouth_upper_lip_right_contour1"] objectForKey:@"y"] integerValue]];
    //mouth Left Corner
    [faceAnalyst setMouthLeftCornerX:[[[itemLandmark objectForKey:@"mouth_left_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthLeftCornerY:[[[itemLandmark objectForKey:@"mouth_left_corner"] objectForKey:@"y"] integerValue]];
    //mouth Right Corner
    [faceAnalyst setMouthRightCornerX:[[[itemLandmark objectForKey:@"mouth_right_corner"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthRightCornerY:[[[itemLandmark objectForKey:@"mouth_right_corner"] objectForKey:@"y"] integerValue]];
}

/*!
 @abstract Setting Lower Lip
 */
- (void)settingLanmarkLowerLipWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of Lower Lip
    //Upper lip Top
    [faceAnalyst setMouthLowerLipTopX:[[[itemLandmark objectForKey:@"mouth_lower_lip_top"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthLowerLipTopY:[[[itemLandmark objectForKey:@"mouth_lower_lip_top"] objectForKey:@"y"] integerValue]];
    //Upper lip Top
    [faceAnalyst setMouthLowerLipBottomX:[[[itemLandmark objectForKey:@"mouth_lower_lip_bottom"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setMouthLowerLipBottomY:[[[itemLandmark objectForKey:@"mouth_lower_lip_bottom"] objectForKey:@"y"] integerValue]];
}

/*!
 @abstract Setting contour
 */
- (void)settingLanmarkContourWithEntity:(APIFaceAnalystEntity*)faceAnalyst andItemsLandmak:(NSDictionary *)itemLandmark {
    //set x and y of contour
    //contour Right
    [faceAnalyst setContourRight1X:[[[itemLandmark objectForKey:@"contour_right1"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setContourRight1Y:[[[itemLandmark objectForKey:@"contour_right1"] objectForKey:@"y"] integerValue]];
    
    //contour Left
    [faceAnalyst setContourLeft1X:[[[itemLandmark objectForKey:@"contour_left1"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setContourLeft1X:[[[itemLandmark objectForKey:@"contour_left1"] objectForKey:@"y"] integerValue]];
    
    //contour chin
    [faceAnalyst setContourChinX:[[[itemLandmark objectForKey:@"contour_chin"] objectForKey:@"x"] integerValue]];
    [faceAnalyst setContourChinX:[[[itemLandmark objectForKey:@"contour_chin"] objectForKey:@"y"] integerValue]];

}



@end
