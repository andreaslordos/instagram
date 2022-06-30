//
//  TimelineViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>

@interface TimelineViewController ()
- (IBAction)didTapLogout:(id)sender;
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
        
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];

    // add refresh control to table view
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    [self beginRefresh:self.refreshControl];
    [self.tableView reloadData];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    [postQuery includeKey:@"createdAt"];
    postQuery.limit = 20;
 
    [refreshControl setTintColor:[UIColor whiteColor]];
    // Get timeline
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // successfuly loaded home timeline
            self.arrayOfPosts = [posts mutableCopy];
            [self.tableView reloadData];
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

- (IBAction)didTapLogout:(id)sender {
    
    // clear access tokens
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    // use scenedelegate and check what naveen posted in workplace
    SceneDelegate *sceneDelegate = (SceneDelegate *)UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    // switch root view controller back to login page
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}
    

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.tableView registerNib:[UINib nibWithNibName:@"InstagramPostTableViewCell" bundle:nil]
    forCellReuseIdentifier:@"InstagramPostTableViewCell"];
    InstagramPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InstagramPostTableViewCell"];
    cell.post = self.arrayOfPosts[indexPath.row];
    NSLog(@"self.arrayOfPosts[indexPath.row]: %@", self.arrayOfPosts[indexPath.row]);
    NSLog(@"cell.post: %@", cell.post);
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfPosts count];
}

@end
