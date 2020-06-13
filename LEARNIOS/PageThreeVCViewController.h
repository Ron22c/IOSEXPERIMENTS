//
//  PageThreeVCViewController.h
//  LEARNIOS
//
//  Created by Ranajit Chandra on 11/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageThreeVCViewController : UIViewController

- (IBAction)button1:(id)sender;
- (IBAction)steper:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)switch:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *switchVar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIStepper *steperVar;
@property (weak, nonatomic) IBOutlet UIProgressView *progresbar;

@end

NS_ASSUME_NONNULL_END
