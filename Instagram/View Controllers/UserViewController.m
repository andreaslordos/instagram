//
//  UserViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import "UserViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "DetailsViewController.h"
#import "PostCollectionViewCell.h"

@interface UserViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation UserViewController

static NSString * const reuseIdentifier = @"post";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [PFUser currentUser];
    self.usernametop.text = self.user.username;
    self.usernamebottom.text = self.user.username;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];

    // add refresh control to table view
    [self.collectionView insertSubview:self.refreshControl atIndex:0];

    [self beginRefresh:self.refreshControl];
}


- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"createdAt"];
    [postQuery whereKey:@"author" equalTo:self.user];
    postQuery.limit = 20;
 
    [refreshControl setTintColor:[UIColor whiteColor]];
    // Get timeline
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // successfuly loaded home timeline
            self.arrayOfPosts = [posts mutableCopy];
            [self.collectionView reloadData];
            [refreshControl endRefreshing];
        } else {
            // error loading timeline
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot get posts"
                                    message:@"The internet connection appears to be offline."
                                    preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* retryAction = [UIAlertAction actionWithTitle:@"Retry" style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {[self beginRefresh:self.refreshControl];}];

            [alert addAction:retryAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
    Post *dataToPass = self.arrayOfPosts[indexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.arrayOfPosts count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    cell.post = self.arrayOfPosts[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


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

- (IBAction)tappedProfilePic:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerVC.view setBackgroundColor:UIColor.blackColor];
    [self presentViewController:imagePickerVC animated:YES completion:nil];

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


@end
