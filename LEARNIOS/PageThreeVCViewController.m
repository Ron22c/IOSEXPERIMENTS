//
//  PageThreeVCViewController.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 11/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "PageThreeVCViewController.h"

@interface PageThreeVCViewController ()

typedef int (^executeThis) (int, int);

@end

@implementation PageThreeVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.spinner.hidesWhenStopped=YES;
    [self.spinner stopAnimating];
    self.progresbar.progress=0.0;
}

- (void)viewDidAppear:(BOOL)animated {
    executeThis block;
    
    block = ^(int num1, int num2) {
        NSLog(@"we are inside a block");
        [self.switchVar setOn:NO];
        return num1+num2;
    };
    
    int ans = [self executeMethodToGetOutput:block];
    NSLog(@"we are outside a block, value is : %d", ans);
    
    [self executeMethodToGetOutput:^int(int a, int b) {
        return a*345+2345-5;
    }];
}

- (int)executeMethodToGetOutput:(executeThis) block {
    int a = block(34,56);
    return a+100;
    
}

- (IBAction)button1:(id)sender {
    NSLog(@"pressed 1st button");
    [_spinner startAnimating];
}

- (IBAction)steper:(id)sender {
    NSLog(@"stepper value %f", _steperVar.value);
    [self.progresbar setProgress:self.progresbar.progress+0.01 animated:YES];

}

- (IBAction)button2:(id)sender {
    NSLog(@"pressed 2st button");
    [_spinner stopAnimating];

}

- (IBAction)switch:(id)sender {
    NSLog(@"pressed switch button, value: nil");
}
@end
