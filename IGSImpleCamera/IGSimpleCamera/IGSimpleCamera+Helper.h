//
//  IGSimpleCamera+Helper.h
//  IGSimpleCamera
//
//  Created by Isha Goel on 07/12/18.
//  Copyright © 2018 Isha Goel. All rights reserved.
//

#import "IGSimpleCamera.h"

@interface IGSimpleCamera (Helper)

- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates
                                          previewLayer:(AVCaptureVideoPreviewLayer *)previewLayer
                                                 ports:(NSArray<AVCaptureInputPort *> *)ports;

- (UIImage *)cropImage:(UIImage *)image usingPreviewLayer:(AVCaptureVideoPreviewLayer *)previewLayer;

@end
