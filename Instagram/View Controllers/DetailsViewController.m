//
//  DetailsViewController.m
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>
#import "InstagramPostTableViewCell.h"


@interface DetailsViewController ()
@property (strong, nonatomic) NSMutableArray *arrayOfPosts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    //Post *post = self.detailDict;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
        
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];

    // add refresh control to table view
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    [self beginRefresh:self.refreshControl];
    [self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    NSArray *posts = [NSArray arrayWithObject:self.detailDict];
    self.arrayOfPosts = [posts mutableCopy];
    [self.tableView reloadData];
    [refreshControl endRefreshing];
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
    return 1;
}

@end
