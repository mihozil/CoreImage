//
//  CIColorInvert.h
//  CoreImage
//
//  Created by Apple on 1/25/16.
//  Copyright © 2016 AMOSC. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface CIColorInvert : CIFilter
- (UIImage*) imagefromSepToneFilterwithInputIntensity:(float)intensity andImage:(UIImage*)image;
// CISpotColor ; CIMedianFilter
- (UIImage*) imagefromColorMonochromewithInputIntensity:(float)intensity andImage:(UIImage*)image;

- (UIImage*) imagefromVibranceFilterwithInputIntensity:(float)intensity andImage:(UIImage*)image;


@end
