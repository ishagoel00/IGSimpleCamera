//
//  IGSimpleCamera.h
//  IGSImpleCamera
//
//  Created by Isha Goel on 07/12/18.
//  Copyright © 2018 Isha Goel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum : NSUInteger {
    IGCameraPositionRear,
    IGCameraPositionFront
} IGCameraPosition;

typedef enum : NSUInteger {
    // Camera Flash Setting, default is off
    IGCameraFlashOff,
    IGCameraFlashOn,
    IGCameraFlashAuto
} IGCameraFlash;

typedef enum : NSUInteger {
    // Camera Flash Setting, default is off
    IGCameraMirrorOff,
    IGCameraMirrorOn,
    IGCameraMirrorAuto
} IGCameraMirror;

extern NSString *const IGSimpleCameraErrorDomain;
typedef enum : NSUInteger {
    IGSimpleCameraErrorCodeCameraPermission = 10,
    IGSimpleCameraErrorCodeMicrophonePermission = 11,
    IGSimpleCameraErrorCodeSession = 12,
    IGSimpleCameraErrorCodeVideoNotEnabled = 13
} IGSimpleCameraErrorCode;

@interface IGSimpleCamera : UIViewController

// on device change it triggered.
@property (nonatomic, copy) void (^onDeviceChange)(IGSimpleCamera *camera, AVCaptureDevice *device);

// on any kind of error it triggered.
@property (nonatomic, copy) void (^onError)(IGSimpleCamera *camera, NSError *error);

// when camera recording starts it triggered.
@property (nonatomic, copy) void (^onStartRecording)(IGSimpleCamera* camera);

// For Camera quality
@property (copy, nonatomic) NSString *cameraQuality;

// flash mode.
@property (nonatomic, readonly) IGCameraFlash flash;

// mirror mode.
@property (nonatomic) IGCameraMirror mirror;

// Position of camera.
@property (nonatomic) IGCameraPosition position;

// White balance mode, default is AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance
@property (nonatomic) AVCaptureWhiteBalanceMode whiteBalanceMode;

// check if the video is enable or not.
@property (nonatomic, getter=isVideoEnabled) BOOL videoEnabled;

//check if the camera is currently recording a video or not.
@property (nonatomic, getter=isRecording) BOOL recording;

// check if zooming is enable or not.
@property (nonatomic, getter=isZoomingEnabled) BOOL zoomingEnabled;

// For setting scaling factor.
@property (nonatomic, assign) CGFloat maxScale;

// fix Orientation After Capture.
@property (nonatomic) BOOL fixOrientationAfterCapture;

// trigger focusing, default is enabled = NO.
@property (nonatomic) BOOL tapToFocus;

// Allow autorotation,default is disable
@property (nonatomic) BOOL useDeviceOrientation;

// To request camera initalizing permission.
+ (void)requestCameraPermission:(void (^)(BOOL granted))completionBlock;

// To request microphone initalizing permission.
+ (void)requestMicrophonePermission:(void (^)(BOOL granted))completionBlock;

// Define quality.
- (instancetype)initWithQuality:(NSString *)quality position:(IGCameraPosition)position videoEnabled:(BOOL)videoEnabled;

// enable video recording.
- (instancetype)initWithVideoEnabled:(BOOL)videoEnabled;

// start camera.
- (void)start;

// stop camera.
- (void)stop;


// Image Capturing with exact size as the preview and animation.
-(void)capture:(void (^)(IGSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture exactSeenImage:(BOOL)exactSeenImage animationBlock:(void (^)(AVCaptureVideoPreviewLayer *))animationBlock;

// Image Capturing with exact size as the preview.
-(void)capture:(void (^)(IGSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture exactSeenImage:(BOOL)exactSeenImage;

// Image Capturing.
-(void)capture:(void (^)(IGSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture;

// recording video and make url of that.
- (void)startRecordingWithOutputUrl:(NSURL *)url didRecord:(void (^)(IGSimpleCamera *camera, NSURL *outputFileUrl, NSError *error))completionBlock;

// Stop video recording.
- (void)stopRecording;

// Attaches IGSimpleCamera to another view controller as a child.
- (void)attachToViewController:(UIViewController *)vc withFrame:(CGRect)frame;

// Change posiition of camera - front or back.
- (IGCameraPosition)togglePosition;

// Update the flash mode.
- (BOOL)updateFlashMode:(IGCameraFlash)cameraFlash;

// Checking flash availablity.
- (BOOL)isFlashAvailable;

// Checking torch availablity.
- (BOOL)isTorchAvailable;

// Alter layer and the animation.
- (void)alterFocusBox:(CALayer *)layer animation:(CAAnimation *)animation;

// Checking front camera availablity.
+ (BOOL)isFrontCameraAvailable;

// Checking rear camera availablity.
+ (BOOL)isRearCameraAvailable;
@end
