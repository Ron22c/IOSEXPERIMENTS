#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageTwoVC : UIViewController <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate,
UITextFieldDelegate>

- (IBAction)email:(id)sender;
- (IBAction)message:(id)sender;
- (IBAction)alert:(id)sender;

@end

NS_ASSUME_NONNULL_END
