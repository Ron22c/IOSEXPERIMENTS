//
//  PageFiveVC.m
//  LEARNIOS
//
//  Created by Ranajit Chandra on 12/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "PageFiveVC.h"

@interface PageFiveVC () <UITextFieldDelegate>{
    UILabel *label;
    UIButton *btn;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    CMMotionManager *manager;
}

@end

@implementation PageFiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 50)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(buttenPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 200, 100)];
    [self.view addSubview:label];
    
    btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height/50)];
    [btn2 setBackgroundColor:[UIColor blueColor]];
    [btn2 setTitle:@"COREMOTION FRAMEWORK USE ACCELEROMETER" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    NSLog(@"height is %f", 200+self.view.bounds.size.height/50);
    
    btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200+10+self.view.bounds.size.height/50,
                                                     self.view.bounds.size.width, self.view.bounds.size.height/50)];
    [btn3 setBackgroundColor:[UIColor blueColor]];
    [btn3 setTitle:@"COREMOTION FRAMEWORK USE GYROSCOPE" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3Action:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    NSLog(@"height is %f", 200+(self.view.bounds.size.height/50)*2);
    
    btn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 200+(10+self.view.bounds.size.height/50)*2,
                                                     self.view.bounds.size.width, self.view.bounds.size.height/50)];
    [btn4 setBackgroundColor:[UIColor blueColor]];
    [btn4 setTitle:@"COREMOTION FRAMEWORK USE MAGNETOMETER" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4Action:) forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    NSLog(@"height is %f", 200+(self.view.bounds.size.height/50)*3);
}

- (void)viewDidAppear:(BOOL)animated {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
        [controller setTitle:@"HELLO"];
        [controller setSubject:@"GOOD MORNING"];
        [controller setToRecipients:@[@"rjc22aug@gmail.com"]];
    }
}

- (void)stepperAction:(UIStepper *)sender {
    NSLog(@"clicked");
    NSLog(@"%f",sender.value);
    [label setText:[NSString stringWithFormat:@"%f",sender.value]];
}

- (void)buttenPressed:(UIButton *)sender {
    NSLog(@"button pressed");
    UIStepper *steeper = [[UIStepper alloc]init];
    [steeper addTarget:self action:@selector(stepperAction:) forControlEvents:UIControlEventPrimaryActionTriggered];
    [self.view addSubview:steeper];
    [btn removeFromSuperview];
}

- (void)btn2Action:(UIButton *)sender {
    NSLog(@"button 2 pressed");
    manager = [[CMMotionManager alloc] init];
    if([manager isAccelerometerActive]) {
        manager.accelerometerUpdateInterval=1.0;
        [manager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                      withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
                    NSLog(@"data of accelerometer is %f", accelerometerData.acceleration.x);
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR!!!"
                                                                       message:@"UNABLE TO FIND THE REQUIRED HARDWARE!! PROVIDE FEEDBACK"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok"
                                                         style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.adjustsFontSizeToFitWidth = YES;
            textField.delegate=self;
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)btn3Action:(UIButton *)sender {
    manager = [[CMMotionManager alloc]init];
    if([manager isGyroActive]) {
        manager.gyroUpdateInterval=1.0;
        [manager startGyroUpdatesToQueue:[[NSOperationQueue alloc] init]
                             withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            NSLog(@"GYRP DATA IS, rotation rate x: %F", gyroData.rotationRate.x);
            NSLog(@"GYRP DATA IS, rotation rate y: %F", gyroData.rotationRate.y);
            NSLog(@"GYRP DATA IS, rotation rate z: %F", gyroData.rotationRate.z);
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR!!"
                                                                       message:@"unable to find gyroscope!! Provide feedback"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.delegate=self;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)btn4Action:(UIButton *)sender {
    manager = [[CMMotionManager alloc] init];
    if([manager isMagnetometerActive]) {
        [manager startMagnetometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                     withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            NSLog(@"GYRP DATA IS, rotation rate x: %F", magnetometerData.magneticField.x);
            NSLog(@"GYRP DATA IS, rotation rate y: %F", magnetometerData.magneticField.y);
            NSLog(@"GYRP DATA IS, rotation rate z: %F", magnetometerData.magneticField.z);
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR!!"
                                                                       message:@"unable to find magnetometer!! Provide feedback"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.delegate=self;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"text feedback is %@", textField.text);
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(nullable NSError *)error {
    if(error) {
        NSLog(@"ERROR iS : %@", error);
    }
}

@end
