//
//  PostCollectionViewCell.m
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import "PostCollectionViewCell.h"
#import "Post.h"

@implementation PostCollectionViewCell

- (void)setPost:(Post *)post {
    //self.post.image = nil;
    _post = post;
    self.image.file = post.image;
    [self.image loadInBackground];
}

@end
