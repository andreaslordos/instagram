//
//  SignupViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>
#import "Utilities.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    if ([Utilities checkIfEmpty:newUser.username fieldName:@"Username" vc:self] || [Utilities checkIfEmpty:newUser.password fieldName:@"Password" vc:self]) {
        return;
    }
    
    // else proceed to signup flow
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [Utilities createSimpleAlert:@"Error creating account" desc:@"Username already exists" vc:self];
        } else {
            NSLog(@"User registered successfully");
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"signupSegue" sender:nil];
        }
    }];
}

- (IBAction)signupButton:(id)sender {
    [self registerUser];
}
@end
