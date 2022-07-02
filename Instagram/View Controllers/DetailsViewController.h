//
//  DetailsViewController.h
//  Instagram
//
//  Created by Andreas Lordos on 7/2/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Post *detailDict;
@end

NS_ASSUME_NONNULL_END
