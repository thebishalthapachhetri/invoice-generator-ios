//
//  InvoiceDetailsTableViewController.h
//  InvoiceGenerator
//
//  Created by Aireddy Saikrishna on 31/03/22.
//

#import <UIKit/UIKit.h>
#import "InvoiceDetailsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceDetailsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
