//
//  CustomerTableViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseStorage;
@import FirebaseAuth;
@import FirebaseDatabase;
NS_ASSUME_NONNULL_BEGIN

@interface CustomerTableViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *optionsImageView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic)FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
