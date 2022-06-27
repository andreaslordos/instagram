//
//  LoginViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "Utilities.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if ([Utilities checkIfEmpty:username fieldName:@"Username" vc:self] || [Utilities checkIfEmpty:password fieldName:@"Password" vc:self]) {
        return;
    }
    
    // else proceed to login flow
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [Utilities createSimpleAlert:@"Error logging in" desc:@"Invalid username/password combo" vc:self];
        } else {
            NSLog(@"User logged in successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)tappedLogin:(id)sender {
    [self loginUser];
}
@end
