//
//  InstagramPostTableViewCell.h
//  Instagram
//
//  Created by Andreas Lordos on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface InstagramPostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet PFImageView *image;
- (IBAction)heartTapped:(id)sender;
- (IBAction)commentTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *heartButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *likedBy;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (weak, nonatomic) IBOutlet UILabel *timePosted;
//@property (strong, nonatomic) NSString *dateCreated;
//@property (strong, nonatomic) NSString *timeCreated;
@property (strong, nonatomic) NSString *createdAtString;
@property (strong, nonatomic) Post *post;
- (void)setPost:(Post *)post;
@end

NS_ASSUME_NONNULL_END
