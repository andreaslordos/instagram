//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *image;
@end

NS_ASSUME_NONNULL_END
