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

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *txtAge;
@property (weak, nonatomic) IBOutlet UILabel *txtSex;
@property (weak, nonatomic) IBOutlet UILabel *txtPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing =YES;
    imagePicker.sourceType =UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePicker animated:NO completion:nil];
}

- (IBAction)tapGetPhotos:(id)sender {
    [self resetLabelInfo];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     [self presentViewController:picker animated:NO completion:nil];
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
        UIImage *photoTaken = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
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

- (void)
@end
