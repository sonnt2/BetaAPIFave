//
//  TestAPIFaceFetcher.h
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestFetcherBase.h"

@interface TestAPIFaceFetcher : TestFetcherBase

- (void)beginFetcherWithKey:(NSString*)key
                     secret:(NSString*)secret
                  imageFile:(UIImage *)image_file
                   complete:(void (^) (NSArray *results))completeTask
                      error:(void (^) (NSError * error)) errorTask;

@end
