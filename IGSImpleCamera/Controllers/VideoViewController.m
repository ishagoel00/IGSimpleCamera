//
//  VideoViewController.m
//  IGSImpleCamera
//
//  Created by Isha Goel on 07/12/18.
//  Copyright © 2018 Isha Goel. All rights reserved.
//

#import "VideoViewController.h"
@import AVFoundation;

@interface VideoViewController ()

@property (strong, nonatomic) NSURL *videoUrl;
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) AVPlayerLayer *avPlayerLayer;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *repeatButton;
@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation VideoViewController

- (instancetype)initWithVideoUrl:(NSURL *)url {
    self = [super init];
    if(self) {
        _videoUrl = url;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // the video player
    self.avPlayer = [AVPlayer playerWithURL:self.videoUrl];
    self.avPlayer.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.avPlayerLayer.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height);
    [self.view.layer addSublayer:self.avPlayerLayer];
    
    // cancel button
    [self.view addSubview:self.cancelButton];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.frame = CGRectMake(0, screenRect.size.height-50, 100, 50);
    
    // repeat button
    [self.view addSubview:self.repeatButton];
    [self.repeatButton addTarget:self action:@selector(repeatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.repeatButton.frame = CGRectMake(screenRect.size.width/2-60, screenRect.size.height-50, 120, 50);
    
    // save button
    [self.view addSubview:self.saveButton];
    [self.saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.saveButton.frame = CGRectMake(screenRect.size.width-100, screenRect.size.height-50, 100, 50);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.avPlayer play];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

// Button actions

- (UIButton *)cancelButton {
    if(!_cancelButton) {
        UIImage *cancelImage = [UIImage imageNamed:@"cancel.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tintColor = [UIColor whiteColor];
        [button setImage:cancelImage forState:UIControlStateNormal];
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
        button.imageView.clipsToBounds = NO;
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.4f;
        button.layer.shadowRadius = 1.0f;
        button.clipsToBounds = NO;
        
        _cancelButton = button;
    }
    
    return _cancelButton;
}

- (UIButton *)repeatButton {
    if(!_repeatButton) {
        UIImage *repeatImage = [UIImage imageNamed:@"repeat.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tintColor = [UIColor whiteColor];
        [button setImage:repeatImage forState:UIControlStateNormal];
        [button setTitle:@"Repeat" forState:UIControlStateNormal];
        button.imageView.clipsToBounds = NO;
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.4f;
        button.layer.shadowRadius = 1.0f;
        button.clipsToBounds = NO;
        
        _repeatButton = button;
    }
    
    return _repeatButton;
}

- (UIButton *)saveButton {
    if(!_saveButton) {
        UIImage *saveImage = [UIImage imageNamed:@"save.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tintColor = [UIColor whiteColor];
        [button setImage:saveImage forState:UIControlStateNormal];
        [button setTitle:@"Save" forState:UIControlStateNormal];
        button.imageView.clipsToBounds = NO;
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        button.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        button.layer.shadowOpacity = 0.4f;
        button.layer.shadowRadius = 1.0f;
        button.clipsToBounds = NO;
        
        _saveButton = button;
    }
    
    return _saveButton;
}

- (void)cancelButtonPressed:(UIButton *)button {
    NSLog(@"cancel button pressed!");
    [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"Crossed"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)repeatButtonPressed:(UIButton *)button {
    NSLog(@"repeat button pressed!");
    AVPlayerItem *p = [self.avPlayer currentItem];
    [p seekToTime:kCMTimeZero];
}

- (void)saveButtonPressed:(UIButton *)button {
    NSLog(@"save button pressed!");

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:_videoUrl]) {
        [library writeVideoAtPathToSavedPhotosAlbum:_videoUrl
                                    completionBlock:^(NSURL *assetURL, NSError *error){
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            if (error) {
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Video Saving Failed"  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil, nil];
                                                [alert show];
                                            }else{
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Video successfully saved" message:@"Saved To Photo Album"  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                [alert show];
                                            }
                                        });
                                    }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[NSUserDefaults standardUserDefaults]setValue:@"Yes" forKey:@"Crossed"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
