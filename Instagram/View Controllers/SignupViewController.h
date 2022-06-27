//
//  SignupViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)signupButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
