//
//  UserViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>
- (IBAction)tappedProfilePic:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *usernametop;
@property (weak, nonatomic) IBOutlet UILabel *usernamebottom;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

@end

NS_ASSUME_NONNULL_END
