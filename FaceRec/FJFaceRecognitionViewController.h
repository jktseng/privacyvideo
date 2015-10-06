//
//  FJFaceRecognitionViewController.h
//  opencvtest
//
//  Created by Engin Kurutepe on 28/01/15.
//  Copyright (c) 2015 Fifteen Jugglers Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJFaceRecognizer.h"

@interface FJFaceRecognitionViewController : UIViewController

@property (nonatomic, strong) UIImage *inputImage;

+ (FJFaceRecognizer *) getFaceModel;
+ (NSURL *)faceModelFileURL;
+ (NSMutableArray *)loadData;

@end
