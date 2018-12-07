//
//  UIImage+Resize.h
//  IGSImpleCamera
//
//  Created by Isha Goel on 07/12/18.
//  Copyright © 2018 Isha Goel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage_Resize : UIImage

-(UIImage*)resizedImageToSize:(CGSize)dstSize;

-(UIImage*)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

@end
