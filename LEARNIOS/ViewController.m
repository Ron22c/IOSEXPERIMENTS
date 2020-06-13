#import "ViewController.h"
#import "PageThreeVCViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()
{
    int minute;
    int hour;
    int seconds;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"App loaded");
    input1=22;
    input2=567;
    [self.startTitle setTitle:@"START" forState:UIControlStateNormal];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if(error) {
        NSLog(@"%@", error);
    }
}

- (void)clockStart {
    if(seconds>=59) {
        seconds=0;
        minute++;
    } else {
        seconds++;
    }
    
    if(minute>=59) {
        minute=0;
        hour++;
    }
    [self.time setText:[NSString stringWithFormat:@"%d:%d:%d", hour, minute, seconds]];
}

- (void)viewDidAppear:(BOOL)animated {
    [ViewController classMethod];
    id name = @"9";
    
    NSLog(@" %@", name);
    
    if([name isKindOfClass:[NSString class]]) {
        NSLog(@"YES IT IS STING");
    }
    
    SEL select = @selector(uppercaseString);
    
    if([name respondsToSelector:@selector(lowercaseString)] && [name respondsToSelector:select]) {
        NSLog(@"YES IT IS STING AND RESPONSED TO lowercaseString");
    }
    
    NSNumber *num = [NSNumber numberWithInt:23];
    num = [NSNumber numberWithFloat:23.56];
    num = [NSNumber numberWithDouble:23.56];
    
    NSArray *array = [NSArray arrayWithObjects:@"hi", @"hello", @"bye", @9, @10, nil];
    
    for(id val in array) {
        if([val isKindOfClass:[NSString class]]) {
            NSLog(@"String : %@", val);
        } else {
            NSLog(@"int : %@", val);
        }
    }
    
    [array objectAtIndex:2];
    NSLog(@"count: %lu", (unsigned long)array.count);
    
    NSDate *date = [[NSDate alloc]init];
    NSLog(@"DATE: %@",[NSDate date]);
    NSLog(@"DATE alloc: %@",date);

}

- (IBAction)button1:(id)sender {
    self.label.text = [@"BUTTON ONE PRESSED!! TEXT IS: " stringByAppendingString:self.text.text];
    [self methodOne];
    [self.label.text isEqualToString:@"Ranajit"];
}

- (IBAction)button2:(id)sender {
    self.label.text = [@"BUTTON TWO PRESSED!! TEXT IS: " stringByAppendingString:self.text.text];
    NSLog(@"RESULT IS: %d", [self add:input1
                                 with:input2]);
}

- (void)methodOne {
    NSLog(@"method one called");
}

- (int)add:(int)inputA
      with:(int)inputB {
    return inputA+inputB;
}

+ (void)classMethod {
    NSLog(@"this is a class method");
}

- (IBAction)start:(id)sender {
    NSLog(@"%@", self.startTitle.titleLabel.text);
    if([self.startTitle.titleLabel.text isEqualToString:@"START"]){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0  target:self selector:@selector(clockStart)
                                               userInfo:nil repeats:YES];
        [self.startTitle setTitle:@"RESTART" forState:UIControlStateNormal];
    } else {
        hour=0;
        minute=0;
        seconds=0;
    }
}

- (IBAction)pause:(id)sender {
    [timer invalidate];
}

- (IBAction)stop:(id)sender {
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0  target:self selector:@selector(clockStart)
                                           userInfo:nil repeats:YES];
}

- (IBAction)page3:(id)sender {
    [self performSegueWithIdentifier:@"page3" sender:sender];
}

- (IBAction)goToViews:(id)sender {
    [self performSegueWithIdentifier:@"page4" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"page3"]) {
        PageThreeVCViewController *vc = segue.destinationViewController;
        NSLog(@"3rd page forwarded: %@", vc);
    }
}

@end
