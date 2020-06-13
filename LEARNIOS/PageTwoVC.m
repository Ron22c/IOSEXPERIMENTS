#import "PageTwoVC.h"
#import "CoreLocationViewController.h"

@implementation PageTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Page 2 loaded");
}

- (void)viewDidAppear:(BOOL)animated {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 100)];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setTitle:@"Core Location" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (IBAction)email:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *email = [[MFMailComposeViewController alloc]init];
        [email setSubject:@"GOOD AFTERNOON"];
        [email setMessageBody:@"<h1>Hello Ranajit</h>" isHTML:YES];
        [email setToRecipients:[NSArray arrayWithObject:@"rjc22aug@gmail.com"]];
        [self presentViewController:email animated:YES completion:nil];
    } else {
        [self showAlert];
    }
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"clicked");
    CoreLocationViewController *controller = [[CoreLocationViewController alloc]init];
//    [self presentViewController:controller animated:self completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)message:(id)sender {
    if([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc]init];
        [message setSubject:@"GOOD MORNING"];
        [message setRecipients:[NSArray arrayWithObject:@"7980705729"]];
        [message setBody:@"HOW ARE YOU"];
        [self presentViewController:message animated:YES completion:nil];
    } else {
        [self showAlert];
    }
}

- (IBAction)alert:(id)sender {
    [self showAlert];
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"ERROR!!" message:@"This action not suported" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ACTION 1 Pressed");
    }];
    [alert addAction:action1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"ACTION 2 Pressed");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate=self;
        textField.secureTextEntry=YES;
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - delegates

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if(error) {
        NSLog(@"Error!!!! %@",error);
    } else {
        NSLog(@"MESSAGE SENT");
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    NSLog(@"MESSAGE SENT");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"DELEGATED end edit VALUE: %@", textField.text);
    return YES;
}

@end
