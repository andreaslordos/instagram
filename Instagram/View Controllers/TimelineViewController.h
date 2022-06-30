//
//  TimelineViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "InstagramPostTableViewCell.h"
#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimelineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
