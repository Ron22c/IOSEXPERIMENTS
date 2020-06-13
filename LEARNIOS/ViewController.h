#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    int input1;
    int input2;
}

@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (void)methodOne;
+ (void)classMethod;
- (IBAction)start:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)page3:(id)sender;
- (IBAction)goToViews:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *startTitle;


@end

