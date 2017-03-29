//
//  TestFetcherBase.m
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import "TestFetcherBase.h"

@interface TestFetcherBase()
@property(strong, nonatomic) AFHTTPSessionManager *requestManager;
@end

@implementation TestFetcherBase

-(id)init {
    self = [super init];
    if (self) {
        _requestManager = [AFHTTPSessionManager manager];
    }
    
    return self;
}

- (AFHTTPSessionManager*) httpSessionManager {
    if (_requestManager == nil) {
        _requestManager = [AFHTTPSessionManager manager];
    }
    
    return _requestManager;
    
}
@end
