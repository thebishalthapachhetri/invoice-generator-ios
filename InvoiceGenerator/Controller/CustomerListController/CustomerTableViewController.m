//
//  CustomerTableViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "CustomerTableViewController.h"
#import "NSObject+AppCoordinator.h"
#import "CustomerDetailsViewController.h"
#import "UIView+CustomView.h"
#import "CustomerDetailsTableViewCell.h"
#import "NSObject+FirebaseStorage.h"

@interface CustomerTableViewController () {
    NSArray *resultArray;
    NSMutableArray *filteredArray;
    BOOL isFiltered;
}

@end

@implementation CustomerTableViewController
@synthesize ref;
@synthesize tableView;
@synthesize optionsView;
@synthesize optionsImageView;
NSObject *sharedInstance;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isFiltered = NO;
    self.title = @"Customer";
    [self rightSideBarButtons];
    [optionsView setHidden:YES];
    [optionsImageView setHidden:YES];
    sharedInstance = [[NSObject alloc]init];
    ref = [[FIRDatabase database]reference];
    filteredArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchCustomerInfoFromDatabase];
}

-(void)fetchCustomerInfoFromDatabase {

    [sharedInstance fetch:@"Customer" withRef:ref withUUID:FIRAuth.auth.currentUser.uid withCompletionHandler:^(NSMutableArray * _Nonnull userInfoArray) {
        self->resultArray = [NSArray arrayWithArray:userInfoArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->tableView reloadData];
        });
    }];
}

-(void)rightSideBarButtons {
    UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonClicked)];
    UIBarButtonItem *optionsBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"options.png"] style:UIBarButtonItemStylePlain target:self action:@selector(optionsBarButtonClicked)];
    self.navigationItem.rightBarButtonItems = @[optionsBarButtonItem,addBarButtonItem];
}

#pragma mark - Selectors

-(void)addBarButtonClicked {
    [sharedInstance navigate:self.navigationController withController:(CustomerDetailsViewController *)[sharedInstance storyboard:CUSTOMER_DETAILS_CONTROLLER]];
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

#pragma mark - UISearchBar delegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length == 0) {
        isFiltered = NO;
    }else{
        isFiltered = YES;
        [filteredArray removeAllObjects];
        for(FIRDataSnapshot *snapshot in resultArray){
            NSDictionary *dict = snapshot.value;
            if([[dict[CUSTOMER_NAME]lowercaseString] rangeOfString:[searchText lowercaseString]].length>0){
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
    if(isFiltered == NO){
        return resultArray.count;
    }else{
        return filteredArray.count;
    }
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     CustomerDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CUSTOMER_LIST_CELL forIndexPath:indexPath];
     FIRDataSnapshot *snapshot;
     if(isFiltered == NO) {
        snapshot = resultArray[indexPath.row];
     }else{
        snapshot = filteredArray[indexPath.row];
     }
     NSDictionary *dict = snapshot.value;
     cell.textLabel.text = [dict valueForKey:CUSTOMER_NAME];
     cell.detailTextLabel.text = [dict valueForKey:CUSTOMER_EMAIL];
     return cell;
 }


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        FIRDataSnapshot *snapshot = resultArray[indexPath.row];
        [sharedInstance delete:ref withChild:CUSTOMER withUID:FIRAuth.auth.currentUser.uid withAutoID:snapshot.key];
        [self fetchCustomerInfoFromDatabase];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"CustomerDetails" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = (NSIndexPath *)sender;
    CustomerDetailsViewController *vc = [segue destinationViewController];
    vc.snapshot = resultArray[indexPath.row];
}

- (IBAction)unwindToCustomer:(UIStoryboardSegue *)unwindSegue {
}


@end
