//
//  FJFaceRecognitionViewController.m
//  opencvtest
//
//  Created by Engin Kurutepe on 28/01/15.
//  Copyright (c) 2015 Fifteen Jugglers Software. All rights reserved.
//

#import "FJFaceRecognitionViewController.h"
#import "FJFaceRecognizer.h"

@interface FJFaceRecognitionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *inputImageView;
@property (weak, nonatomic) IBOutlet UIButton *exitWIthoutSave;
@property (nonatomic, strong) NSMutableArray *positiveFaces;
@property (nonatomic, strong) FJFaceRecognizer *faceModel;
@end

@implementation FJFaceRecognitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _inputImageView.image = _inputImage;
    
    NSURL *modelURL = [FJFaceRecognitionViewController faceModelFileURL];
    self.faceModel = [FJFaceRecognizer faceRecognizerWithFile:[modelURL path]];
    
    double confidence;
    
    if (_faceModel.labels.count == 0) {
        [_faceModel updateWithFace:_inputImage name:@"Person 1"];
    }

    NSString *name = [_faceModel predict:_inputImage confidence:&confidence];
    
    _nameLabel.text = name;
    _positiveFaces = [[NSMutableArray alloc] init];
    
}

+ (FJFaceRecognizer *) getFaceModel {
    NSURL *modelURL = [self faceModelFileURL];
    return [FJFaceRecognizer faceRecognizerWithFile:[modelURL path]];
}

+ (NSURL *) faceModelFileURL {
    NSArray *paths = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [paths lastObject];
    NSURL *modelURL = [documentsURL URLByAppendingPathComponent:@"face-model.xml"];
    return modelURL;
}

- (IBAction)wrongPhotoTaken:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapCorrect:(id)sender {
    //Positive feedback for the correct prediction
    if ([[FJFaceRecognitionViewController loadData] count] == 0) {
        [[self positiveFaces] addObject:_nameLabel.text];
        [self saveData:_positiveFaces];
    } else {
        _positiveFaces = [FJFaceRecognitionViewController loadData];
        NSLog(@"%@",_nameLabel.text);
        if (![_positiveFaces containsObject:_nameLabel.text]) {
            [[self positiveFaces] addObject:_nameLabel.text];
            [self saveData:_positiveFaces];
        }
    }
    [_faceModel updateWithFace:_inputImage name:_nameLabel.text];
    [_faceModel serializeFaceRecognizerParamatersToFile:[[FJFaceRecognitionViewController faceModelFileURL] path]];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapWrong:(id)sender {
    //Update our face model with the new person
    if ([[FJFaceRecognitionViewController loadData] count] != 0) {
        _positiveFaces = [FJFaceRecognitionViewController loadData];
        NSLog(@"%@",_nameLabel.text);
        if (![_positiveFaces containsObject:_nameLabel.text]) {
            [[self positiveFaces] removeObject:_nameLabel.text];
        }
    }
    NSString *name = [@"Person " stringByAppendingFormat:@"%lu", (unsigned long)_faceModel.labels.count];
    [_faceModel updateWithFace:_inputImage name:name];
    [_faceModel serializeFaceRecognizerParamatersToFile:[[FJFaceRecognitionViewController faceModelFileURL] path]];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveData :(NSMutableArray *)dataArray
{
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    NSString *dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                                stringByAppendingPathComponent: @"data.archive"]];
    
    [NSKeyedArchiver archiveRootObject:
     dataArray toFile:dataFilePath];
}


+ (NSMutableArray *)loadData
{
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    NSString *dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                                stringByAppendingPathComponent: @"data.archive"]];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFilePath])
    {
        NSMutableArray *dataArray;
        
        dataArray = [NSKeyedUnarchiver
                     unarchiveObjectWithFile: dataFilePath];
        
        return dataArray;
    }
    return NULL;
}
@end
