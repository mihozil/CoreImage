//
//  ViewController.m
//  CoreImage
//
//  Created by Apple on 1/24/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "ViewController.h"
#import "CIColorInvert.h"

@interface ViewController () <UIImagePickerControllerDelegate,UIActionSheetDelegate, UIAlertViewDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, strong) UIImage*currentImage;

@end

@implementation ViewController{
    UIActivityIndicatorView *activityView;
    float width;
    float height;
    NSInteger effectIndex;
    
    UIActionSheet*popup;
    UIActionSheet*effectPopup;
}
- (void) initProject{
    width = self.view.bounds.size.width;
    height = self.view.bounds.size.height - 64;
    
    popup = [[UIActionSheet alloc]initWithTitle:@"Get your picture"
                                       delegate:self cancelButtonTitle:@"Cancel"
                         destructiveButtonTitle:nil
                              otherButtonTitles:@"Take a picture",
             @"Your library",nil];
    popup.tag = 1;
    
    effectPopup = [[UIActionSheet alloc]initWithTitle:@"Pick effect"
                                             delegate:self
                                    cancelButtonTitle:@"Cancel"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@"Septone Filter", @"ColorMonochrome",@"Vibrance", nil];
    effectPopup.tag = 2;
    
    
    
    self.imgView.image = [UIImage imageNamed:@"ellytran.jpg"];
    self.currentImage =self.imgView.image;
    
    activityView = [UIActivityIndicatorView new];
    activityView.center = self.view.center;
    [self.view addSubview:activityView];
    [activityView stopAnimating];
    
    effectIndex = 0;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initProject];
    
    NSArray* filters = [CIFilter filterNamesInCategories:nil];
     for (NSString* filterName in filters)
        if ([filterName isEqualToString:@"CIColorMonochrome"])
    {
        NSLog(@"Filter: %@", filterName);
        NSLog(@"Parameters: %@", [[CIFilter filterWithName:filterName] attributes]);
    }

}

- (IBAction)saveButton:(id)sender {
    // begin activity View
    [activityView startAnimating];
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
   
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // End activity View
    [activityView stopAnimating];
    UIAlertView*alertView = [[UIAlertView alloc]initWithTitle:@"Save" message:@"Your image is saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [alertView show];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag==1){
        
        UIImagePickerController*imagePicker = [UIImagePickerController new];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = true;
        
        switch (buttonIndex) {
            case 0:
                // Take photo from camera
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePicker animated:true completion:nil];
                    
                }else{
                    UIAlertView*alertView = [[UIAlertView alloc]initWithTitle:@"Camera Error" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
                break;
                
            case 1:
                // get photo from library
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:true completion:nil];
                
                break;
                
            default:
                break;
        }

        
    }
    
    if (actionSheet.tag == 2){
        effectIndex = buttonIndex;
        
    }
    
}
- (IBAction)albumButton:(id)sender {
    [popup showInView:self.view];
    
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage*selectedImage = info[UIImagePickerControllerEditedImage];
    self.imgView.image = selectedImage;
    self.currentImage = selectedImage;
    self.slider.value = 0;
//    [self performSelector:@selector(imageChanging) withObject:nil afterDelay:4];

    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (void) imageChanging{
//    self.imgView.image = [UIImage imageNamed:@"ellytran.jpg"];
//}
- (IBAction)sliderEffect:(id)sender {
    float slidervalue = self.slider.value;
    
    CIColorInvert*colorInvert = [CIColorInvert new];

    
    switch (effectIndex) {
        case 0:
            self.imgView.image = [colorInvert imagefromSepToneFilterwithInputIntensity:slidervalue andImage:self.currentImage];
            break;
        
        case 1:
            self.imgView.image = [colorInvert imagefromColorMonochromewithInputIntensity:slidervalue andImage:self.currentImage];
            break;
        
        case 2:
            
            self.imgView.image = [colorInvert imagefromVibranceFilterwithInputIntensity:slidervalue andImage:self.currentImage];
            break;
        default:
            break;
    }
}

- (IBAction)chooseeffectButton:(id)sender {
    self.slider.value = 0;
    self.imgView.image = self.currentImage;
    [effectPopup showInView:self.view];
    
}
@end
