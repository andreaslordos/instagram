//
//  ComposeViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 6/28/22.
//

#import "ComposeViewController.h"
#import "Utilities.h"
@interface ComposeViewController ()

@end

@implementation ComposeViewController


- (void)setCaptionPrompt {
    [self.caption setText:@"Write a caption..."];
    [self.caption setTextColor:UIColor.lightGrayColor];
    [self.caption setBackgroundColor:UIColor.blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.caption.delegate = self;
    
    
    [self setCaptionPrompt];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImage:)];
    [self.previewImage addGestureRecognizer:tapGestureRecognizer];
    self.previewImage.userInteractionEnabled = YES; // default is no for UIImageView
}



- (void)tappedImage:(UITapGestureRecognizer *)gestureRecognizer {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerVC.view setBackgroundColor:UIColor.blackColor];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    [self.previewImage setImage:editedImage];
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self.caption setText:@""];
    [self.caption setTextColor:UIColor.whiteColor];
    [self.caption setBackgroundColor:UIColor.blackColor];
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.caption.text isEqualToString:@""]) {
        [self setCaptionPrompt];
    }
}

- (IBAction)takePhotoButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    [imagePickerVC.view setBackgroundColor:UIColor.blackColor];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (IBAction)shareButton:(id)sender {
    if (self.previewImage.image != nil) {
        [Post postUserImage:self.previewImage.image withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [Utilities createSimpleAlert:@"Error" desc:@"Error uploading post. Please try again" vc:self];
            }
        }];
    }
    else {
        [Utilities createSimpleAlert:@"Error sharing post" desc:@"Image cannot be empty." vc:self];
        return;
    }
}
@end
