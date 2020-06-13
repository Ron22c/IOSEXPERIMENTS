//
//  protocolViewController.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "protocolViewController.h"
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface protocolViewController ()
{
    UIImageView *imView;
}
@end

@implementation protocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self.delegate printVCName];
//    [self.navigationController popViewControllerAnimated:YES];
    imView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 200, 300, 300)];
    
    UIImage *img1 = [UIImage imageNamed:@"1.jpg"];
    UIImage *img2 = [UIImage imageNamed:@"2.jpg"];
    NSArray *images = [NSArray arrayWithObjects:img1,img2, nil];
    [imView setBackgroundColor:[UIColor redColor]];
    [imView setAnimationImages:images];
    [imView setAnimationDuration:1.0];
//    [imView startAnimating];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width, 100)];
    [btn setTitle:@"pick Image" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imView];
    [self.view addSubview:btn];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)btnAction:(UIButton *)btn {
    NSLog(@"button preseed");
    UIImagePickerController *contorller = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"camera available");
        [contorller setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        NSLog(@"camera not available");
        [contorller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [contorller setAllowsEditing:NO];
    contorller.delegate=self;
    
    [self presentViewController:contorller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    NSLog(@"picked image");
    [imView setImage:[info valueForKey:UIImagePickerControllerOriginalImage]];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
