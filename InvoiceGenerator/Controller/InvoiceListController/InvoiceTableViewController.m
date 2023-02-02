//
//  InvoiceTableViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "InvoiceTableViewController.h"
#import "CustomTableViewCell.h"
#import "NSObject+AppCoordinator.h"
#import "InvoiceDetailsViewController.h"
#import "CustomerTableViewController.h"
#import "CustomerDetailsViewController.h"
#import "UIView+CustomView.h"
#import "NSObject+FirebaseStorage.h"

@interface InvoiceTableViewController (){
    NSArray *invoiceDetailsArray;
    NSMutableArray *filteredArray;
    bool isFiltered;
}
@end

@implementation InvoiceTableViewController
@synthesize menuView;
@synthesize tableView;
@synthesize optionsView;
@synthesize invoiceLabel;
@synthesize customerButton;
@synthesize optionsImageView;
@synthesize addCustomerButton;
@synthesize listOfInvoiceButton;
@synthesize createInvoiceButton;
@synthesize menuViewTrailingConstraint;
@synthesize signOutButton;
@synthesize ref;
NSObject *sharedInstance;
bool isMenuHidden;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rightSideBarButtons];
    [self menuBarButton];
    self.title = INVOICE;
    sharedInstance = [[NSObject alloc]init];
    [optionsView setCustomCornerRadius:10];
    ref = [[FIRDatabase database]reference];
    self.navigationItem.hidesBackButton = YES;
    filteredArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideMenuOptions:YES];
    [optionsView setHidden:YES];
    [optionsImageView setHidden:YES];
    menuViewTrailingConstraint.constant = -(self.view.frame.size.width);
    [self showInvoiceDetails];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    menuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
}

#pragma mark -  NavigationBar items

-(void)menuBarButton {
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"humburger.png"] style:UIBarButtonItemStylePlain target:self action:@selector(menuBarButtonClicked)];
    self.navigationItem.leftBarButtonItem = addBarButtonItem;
}

-(void)rightSideBarButtons {
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonClicked)];
    UIBarButtonItem *optionsBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"options.png"] style:UIBarButtonItemStylePlain target:self action:@selector(optionsBarButtonClicked)];
    self.navigationItem.rightBarButtonItems = @[optionsBarButtonItem,addBarButtonItem];
}

-(void)showInvoiceDetails{
    [sharedInstance fetch:INVOICE withRef:ref withUUID:FIRAuth.auth.currentUser.uid withCompletionHandler:^(NSMutableArray * _Nonnull userInfoArray) {
        self->invoiceDetailsArray = [NSArray arrayWithArray:userInfoArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->tableView reloadData];
        });
    }];
}

#pragma mark - Selectors

-(void)menuBarButtonClicked {
    [self hideMenu];
}

-(void)addBarButtonClicked {
    [sharedInstance navigate:self.navigationController withController:(InvoiceDetailsViewController *)[sharedInstance storyboard:INVOICE_DETAILS_CONTROLLER]];
}

-(void)optionsBarButtonClicked {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:10 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        if(self->optionsView.isHidden == YES) {
            [self->optionsView setHidden:NO];
            [self->optionsImageView setHidden:NO];
        }else{
            [self->optionsView setHidden:YES];
            [self->optionsImageView setHidden:YES];
        }
    } completion:^(BOOL finished) {
    }];
}

-(void)hideMenu{
    if (menuViewTrailingConstraint.constant == 0) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGFloat width = self.view.frame.size.width;
            self->menuViewTrailingConstraint.constant = -width;
            [self hideMenuOptions:YES];
        } completion:nil];
    }else{
        menuViewTrailingConstraint.constant = 0;
        [self hideMenuOptions:NO];
        [self.optionsImageView setHidden:YES];
        [self.optionsView setHidden:YES];
    }
}

-(void)hideMenuOptions:(BOOL)isHidden{
    [listOfInvoiceButton setHidden:isHidden];
    [customerButton setHidden:isHidden];
    [createInvoiceButton setHidden:isHidden];
    [addCustomerButton setHidden:isHidden];
    [invoiceLabel setHidden:isHidden];
    [signOutButton setHidden:isHidden];
}

-(IBAction)listOfInvoiceButtonTapped:(UIButton *)sender{
    [self hideMenu];
}

-(IBAction)customerButtonTapped:(UIButton *)sender {
//    [sharedInstance navigate:self.navigationController withController:(CustomerTableViewController *)[sharedInstance storyboard:CUSTOMER_LIST_CONTROLLER]];
}

-(IBAction)createInvoiceButtonTapped:(UIButton *)sender {
//    [sharedInstance navigate:self.navigationController withController:(InvoiceDetailsViewController *)[sharedInstance storyboard:INVOICE_DETAILS_CONTROLLER]];
}

-(IBAction)addCustomerButtonTapped:(UIButton *)sender {
//    [sharedInstance navigate:self.navigationController withController:(CustomerDetailsViewController *)[sharedInstance storyboard:CUSTOMER_LIST_CONTROLLER]];
}

-(IBAction)signOutButtonTapped:(UIButton *)sender {
    NSError *error;
    [[FIRAuth auth]signOut:&error];
}

#pragma mark -  SearchBar delegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(searchText.length == 0) {
        isFiltered = NO;
    }else{
        isFiltered = YES;
        [filteredArray removeAllObjects];
        for(FIRDataSnapshot *snapshot in invoiceDetailsArray){
            NSDictionary *dict = snapshot.value;
            if([[dict[ITEM_NAME_1]lowercaseString] rangeOfString:[searchText lowercaseString]].length>0){
                [filteredArray addObject:snapshot];
            }
        }
    }
    [tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(isFiltered == YES){
        return filteredArray.count;
    }else{
        return invoiceDetailsArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:INVOICE_LIST_CELL forIndexPath:indexPath];
    FIRDataSnapshot *snapshot;
    if(isFiltered == YES){
        snapshot = filteredArray[indexPath.row];
    }else{
        snapshot = invoiceDetailsArray[indexPath.row];
    }
    cell.itemNameLabel.text = snapshot.value[ITEM_NAME_1];
    cell.itemDescriptionlabel.text = snapshot.value[ITEM_DESCRIPTION_1];
    cell.itemCurrencyLabel.text = snapshot.value[SELECT_TYPE];
    cell.itemQtyLabel.text = [NSString stringWithFormat:@"%ld", [snapshot.value[ITEM_QTY_1] integerValue]+[snapshot.value[ITEM_QTY_2] integerValue]+[snapshot.value[ITEM_QTY_3] integerValue]];
    cell.itemPriceLabel.text = snapshot.value[ITEM_SUB_TOTAL];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PreviewTableViewController *vc = (PreviewTableViewController *)[sharedInstance storyboard:PREVIEW_TABLEVIEW_CONTROLLER];
    vc.delegate = self;
    vc.snapshot = invoiceDetailsArray[indexPath.row];
    [sharedInstance present:self.navigationController withController:vc];
//    [self performSegueWithIdentifier:@"PreviewController" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete){
        FIRDataSnapshot *snapshot = invoiceDetailsArray[indexPath.row];
        [sharedInstance delete:ref withChild:INVOICE withUID:FIRAuth.auth.currentUser.uid withAutoID:snapshot.key];
    }
    [tableView reloadData];
}

- (void)updateInvoice:(Status)status withSnapshot:(nonnull FIRDataSnapshot *)snapshot {
    if(status == update) {
        InvoiceDetailsViewController *vc = (InvoiceDetailsViewController *)[sharedInstance storyboard:INVOICE_DETAILS_CONTROLLER];
        vc.snapshot = snapshot;
        [sharedInstance navigate:self.navigationController withController:vc];
    }
}

- (IBAction)unwindToInvoice:(UIStoryboardSegue *)unwindSegue {}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    NSIndexPath *indexPath = (NSIndexPath *)sender;
//    if([segue.identifier isEqual:@"PreviewController"]) {
//        PreviewTableViewController *vc = [segue destinationViewController];
//        vc.delegate = self;
//        vc.snapshot = invoiceDetailsArray[indexPath.row];
//    }
//}

@end
