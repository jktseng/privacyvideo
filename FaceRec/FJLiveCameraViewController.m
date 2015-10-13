//
//  ViewController.m
//  opencvtest
//
//  Created by Engin Kurutepe on 16/01/15.
//  Copyright (c) 2015 Fifteen Jugglers Software. All rights reserved.
//

#import "FJLiveCameraViewController.h"
#import "FJFaceDetector.h"
#import "FJFaceRecognitionViewController.h"
@interface FJLiveCameraViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *switchCamera;
@property (nonatomic, strong) FJFaceDetector *faceDetector;



@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) RPPreviewViewController *previewViewController;
@end

@implementation FJLiveCameraViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.faceDetector = [[FJFaceDetector alloc] initWithCameraView:_cameraView scale:2.0 camera:1];
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(handleTap:)];
    [self.view addGestureRecognizer:_tapGestureRecognizer];
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.faceDetector startCapture];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.faceDetector stopCapture];
}

- (void)handleTap:(UITapGestureRecognizer *)tapGesture {
    NSArray *detectedFaces = [self.faceDetector.detectedFaces copy];
    CGSize windowSize = self.view.bounds.size;
    BOOL record = true;
    for (NSValue *val in detectedFaces) {
        record = false;
        CGRect faceRect = [val CGRectValue];
        
        CGPoint tapPoint = [tapGesture locationInView:nil];
        //scale tap point to 0.0 to 1.0
        CGPoint scaledPoint = CGPointMake(tapPoint.x/windowSize.width, tapPoint.y/windowSize.height);
        if(CGRectContainsPoint(faceRect, scaledPoint)){
            NSLog(@"tapped on face: %@", NSStringFromCGRect(faceRect));
            UIImage *img = [self.faceDetector faceWithIndex:[detectedFaces indexOfObject:val]];
            [self performSegueWithIdentifier:@"RecognizeFace" sender:img];
            break;
        }
        else {
            record = true;
            NSLog(@"tapped on no face");
        }
    }
    if (record == true) {
        [self recordScreen];
    }
}
- (IBAction)switchCamera:(id)sender {
    [[self faceDetector] switchCamera];
}

- (void)recordScreen {
    RPScreenRecorder *sharedRecorder = RPScreenRecorder.sharedRecorder;
    if(sharedRecorder.isRecording) {
        RPScreenRecorder *sharedRecorder = RPScreenRecorder.sharedRecorder;
        [sharedRecorder stopRecordingWithHandler:^(RPPreviewViewController *previewViewController, NSError *error) {
            if (error) {
                NSLog(@"stopScreenRecording: %@", error.localizedDescription);
            } else {
                self.switchCamera.userInteractionEnabled = YES;
                self.switchCamera.enabled = YES;
                self.switchCamera.hidden = NO;
                if (previewViewController) {
                    previewViewController.previewControllerDelegate = self;
                    self.previewViewController = previewViewController;
                
                    // RPPreviewViewController only supports full screen modal presentation.
                    self.previewViewController.modalPresentationStyle = UIModalPresentationFullScreen;
                
                    [self.view.window.rootViewController presentViewController:previewViewController animated:YES completion:nil];
                }
            }
        }];
    } else {
        self.switchCamera.userInteractionEnabled = NO;
        self.switchCamera.enabled = NO;
        self.switchCamera.hidden = YES;
        sharedRecorder.delegate = self;
        [sharedRecorder startRecordingWithMicrophoneEnabled:YES handler:^(NSError *error) {
            if (error) {
                NSLog(@"startScreenRecording: %@", error.localizedDescription);
            }
        }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"RecognizeFace"]) {
        NSAssert([sender isKindOfClass:[UIImage class]],@"RecognizeFace segue MUST be sent with an image");
        FJFaceRecognitionViewController *frvc = segue.destinationViewController;
        frvc.inputImage = sender;

    }
}

#pragma mark - RPScreenRecorderDelegate

- (void)screenRecorder:(RPScreenRecorder *)screenRecorder didStopRecordingWithError:(NSError *)error previewViewController:(nullable RPPreviewViewController *)previewViewController {
    // handle error which caused unexpected stop of recording
}

- (void)screenRecorderDidChangeAvailability:(RPScreenRecorder *)screenRecorder {
    // handle screen recorder availability changes
}

#pragma mark - RPPreviewViewControllerDelegate

- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    [previewController dismissViewControllerAnimated:YES completion:nil];
}


@end
