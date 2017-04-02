//
//  APIFaceAnalystEntity.h
//  TestRationFace
//
//  Created by sonnt2 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @class APIFaceAnalyst entity
 @abstract Keep information corresponding to each landmark of API face plus plus
 */
@interface APIFaceAnalystEntity : NSObject


@property(copy, nonatomic) NSString *age;
@property(copy, nonatomic) NSString *faceQuality;
@property(copy, nonatomic) NSString *gender;

/*! 
 @abstract Width of Face
*/
@property(nonatomic) NSInteger faceRectangleWidth;

/*!
 @abstract Height of Face
 */
@property(nonatomic) NSInteger faceRectangleHeight;

/*!
 @abstract Position and landmark of right Eye
 */
@property(nonatomic) NSInteger rightEyeCenterX;
@property(nonatomic) NSInteger rightEyeCenterY;
@property(nonatomic) NSInteger rightEyeTopX;
@property(nonatomic) NSInteger rightEyeTopY;
@property(nonatomic) NSInteger rightEyeBottomX;
@property(nonatomic) NSInteger rightEyeBottomY;
@property(nonatomic) NSInteger rightEyeRightCornerX;
@property(nonatomic) NSInteger rightEyeRightCornerY;
@property(nonatomic) NSInteger rightEyeLeftCornerX;
@property(nonatomic) NSInteger rightEyeLeftCornerY;
@property(nonatomic) NSInteger rightEyeUpperRightQuarterX;
@property(nonatomic) NSInteger rightEyeUpperRightQuarterY;
@property(nonatomic) NSInteger rightEyeUpperLeftQuarterX;
@property(nonatomic) NSInteger rightEyeUpperLeftQuarterY;
@property(nonatomic) NSInteger rightEyebrowUpperRightQuarterX;
@property(nonatomic) NSInteger rightEyebrowUpperRightQuarterY;
@property(nonatomic) NSInteger rightEyebrowUpperMiddleX;
@property(nonatomic) NSInteger rightEyebrowUpperMiddleY;


/*!
 @abstract Position and landmark of left Eye
 */
@property(nonatomic) NSInteger leftEyeCenterX;
@property(nonatomic) NSInteger leftEyeCenterY;
@property(nonatomic) NSInteger leftEyeTopX;
@property(nonatomic) NSInteger leftEyeTopY;
@property(nonatomic) NSInteger leftEyeBottomX;
@property(nonatomic) NSInteger leftEyeBottomY;
@property(nonatomic) NSInteger leftEyeRightCornerX;
@property(nonatomic) NSInteger leftEyeRightCornerY;
@property(nonatomic) NSInteger leftEyeLeftCornerX;
@property(nonatomic) NSInteger leftEyeLeftCornerY;
@property(nonatomic) NSInteger leftEyeUpperRightQuarterX;
@property(nonatomic) NSInteger leftEyeUpperRightQuarterY;
@property(nonatomic) NSInteger leftEyeUpperLeftQuarterX;
@property(nonatomic) NSInteger leftEyeUpperLeftQuarterY;
@property(nonatomic) NSInteger leftEyebrowUpperRightQuarterX;
@property(nonatomic) NSInteger leftEyebrowUpperRightQuarterY;
@property(nonatomic) NSInteger leftEyebrowUpperMiddleX;
@property(nonatomic) NSInteger leftEyebrowUpperMiddleY;



/*!
 @abstract Position and landmark of nose
 */
@property(nonatomic) NSInteger noseContourLeft1X;
@property(nonatomic) NSInteger noseContourLeft1Y;
@property(nonatomic) NSInteger noseContourLeft2X;
@property(nonatomic) NSInteger noseContourLeft2Y;
@property(nonatomic) NSInteger noseContourLeft3X;
@property(nonatomic) NSInteger noseContourLeft3Y;
@property(nonatomic) NSInteger noseContourLowerMiddleX;
@property(nonatomic) NSInteger noseContourLowerMiddleY;
@property(nonatomic) NSInteger noseTipX;
@property(nonatomic) NSInteger noseTipY;
@property(nonatomic) NSInteger noseLeftX;
@property(nonatomic) NSInteger noseLeftY;
@property(nonatomic) NSInteger noseRightX;
@property(nonatomic) NSInteger noseRightY;

/*!
 @abstract Position and landmark of Upper Lip
 */
@property(nonatomic) NSInteger mouthUpperLipTopX;
@property(nonatomic) NSInteger mouthUpperLipTopY;
@property(nonatomic) NSInteger mouthUpperLipBottomX;
@property(nonatomic) NSInteger mouthUpperLipBottomY;
@property(nonatomic) NSInteger mouthUpperLipLeftContour1X;
@property(nonatomic) NSInteger mouthUpperLipLeftContour1Y;
@property(nonatomic) NSInteger mouthUpperLipRightContour1X;
@property(nonatomic) NSInteger mouthUpperLipRightContour1Y;
@property(nonatomic) NSInteger mouthLeftCornerX;
@property(nonatomic) NSInteger mouthLeftCornerY;
@property(nonatomic) NSInteger mouthRightCornerX;
@property(nonatomic) NSInteger mouthRightCornerY;

/*!
 @abstract Position and landmark of Lower Lip
 */
@property(nonatomic) NSInteger mouthLowerLipTopX;
@property(nonatomic) NSInteger mouthLowerLipTopY;
@property(nonatomic) NSInteger mouthLowerLipBottomX;
@property(nonatomic) NSInteger mouthLowerLipBottomY;

/*!
 @abstract Position and landmark of contour
 */
@property(nonatomic) NSInteger contourRight1X;
@property(nonatomic) NSInteger contourRight1Y;
@property(nonatomic) NSInteger contourChinX;
@property(nonatomic) NSInteger contourChinY;
@property(nonatomic) NSInteger contourLeft1X;
@property(nonatomic) NSInteger contourLeft1Y;

@end
