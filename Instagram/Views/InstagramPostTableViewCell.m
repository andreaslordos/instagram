//
//  InstagramPostTableViewCell.m
//  Instagram
//
//  Created by Andreas Lordos on 6/29/22.
//

#import "InstagramPostTableViewCell.h"
#import "Post.h"
#import "DateTools.h"

@implementation InstagramPostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentTapped:(id)sender {
}

- (IBAction)heartTapped:(id)sender {
}

- (void)setLikedText:(int)likeCount {
    if (likeCount == 0) {
        [self.likedBy setText:@""];
    }
    else if (likeCount == 1) {
        // do something
    }
    else {
        // like count more than 1
    }
}

- (void)setPost:(Post *)post {
    _post = post;
    self.image.file = post.image;
    [self.username setText:post.author.username];
    [self setLikedText:[post.likeCount intValue]];
    [self.image loadInBackground];
    
    
    // set caption with username.
    NSString *yourString = [post.author.username stringByAppendingString:[@" " stringByAppendingString:post.caption]];
    NSMutableAttributedString *yourAttributedString = [[NSMutableAttributedString alloc] initWithString:yourString];
    NSString *boldString = post.author.username;
    NSRange boldRange = [yourString rangeOfString:boldString];
    [yourAttributedString addAttribute: NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:boldRange];
    [self.caption setAttributedText: yourAttributedString];

    
    NSLog(@"%@", post.createdAt);
    NSDate *date = post.createdAt;
//    self.dateCreated = [NSString stringWithFormat: @"%ld/%ld/%ld", date.month, date.day, date.year];
//    self.timeCreated = [NSString stringWithFormat: @"%ld:%ld", date.hour, date.minute];
    self.createdAtString = date.shortTimeAgoSinceNow;
    
    [self.timePosted setText:[self.createdAtString stringByAppendingString:@" ago"]];
    
}

@end
