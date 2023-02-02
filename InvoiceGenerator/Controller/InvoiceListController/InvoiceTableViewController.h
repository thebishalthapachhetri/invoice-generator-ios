//
//  InvoiceTableViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
#import "Constants.h"
#import "PreviewTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface InvoiceTableViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,PreviewProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuViewTrailingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *listOfInvoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *customerButton;
@property (weak, nonatomic) IBOutlet UIButton *createInvoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *addCustomerButton;
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UIImageView *optionsImageView;
@property (weak, nonatomic) IBOutlet UILabel *invoiceLabel;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (strong, nonatomic)FIRDatabaseReference *ref;

@end

NS_ASSUME_NONNULL_END
