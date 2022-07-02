//
//  ProfileViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 6/30/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *realname;
@property (weak, nonatomic) IBOutlet UIImageView *profilepic;
- (IBAction)tappedProfileButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
