//
//  protocolViewController.h
//  LEARNIOS
//
//  Created by Ranajit Chandra on 13/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreLocationViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProtocolForVC

- (void)printVCName;

@end

@interface protocolViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) id<ProtocolForVC> delegate;

@end

NS_ASSUME_NONNULL_END
