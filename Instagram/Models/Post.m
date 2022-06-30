//
//  Post.m
//  Instagram
//
//  Created by Andreas Lordos on 6/29/22.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;
@dynamic createdAt;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];

}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


//- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
//    self = [super init];
//    if (self) {
//        self.caption = dictionary[@"caption"];
//        self.author = dictionary[@"author"];
//        self.image = dictionary[@"image"];
//        self.commentCount = dictionary[@"commentCount"];
//        self.likeCount = dictionary[@"likeCount"];
//    }
//    return self;
//}

//+ (NSMutableArray *)postsWithArray:(NSArray *)dictionaries {
//    NSMutableArray *posts = [NSMutableArray array];
//    for (NSDictionary *dictionary in dictionaries) {
//        NSLog(@"%@", dictionary);
//        Post *post = [[Post alloc] initWithDictionary:dictionary];
//        [posts addObject:post];
//    }
//    return posts;
//}

    
@end
