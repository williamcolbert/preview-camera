//
//  PreviewCameraViewController.m
//  PreviewCamera
//
//  Created by William  Colbert on 8/28/13.
//  Copyright (c) 2013 Uplift Ideas. All rights reserved.
//

#import "PreviewCameraViewController.h"

@interface PreviewCameraViewController ()

@end

@implementation PreviewCameraViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Run session setup after subviews are laid out.
- (void)viewDidLayoutSubviews
{
    // Create AVCaptureSession and set the quality of the output
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    // Get the Back Camera Device, init a AVCaptureDeviceInput linking the Device and add the input to the session.
    self.videoDevice = [self backCamera];
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:nil];
    [self.session addInput:self.videoInput];
    
    // Insert code to add still image output here
    
    // Init the AVCaptureVideoPreviewLayer with our created session. Get the UIView layer
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    CALayer *viewLayer = self.previewView.layer;
    
    // Set the AVCaptureVideoPreviewLayer bounds to the main view bounds and fill it accordingly. Add as sublayer to the main UIView
    [viewLayer setMasksToBounds:YES];
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    captureVideoPreviewLayer.frame = [viewLayer bounds];
    [viewLayer addSublayer:captureVideoPreviewLayer];
    
    // Start Running the Session 
    [self.session startRunning];
}


// Utility Function to get the front camera device
- (AVCaptureDevice *)frontCamera
{
    
    //Get all available devices, loop through and get the front position camera
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == AVCaptureDevicePositionFront)
        {
            return device;
        }
    }
    return nil;
}

// Utility Function to get the back camera device
- (AVCaptureDevice *)backCamera
{
    //Get all available devices, loop through and get the back position camera
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == AVCaptureDevicePositionBack)
        {
            return device;
        }
    }
    return nil;
}



- (IBAction)switchCamera:(id)sender {
    AVCaptureDevicePosition desiredPosition;
    
    // Get the opposite camera device of current
    if (self.isUsingFrontFacingCamera)
        desiredPosition = AVCaptureDevicePositionBack;
    else
        desiredPosition = AVCaptureDevicePositionFront;
    
    
    //Loop through available devices and select the one of our desiredPosition
    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo])
    {
        if ([device position] == desiredPosition)
        {
            // Begin a Configuration Change
            [self.session beginConfiguration];
            
            // Init new input as AVCaptureDeviceInput and remove the old input/.
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            for (AVCaptureInput *oldInput in [self.session inputs])
            {
                [self.session removeInput:oldInput];
            }
            
            // Add new input to session and commit the configuartion changes.
            [self.session addInput:input];
            [self.session commitConfiguration];
            break;
        }
    }
    
    self.isUsingFrontFacingCamera = !self.isUsingFrontFacingCamera;
}
@end











