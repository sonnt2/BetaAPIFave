//
//  TestFetcherBase.h
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TestFetcherBase : NSObject
- (AFHTTPSessionManager*) httpSessionManager;
@end
