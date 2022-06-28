//
//  TimelineViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>

@interface TimelineViewController ()
- (IBAction)didTapLogout:(id)sender;

@end

@implementation TimelineViewController

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

- (IBAction)didTapLogout:(id)sender {
    
    // clear access tokens
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    // use scenedelegate and check what naveen posted in workplace
    SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    // switch root view controller back to login page
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
    
    
}
@end
