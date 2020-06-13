//
//  VideoViewController.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface VideoViewController ()<NSURLSessionDownloadDelegate>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://reqres.in/api/users"]
                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"response is: %@", response);
        NSDictionary *datadict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"data is: %@", [datadict objectForKey:@"data"]);
    }];
    
    [task resume];
    
    NSURL *url=[NSURL URLWithString:@"https://d2h452d9fuy6ob.cloudfront.net/1586245293.mp4"];
    NSURLSessionDownloadTask *taskDown = [[NSURLSession sessionWithConfiguration:
                                        [NSURLSessionConfiguration defaultSessionConfiguration]
                                                                        delegate:self
                                                                   delegateQueue:[NSOperationQueue mainQueue]] downloadTaskWithURL:url];
    [taskDown resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
                              didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"location is %@", location);

    NSString *videoPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSFileManager *manager = NSFileManager.defaultManager;
    
    NSURL *url = [NSURL URLWithString:[videoPath stringByAppendingPathComponent:@"video.mp4"]];
    if([manager fileExistsAtPath:[location path]]) {
        [manager replaceItemAtURL:url withItemAtURL:location
                   backupItemName:nil
                          options:NSFileManagerItemReplacementUsingNewMetadataOnly
                 resultingItemURL:nil
                            error:nil];
        UISaveVideoAtPathToSavedPhotosAlbum([url path], nil, nil, nil);
    }
}

- (void)URLSession:(NSURLSession *)session  downloadTask:(NSURLSessionDownloadTask *)downloadTask
                                            didWriteData:(int64_t)bytesWritten
                                       totalBytesWritten:(int64_t)totalBytesWritten
                               totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    NSLog(@"downloaded %lld",totalBytesWritten);
}

- (void)viewDidAppear:(BOOL)animated {
    
    UIButton *playvideo = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width/2, 100)];
    [playvideo setTitle:@"PLAY VIDEO" forState:UIControlStateNormal];
    [playvideo addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playvideo];
    
    UIButton *getvideo = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 200, self.view.bounds.size.width/2, 100)];
    [getvideo setTitle:@"CAPTURE VIDEO" forState:UIControlStateNormal];
    [getvideo addTarget:self action:@selector(getVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getvideo];
}

- (void)playVideo:(UIButton *)sender {
    NSLog(@"video play nortification");
    AVPlayerViewController *avcontroller = [[AVPlayerViewController alloc] init];
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"12" ofType:@"mp4"];
    NSURL *video = [NSURL fileURLWithPath:videoPath];
    AVPlayer *player = [AVPlayer playerWithURL:video];
    [avcontroller setPlayer:player];
    [self presentViewController:avcontroller animated:YES completion:nil];
}

- (void)getVideo:(UIButton *)sender {
    NSLog(@"video get nortification");
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.mediaTypes=[NSArray arrayWithObject:(NSString *)kUTTypeMovie];
    picker.delegate=self;

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    } else {
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    AVPlayerViewController *VC = [[AVPlayerViewController alloc]init];
    NSURL *videourl = (NSURL *)[info objectForKey:UIImagePickerControllerMediaURL];
    [self dismissViewControllerAnimated:YES completion:nil];
    AVPlayer *player = [AVPlayer playerWithURL: videourl];
    VC.player=player;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 300)];
    VC.view.frame=view.frame;
    [self addChildViewController:VC];
    [self.view addSubview:VC.view];
}


@end
