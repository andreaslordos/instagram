//
//  ComposeViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

@end

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *caption;
@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
- (IBAction)takePhotoButton:(id)sender;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
- (IBAction)shareButton:(id)sender;

@end

NS_ASSUME_NONNULL_END
