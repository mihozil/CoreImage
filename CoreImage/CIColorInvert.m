//
//  CIColorInvert.m
//  CoreImage
//
//  Created by Apple on 1/25/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import "CIColorInvert.h"

@implementation CIColorInvert


-(UIImage*) imagefromSepToneFilterwithInputIntensity:(float)intensity andImage:(UIImage*)image{
    NSNumber*numberInternsity = [NSNumber numberWithFloat:intensity];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, inputImage,
                        @"inputIntensity", numberInternsity, nil];
    
    CIImage*outputImage = [filter outputImage];
    
    CIContext*context = [CIContext contextWithOptions:nil];
    
    CGImageRef imgRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage*doneImage = [[UIImage alloc]initWithCGImage:imgRef];
    
    
    return doneImage;
}

- (UIImage *)imagefromColorMonochromewithInputIntensity:(float)intensity andImage:(UIImage *)image {
    NSNumber *intensityNumber = [NSNumber numberWithFloat:intensity];
    
    CIImage*inputImage = [[CIImage alloc]initWithImage:image];
    
    CIFilter*filter = [CIFilter filterWithName:@"CIColorMonochrome"
                                 keysAndValues:
                       kCIInputImageKey,inputImage,
                       @"inputIntensity", intensityNumber,
                       nil];
    CIImage*outputImage = filter.outputImage;
    
    CIContext*context = [CIContext contextWithOptions:nil];
    CGImageRef imgRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *doneImage = [[UIImage alloc]initWithCGImage:imgRef];
    
    return doneImage;
}

- (UIImage *)imagefromVibranceFilterwithInputIntensity:(float)intensity andImage:(UIImage *)image{
    NSNumber*intensityNumber = [NSNumber numberWithFloat:intensity];
    
    CIImage*inputImage = [[CIImage alloc]initWithImage:image];
    CIFilter*filter = [CIFilter filterWithName:@"CIVibrance" keysAndValues:
                       kCIInputImageKey,inputImage,
                       @"inputAmount",intensityNumber,
                       nil];
    CIImage*outputImage =filter.outputImage;
    
    CIContext*context = [CIContext contextWithOptions:nil];
    CGImageRef imgRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage*doneImage = [[UIImage alloc]initWithCGImage:imgRef];
    
    return doneImage;
}
@end
