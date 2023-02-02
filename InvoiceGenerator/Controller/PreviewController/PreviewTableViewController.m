//
//  PreviewTableViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "PreviewTableViewController.h"

@interface PreviewTableViewController ()

@end

@implementation PreviewTableViewController
//@synthesize index;
@synthesize snapshot;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)showingPreview:(PreviewTableViewCell *)cell {
    if(snapshot.value != NULL){
        NSDictionary *dict = snapshot.value;
        cell.customerNameLabel.text = dict[CUSTOMER_NAME];
        cell.customerEmailLabel.text = dict[CUSTOMER_EMAIL];
        cell.customerCompanyLabel.text = dict[CUSTOMER_COMPANY];
        cell.itemNameLabel1.text = dict[ITEM_NAME_1];
        cell.itemDescriptionLabel1.text = dict[ITEM_DESCRIPTION_1];
        cell.itemNameLabel2.text = dict[ITEM_NAME_2];
        cell.itemDescriptionLabel2.text = dict[ITEM_DESCRIPTION_2];
        cell.itemNameLabel3.text = dict[ITEM_NAME_3];
        cell.itemDescriptionLabel3.text = dict[ITEM_DESCRIPTION_3];
        cell.itemPriceLabel.text = [NSString stringWithFormat: @"%.2f", [dict[ITEM_PRICE_1] doubleValue]+[dict[ITEM_PRICE_2] doubleValue]+[dict[ITEM_PRICE_3] doubleValue]];
        cell.itemQtyLabel.text = [@"x" stringByAppendingString:[NSString stringWithFormat: @"%ld", [dict[ITEM_QTY_1] integerValue]+[dict[ITEM_QTY_2] integerValue]+[dict[ITEM_QTY_3] integerValue]]];
        cell.itemSubtotalLabel.text = dict[ITEM_SUB_TOTAL];
        cell.itemTaxLabel.text = [dict[ITEM_TAX_AMOUNT] stringByAppendingString:@"%"];
        cell.itemTotalLabel.text = dict[ITEM_TOTAL];
        cell.invoiceNumberLabel.text = dict[INVOICE_NUMBER];
        cell.invoiceCreatedDateLabel.text = dict[INVOICE_CREATED_DATE];
        cell.invoiceAmountLabel.text = dict[INVOICE_AMOUNT];
        cell.invoiceCurrencyLabel.text = dict[INVOICE_CURRENCY];
        cell.invoiceDiscountLabel.text = [dict[INVOICE_DISCOUNT] stringByAppendingString:@"%"];
        cell.invoiceTotalAmountLabel.text = dict[INVOICE_DISCOUNT_PRICE];
        cell.totalAmountLabel.text = dict[TAX_TOTAL_AMOUNT];
        cell.totalPaymentDateLabel.text = dict[TAX_PAYMENT_DATE];
        cell.totalPaidAmountLabel.text = dict[TAX_PAID_AMOUNT];
        cell.totalPaidStatusLabel.text = dict[TAX_PAID_STATUS];
        cell.totalDisclaimerTextLabel.text = dict[TAX_DISCLAIMER];
        if([dict[SELECT_TYPE] isEqual:TAX_INVOICE]){
            cell.selectedTypeLabel.text = TAX_INVOICE;
        }else{
            cell.selectedTypeLabel.text = RETAIL_INVOICE;
        }
    }
}


-(IBAction)updateButtonTapped:(UIButton *)sender {
    
    [self.delegate updateInvoice:update withSnapshot:snapshot];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PreviewTableViewCell *cell = (PreviewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:PREVIEW_TABLEVIEW_CELL forIndexPath:indexPath];
    [self showingPreview:cell];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
