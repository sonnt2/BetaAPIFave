//
//  APIFaceAnalystEntity.h
//  TestRationFace
//
//  Created by sonnt2 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIFaceAnalystEntity : NSObject
@property(copy, nonatomic) NSString *age;
@property(copy, nonatomic) NSString *faceQuality;
@property(copy, nonatomic) NSString *gender;

@property(nonatomic) NSInteger rightEyeCenterX;
@property(nonatomic) NSInteger rightEyeCenterY;
@property(nonatomic) NSInteger leftEyeCenterX;
@property(nonatomic) NSInteger leftEyeCenterY;
@property(nonatomic) NSInteger noseContourLeft2X;
@property(nonatomic) NSInteger noseContourLeft2Y;
@property(nonatomic) NSInteger noseContourLowerMiddleX;
@property(nonatomic) NSInteger noseContourLowerMiddleY;
@property(nonatomic) NSInteger noseContourLeft3X;
@property(nonatomic) NSInteger noseContourLeft3Y;
@property(nonatomic) NSInteger mouthUpperLipBottomX;
@property(nonatomic) NSInteger mouthUpperLipBottomY;
@property(nonatomic) NSInteger mouthLowerLipBottomX;
@property(nonatomic) NSInteger mouthLowerLipBottomY;
@property(nonatomic) NSInteger contourChinX;
@property(nonatomic) NSInteger contourChinY;
@property(nonatomic) NSInteger mouthUpperLipTopX;
@property(nonatomic) NSInteger mouthUpperLipTopY;
@property(nonatomic) NSInteger rightEyebrowUpperRightQuarterX;
@property(nonatomic) NSInteger rightEyebrowUpperRightQuarterY;
@property(nonatomic) NSInteger leftEyeTopX;
@property(nonatomic) NSInteger leftEyeTopY;
@property(nonatomic) NSInteger leftEyeBottomX;
@property(nonatomic) NSInteger leftEyeBottomY;
@property(nonatomic) NSInteger contourLeft1X;
@property(nonatomic) NSInteger contourLeft1Y;
@property(nonatomic) NSInteger leftEyeLeftCornerX;
@property(nonatomic) NSInteger leftEyeLeftCornerY;
@property(nonatomic) NSInteger leftEyeUpperLeftQuarterX;
@property(nonatomic) NSInteger leftEyeUpperLeftQuarterY;
@property(nonatomic) NSInteger leftEyeRightCornerX;
@property(nonatomic) NSInteger leftEyeRightCornerY;
@property(nonatomic) NSInteger noseTipX;
@property(nonatomic) NSInteger noseTipY;
@property(nonatomic) NSInteger rightEyeLeftCornerX;
@property(nonatomic) NSInteger rightEyeLeftCornerY;
@property(nonatomic) NSInteger rightEyeUpperRightQuarterX;
@property(nonatomic) NSInteger rightEyeUpperRightQuarterY;
@property(nonatomic) NSInteger contourRight1X;
@property(nonatomic) NSInteger contourRight1Y;

@property(nonatomic) NSInteger noseLeftX;
@property(nonatomic) NSInteger noseLeftY;
@property(nonatomic) NSInteger noseRightX;
@property(nonatomic) NSInteger noseRightY;
@property(nonatomic) NSInteger rightEyeRightCornerX;
@property(nonatomic) NSInteger rightEyeRightCornerY;

@property(nonatomic) NSInteger mouthLeftCornerX;
@property(nonatomic) NSInteger mouthLeftCornerY;
@property(nonatomic) NSInteger mouthUpperLipLeftContour1X;
@property(nonatomic) NSInteger mouthUpperLipLeftContour1Y;
@property(nonatomic) NSInteger mouthUpperLipRightContour1X;
@property(nonatomic) NSInteger mouthUpperLipRightContour1Y;

@property(nonatomic) NSInteger mouthRightCornerX;
@property(nonatomic) NSInteger mouthRightCornerY;


@end
