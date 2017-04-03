//
//  ViewController.m
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import "ViewController.h"
#import "TestAPIFaceFetcher.h"
#import "MBProgressHUD.h"
#import "APIFaceAnalystEntity.h"
#import "TestFunction.h"
#import "TGCameraViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *txtAge;
@property (weak, nonatomic) IBOutlet UILabel *txtSex;
@property (weak, nonatomic) IBOutlet UILabel *txtPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    126
    //    176
    //    422
    //
    [TestFunction convertPhilNumberWithPositon:287.0 andPos:326.0 andPos:351.0];
    
    
    // set custom tint color
    [TGCameraColor setTintColor: [UIColor greenColor]];
    
    // save image to album
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:@YES];
    
    // use the original image aspect instead of square
    
    // Do any additional setup after loading the view, typically from a nib.
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertController *myAlertView = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //Do some thing here
                                 [self dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [myAlertView addAction:ok];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapCaptureImage:(id)sender {
    [self resetLabelInfo];
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    
    [self presentViewController:navigationController animated:NO completion:nil];
}

- (IBAction)tapGetPhotos:(id)sender {
    [self resetLabelInfo];
    UIImagePickerController *picker = [TGAlbum imagePickerControllerWithDelegate:self];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) resetLabelInfo{
    [self.txtAge setText:@""];
    [self.txtSex setText:@""];
    [self.txtPoint setText:@""];
}

//  #UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *mediaType = [info valueForKey:UIImagePickerControllerMediaType];

    if([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        UIImage *photoTaken = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        //Save Photo to library only if it wasnt already saved i.e. its just been taken
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(photoTaken, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
         self.imageView.image = photoTaken;
        TestAPIFaceFetcher *testApi = [[TestAPIFaceFetcher alloc]init];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"Caculating";
        [testApi beginFetcherWithKey:nil secret:nil imageFile:photoTaken complete:^(NSArray *results) {
            NSLog(@"ket qua%@",results);
            for (APIFaceAnalystEntity *entity in results) {
                [self.txtAge setText:[NSString stringWithFormat:@"Age:%@",entity.age]];
                [self.txtSex setText:[NSString stringWithFormat:@"Sex:%@",entity.gender]];
                [self.txtPoint setText:[NSString stringWithFormat:@"%@/100",entity.faceQuality]];
                [self calculatorPointWithEntity:entity];
            }
            [hud hide:YES];
        } error:^(NSError *error) {
            //
        }];
    }
    
   // UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    //self.imageView.image = chosenImage;
   // TestAPIFaceFetcher *testApi = [[TestAPIFaceFetcher alloc]init];
   // NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    //NSLog(@"ssssss%@",localUrl.absoluteString);
   

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertView *alert;
    //NSLog(@"Image:%@", image);
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                           message:[error localizedDescription]
                                          delegate:nil
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)calculatorPointWithEntity:(APIFaceAnalystEntity*)faceAnalyst {
    //calc width/height of eye is 0.5
    double pointLeftEye = [TestFunction convertPointWithPosition:faceAnalyst.leftEyeTopY andPos:faceAnalyst.leftEyeBottomY andPos:faceAnalyst.leftEyeLeftCornerX andPos:faceAnalyst.leftEyeRightCornerX andConstant:2.5];
    NSLog(@"diem mat trai: %.2f", pointLeftEye);
    
    double pointRighEye = [TestFunction convertPointWithPosition:faceAnalyst.rightEyeTopY andPos:faceAnalyst.rightEyeBottomY andPos:faceAnalyst.rightEyeLeftCornerX andPos:faceAnalyst.rightEyeRightCornerX andConstant:2.5];
    NSLog(@"diem mat phai: %.2f", pointRighEye);
    
    //Calc width of eye/ width of face
    double pointWidthEyeAndWidthFace = [TestFunction convertPointWithPosition:faceAnalyst.leftEyeLeftCornerX andPos:faceAnalyst.rightEyeRightCornerX andPos:faceAnalyst.faceRectangleWidth andPos:0.0 andConstant:2.0];
    NSLog(@"diem cua mat:%.2f", pointWidthEyeAndWidthFace);
    
    //Calc width of left eye =  width of left and right eyes
    double pointWidthLeftEyeAndWidthLeftAndRightEye = [TestFunction convertPointWithPosition:faceAnalyst.leftEyeLeftCornerX andPos:faceAnalyst.leftEyeRightCornerX andPos:faceAnalyst.rightEyeLeftCornerX andPos:faceAnalyst.leftEyeRightCornerX andConstant:1.0];
    NSLog(@"diem cua mat:%.2f", pointWidthLeftEyeAndWidthLeftAndRightEye);
    
    //Calc width of Rigth eye =  width of left and right eyes
    double pointWidthRightEyeAndWidthLeftAndRightEye = [TestFunction convertPointWithPosition:faceAnalyst.rightEyeRightCornerX andPos:faceAnalyst.rightEyeLeftCornerX andPos:faceAnalyst.rightEyeLeftCornerX andPos:faceAnalyst.leftEyeRightCornerX andConstant:2.0];
    NSLog(@"diem cua mat:%.2f", pointWidthRightEyeAndWidthLeftAndRightEye);
    
    //Calc width
    double pointHeightNoseAndHeightFace = [TestFunction convertPointWithPosition:faceAnalyst.noseContourLeft1Y andPos:faceAnalyst.noseContourLowerMiddleY andPos:faceAnalyst.faceRectangleHeight andPos:0.0 andConstant:2.5];
    NSLog(@"diem cua mui :%.2f", pointHeightNoseAndHeightFace);
    
    

}

#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    _imageView.image = image;
    
    TestAPIFaceFetcher *testApi = [[TestAPIFaceFetcher alloc]init];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Caculating";
    
    [testApi beginFetcherWithKey:nil secret:nil imageFile:image complete:^(NSArray *results) {
        NSLog(@"ket qua%@",results);
        for (APIFaceAnalystEntity *entity in results) {
            [self.txtAge setText:[NSString stringWithFormat:@"Age:%@",entity.age]];
            [self.txtSex setText:[NSString stringWithFormat:@"Sex:%@",entity.gender]];
            double point = [TestFunction convertPhilNumberWithPositon:entity.rightEyeCenterY andPos:entity.noseContourLeft2Y andPos:entity.noseContourLowerMiddleY];
            [self.txtPoint setText:[NSString stringWithFormat:@"%0.f/10",point]];
            NSLog(@"diem so%f",point);
            //            CGRect *rec = CGRectMake(entity.rightEyeCenterX,entity.rightEyeCenterY, entity.width, aSize.height);
            //            [self drawRect:rec];
        }
        [hud hide:YES];
    } error:^(NSError *error) {
        //
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    _imageView.image = image;
    //    TestAPIFaceFetcher *testApi = [[TestAPIFaceFetcher alloc]init];
    //    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.mode = MBProgressHUDModeAnnularDeterminate;
    //    hud.labelText = @"Caculating";
    //    [testApi beginFetcherWithKey:nil secret:nil imageFile:image complete:^(NSArray *results) {
    //        NSLog(@"ket qua%@",results);
    //        for (APIFaceAnalystEntity *entity in results) {
    //            [self.txtAge setText:[NSString stringWithFormat:@"Age:%@",entity.age]];
    //            [self.txtSex setText:[NSString stringWithFormat:@"Sex:%@",entity.gender]];
    //            double point = [TestFunction convertPhilNumberWithPositon:entity.rightEyeCenterY andPos:entity.noseContourLeft2Y andPos:entity.noseContourLowerMddleY];
    //            [self.txtPoint setText:[NSString stringWithFormat:@"%0.f/10",point]];
    //            NSLog(@"diem so%f",point);
    //        }
    //        [hud hide:YES];
    //    } error:^(NSError *error) {
    //        //
    //    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Actions


#pragma mark -
#pragma mark - Private methods

- (void)clearTapped
{
    _imageView.image = nil;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10.0, 10.0)];
    [path addLineToPoint:CGPointMake(100.0, 100.0)];
    path.lineWidth = 3;
    [[UIColor blueColor] setStroke];
    [path stroke];
}
-(void)drawLine {
    UIView *myBox  = [[UIView alloc] initWithFrame:CGRectMake(180, 35, 10, 10)];
    myBox.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:myBox];
}
@end
