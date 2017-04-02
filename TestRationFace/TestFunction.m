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

+ (double)convertPointWithPosition:(double)posOne andPos:(double)posTwo andPos:(double)posThree andPos:(double)posFour andConstant:(double) numConstant {
    
    double result;
    result = fabs(posOne - posTwo) / fabs(posThree - posFour);
    if (result > 1) {
        result = fabs(result - numConstant);
        result = 10.0 - (result * 10) / numConstant;
    } else {
        result = fabs(result - 1 / numConstant);
        result = 10.0 - (result * 10) / (1/numConstant);
    }
    return result;
}
@end
