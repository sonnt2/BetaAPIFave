//
//  TestFunction.m
//  TestRationFace
//
//  Created by REC03 on 3/31/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import "TestFunction.h"


static const double numPhil = 1.618;

@implementation TestFunction

+ (double)convertPhilNumberWithPositon:(double)posOne andPos:(double)posTwo andPos:(double)posThree {
    double result;
    result = (posOne + posTwo + posThree) / (posOne + posTwo);
    //Calculator number phil
    result = fabs(result - numPhil);
    result = 10.0 - (result * 10)/numPhil;

    return result;
}
@end
