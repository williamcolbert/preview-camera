//
//  PreviewCameraViewController.h
//  PreviewCamera
//
//  Created by William  Colbert on 8/28/13.
//  Copyright (c) 2013 Uplift Ideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PreviewCameraViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *previewView;
- (IBAction)switchCamera:(id)sender;

@property (strong, nonatomic) AVCaptureSession *session;
@property (strong) AVCaptureDevice *videoDevice;
@property (strong) AVCaptureDeviceInput *videoInput;
@property (strong) AVCaptureStillImageOutput *stillImageOutput;
@property BOOL isUsingFrontFacingCamera;

- (AVCaptureDevice *) backCamera;
- (AVCaptureDevice *) frontCamera;

@end
