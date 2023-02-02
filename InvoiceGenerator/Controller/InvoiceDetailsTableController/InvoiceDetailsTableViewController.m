//
//  InvoiceDetailsTableViewController.m
//  InvoiceGenerator
//
//  Created by Aireddy Saikrishna on 31/03/22.
//

#import "InvoiceDetailsTableViewController.h"

@interface InvoiceDetailsTableViewController ()

@end

@implementation InvoiceDetailsTableViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    tableView.pagingEnabled = true;
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InvoiceDetailsTableViewCell *cell = (InvoiceDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"InvoiceDetailsTableViewCell"];
    return cell;
}

@end
