//
//  InvoiceDetailsViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "InvoiceDetailsViewController.h"
#import "UITextField+TextFieldProperties.h"
#import "UIButton+ButtonProperties.h"
#import "NSObject+AppCoordinator.h"
#import "UIView+CustomView.h"
#import "NSObject+FirebaseStorage.h"

typedef enum : NSUInteger {
    tax,
    discount,
} CalculateTotal;

@interface InvoiceDetailsViewController (){
    NSString *selectType;
    NSString *textFieldType;
}

@end

@implementation InvoiceDetailsViewController
@synthesize scrollView;
@synthesize customerNameTextField;
@synthesize emailTextField;
@synthesize companyNameTextField;
@synthesize itemNameTextField1;
@synthesize descriptionTextField1;
@synthesize priceTextField1;
@synthesize qtyTextField1;
@synthesize itemNameTextField2;
@synthesize descriptionTextField2;
@synthesize priceTextField2;
@synthesize qtyTextField2;
@synthesize itemNameTextField3;
@synthesize descriptionTextField3;
@synthesize priceTextField3;
@synthesize qtyTextField3;
@synthesize subTotalTextField;
@synthesize taxAmountTextField;
@synthesize totalTextField;
@synthesize invoiceNumberTextField;
@synthesize createdDateTextField;
@synthesize amountTextField;
@synthesize currencyTextField;
@synthesize discountTextField;
@synthesize discountPriceTextField;
@synthesize totalAmountTextField;
@synthesize paymentDateTextField;
@synthesize paidAmountTextField;
@synthesize paidStatusTextField;
@synthesize disclaimerTextTextField;
@synthesize createInvoiceButton;
@synthesize customerDetailsView;
@synthesize itemDescriptionView;
@synthesize goodsAndServiceView;
@synthesize totalAmountView;
@synthesize ref;
@synthesize datePicker;
@synthesize snapshot;
@synthesize segmentControl;
NSObject *sharedInstance;
NSArray *detailsArray;

#pragma mark - VIEW LIFECYCLE METHODS
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Invoice Details";
    sharedInstance = [[NSObject alloc]init];
    ref = [[FIRDatabase database]reference];
    [self setUpUI];
    [self fetchCustomerDetailsIfAny];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self showingCustomerDetails];
}

#pragma mark - SETUPUI METHOD
-(void)setUpUI {
    
    [self setPropertiesForTextField: customerNameTextField];
    [self setPropertiesForTextField: emailTextField];
    [self setPropertiesForTextField: companyNameTextField];
    [self setPropertiesForTextField: itemNameTextField1];
    [self setPropertiesForTextField: descriptionTextField1];
    [self setPropertiesForTextField: priceTextField1];
    [self setPropertiesForTextField: qtyTextField1];
    [self setPropertiesForTextField: itemNameTextField2];
    [self setPropertiesForTextField: descriptionTextField2];
    [self setPropertiesForTextField: priceTextField2];
    [self setPropertiesForTextField: qtyTextField2];
    [self setPropertiesForTextField: itemNameTextField3];
    [self setPropertiesForTextField: descriptionTextField3];
    [self setPropertiesForTextField: priceTextField3];
    [self setPropertiesForTextField: qtyTextField3];
    [self setPropertiesForTextField: subTotalTextField];
    [self setPropertiesForTextField: taxAmountTextField];
    [self setPropertiesForTextField: totalTextField];
    [self setPropertiesForTextField: invoiceNumberTextField];
    [self setPropertiesForTextField: createdDateTextField];
    [self setPropertiesForTextField: amountTextField];
    [self setPropertiesForTextField: currencyTextField];
    [self setPropertiesForTextField: discountTextField];
    [self setPropertiesForTextField: discountPriceTextField];
    [self setPropertiesForTextField: totalAmountTextField];
    [self setPropertiesForTextField: paymentDateTextField];
    [self setPropertiesForTextField: paidAmountTextField];
    [self setPropertiesForTextField: paidStatusTextField];
    [self setPropertiesForTextField: disclaimerTextTextField];
    createdDateTextField.delegate = self;
    paymentDateTextField.delegate = self;
    [createInvoiceButton setCustomCornerRadius:10];
    [customerDetailsView shadow:[UIColor blackColor] withRadius:30 withOffSet:CGSizeMake(30, 30) withOpacity:0.5];
    [itemDescriptionView shadow:[UIColor blackColor] withRadius:30 withOffSet:CGSizeMake(30, 30) withOpacity:0.5];
    [goodsAndServiceView shadow:[UIColor blackColor] withRadius:30 withOffSet:CGSizeMake(30, 30) withOpacity:0.5];
    [totalAmountView shadow:[UIColor blackColor] withRadius:30 withOffSet:CGSizeMake(30, 30) withOpacity:0.5];
    [self datePickerPerformed];
    [self hideDatePicker:YES];
}

-(void)datePickerPerformed{
    createdDateTextField.inputView = datePicker;
    paymentDateTextField.inputView = datePicker;
}

-(void)hideDatePicker:(BOOL)hide{
    datePicker.hidden = hide;
}

-(void)setPropertiesForTextField:(UITextField *)textField {
    [textField setCustomCornerRadius:10];
    [textField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [textField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
}

-(NSDateFormatter *)dateFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat: @"dd/mm/yyyy"];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    return formatter;
}

-(void)showingCustomerDetails {
    if(snapshot.value != NULL){
        [self editViews:NO];
        NSDictionary *dict = snapshot.value;
        customerNameTextField.text = dict[CUSTOMER_NAME];
        emailTextField.text = dict[CUSTOMER_EMAIL];
        companyNameTextField.text = dict[CUSTOMER_COMPANY];
        itemNameTextField1.text = dict[ITEM_NAME_1];
        descriptionTextField1.text = dict[ITEM_DESCRIPTION_1];
        priceTextField1.text = dict[ITEM_PRICE_1];
        qtyTextField1.text = dict[ITEM_QTY_1];
        itemNameTextField2.text = dict[ITEM_NAME_2];
        descriptionTextField2.text = dict[ITEM_DESCRIPTION_2];
        priceTextField2.text = dict[ITEM_PRICE_2];
        qtyTextField2.text = dict[ITEM_QTY_2];
        itemNameTextField3.text = dict[ITEM_NAME_3];
        descriptionTextField3.text = dict[ITEM_DESCRIPTION_3];
        priceTextField3.text = dict[ITEM_PRICE_3];
        qtyTextField3.text = dict[ITEM_QTY_3];
        subTotalTextField.text = dict[ITEM_SUB_TOTAL];
        taxAmountTextField.text = dict[ITEM_TAX_AMOUNT];
        totalTextField.text = dict[ITEM_TOTAL];
        invoiceNumberTextField.text = dict[INVOICE_NUMBER];
        createdDateTextField.text = dict[INVOICE_CREATED_DATE];
        amountTextField.text = dict[INVOICE_AMOUNT];
        currencyTextField.text = dict[INVOICE_CURRENCY];
        discountTextField.text = dict[INVOICE_DISCOUNT];
        discountPriceTextField.text = dict[INVOICE_DISCOUNT_PRICE];
        totalAmountTextField.text = dict[TAX_TOTAL_AMOUNT];
        paymentDateTextField.text = dict[TAX_PAYMENT_DATE];
        paidAmountTextField.text = dict[TAX_PAID_AMOUNT];
        paidStatusTextField.text = dict[TAX_PAID_STATUS];
        disclaimerTextTextField.text = dict[TAX_DISCLAIMER];
        if([dict[SELECT_TYPE] isEqual:TAX_INVOICE]){
            segmentControl.selectedSegmentIndex = 0;
        }else{
            segmentControl.selectedSegmentIndex = 1;
        }
        [self EditBarButton:@"Edit"];
    }
}

-(void)EditBarButton:(NSString *)title {
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(editBarButtonTapped:)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)editBarButtonTapped:(UIBarButtonItem *)sender {
    if([sender.title isEqual: @"Edit"]){
        [self editViews:YES];
        [self EditBarButton:@""];
        [self.createInvoiceButton setTitle:@"Update Invoice" forState:UIControlStateNormal];
    }
}

-(void)editViews:(BOOL)isEnable{
    customerNameTextField.enabled = isEnable;
    emailTextField.enabled = isEnable;
    companyNameTextField.enabled = isEnable;
    itemNameTextField1.enabled = isEnable;
    descriptionTextField1.enabled = isEnable;
    priceTextField1.enabled = isEnable;
    qtyTextField1.enabled = isEnable;
    itemNameTextField2.enabled = isEnable;
    descriptionTextField2.enabled = isEnable;
    priceTextField2.enabled = isEnable;
    qtyTextField2.enabled = isEnable;
    itemNameTextField3.enabled = isEnable;
    descriptionTextField3.enabled = isEnable;
    priceTextField3.enabled = isEnable;
    qtyTextField3.enabled = isEnable;
    //    subTotalTextField.enabled = isEnable;
    taxAmountTextField.enabled = isEnable;
    //    totalTextField.enabled = isEnable;
    invoiceNumberTextField.enabled = isEnable;
    createdDateTextField.enabled = isEnable;
    amountTextField.enabled = isEnable;
    currencyTextField.enabled = isEnable;
    discountTextField.enabled = isEnable;
    discountPriceTextField.enabled = isEnable;
    totalAmountTextField.enabled = isEnable;
    paymentDateTextField.enabled = isEnable;
    paidAmountTextField.enabled = isEnable;
    paidStatusTextField.enabled = isEnable;
    disclaimerTextTextField.enabled = isEnable;
    createInvoiceButton.enabled = isEnable;
    segmentControl.enabled = isEnable;
}

-(void)saveData {
    NSMutableDictionary *invoiceDict = [[NSMutableDictionary alloc]init];
    if(selectType == nil){
        selectType = @"Tax Invoice";
    }
    invoiceDict[SELECT_TYPE] = selectType;
    invoiceDict[CUSTOMER_NAME] = customerNameTextField.text;
    invoiceDict[CUSTOMER_EMAIL] = emailTextField.text;
    invoiceDict[CUSTOMER_COMPANY] = companyNameTextField.text;
    invoiceDict[ITEM_NAME_1] = itemNameTextField1.text;
    invoiceDict[ITEM_DESCRIPTION_1] = descriptionTextField1.text;
    invoiceDict[ITEM_PRICE_1] = priceTextField1.text;
    invoiceDict[ITEM_QTY_1] = qtyTextField1.text;
    invoiceDict[ITEM_NAME_2] = itemNameTextField2.text;
    invoiceDict[ITEM_DESCRIPTION_2] = descriptionTextField2.text;
    invoiceDict[ITEM_PRICE_2] = priceTextField2.text;
    invoiceDict[ITEM_QTY_2] = qtyTextField2.text;
    invoiceDict[ITEM_NAME_3] = itemNameTextField3.text;
    invoiceDict[ITEM_DESCRIPTION_3] = descriptionTextField3.text;
    invoiceDict[ITEM_PRICE_3] = priceTextField3.text;
    invoiceDict[ITEM_QTY_3] = qtyTextField3.text;
    invoiceDict[ITEM_SUB_TOTAL] = subTotalTextField.text;
    invoiceDict[ITEM_TAX_AMOUNT] = taxAmountTextField.text;
    invoiceDict[ITEM_TOTAL] = totalTextField.text;
    invoiceDict[INVOICE_NUMBER] = invoiceNumberTextField.text;
    invoiceDict[INVOICE_CREATED_DATE] = createdDateTextField.text;
    invoiceDict[INVOICE_AMOUNT] = amountTextField.text;
    invoiceDict[INVOICE_CURRENCY] = currencyTextField.text;
    invoiceDict[INVOICE_DISCOUNT] = discountTextField.text;
    invoiceDict[INVOICE_DISCOUNT_PRICE] = discountPriceTextField.text;
    invoiceDict[TAX_TOTAL_AMOUNT] = totalAmountTextField.text;
    invoiceDict[TAX_PAYMENT_DATE] = paymentDateTextField.text;
    invoiceDict[TAX_PAID_AMOUNT] = paidAmountTextField.text;
    invoiceDict[TAX_PAID_STATUS] = paidStatusTextField.text;
    invoiceDict[TAX_DISCLAIMER] = disclaimerTextTextField.text;
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:invoiceDict];
    [sharedInstance save:dict withRef:ref withChild:INVOICE withUUID:FIRAuth.auth.currentUser.uid withCompletionHandler:^{
//        [sharedInstance fallback:self.navigationController];
        [self performSegueWithIdentifier:@"invoice" sender:self];
    }];
}

-(void)fetchCustomerDetailsIfAny{
    [sharedInstance fetch:CUSTOMER withRef:ref withUUID:FIRAuth.auth.currentUser.uid withCompletionHandler:^(NSMutableArray * _Nonnull userInfoArray) {
        detailsArray = [NSArray arrayWithArray:userInfoArray];
    }];
}

-(void)showingCustomerDetailsIfAny{
    if(detailsArray.count>0){
        [self textFieldResignFirstResponder];
        CountryListTableViewController *vc = (CountryListTableViewController *)[sharedInstance storyboard:COUNTRY_LIST_CONTROLLER];
        vc.delegate = self;
        vc.customerDetailsArray = detailsArray;
        [sharedInstance present:self.navigationController withController:vc];
    }
}

-(void)textFieldResignFirstResponder {
    [customerNameTextField resignFirstResponder];
    [companyNameTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
}

#pragma mark - ACTIONS
-(IBAction)createInvoiceButtonTapped:(UIButton *)sender {
    if(snapshot.value == NULL){
        [self saveData];
    }else{
        
        NSMutableDictionary *invoiceDict = [[NSMutableDictionary alloc]init];
        if(selectType == nil){
            selectType = TAX_INVOICE;
        }
        invoiceDict[SELECT_TYPE] = selectType;
        invoiceDict[CUSTOMER_NAME] = customerNameTextField.text;
        invoiceDict[CUSTOMER_EMAIL] = emailTextField.text;
        invoiceDict[CUSTOMER_COMPANY] = companyNameTextField.text;
        invoiceDict[ITEM_NAME_1] = itemNameTextField1.text;
        invoiceDict[ITEM_DESCRIPTION_1] = descriptionTextField1.text;
        invoiceDict[ITEM_PRICE_1] = priceTextField1.text;
        invoiceDict[ITEM_QTY_1] = qtyTextField1.text;
        invoiceDict[ITEM_NAME_2] = itemNameTextField2.text;
        invoiceDict[ITEM_DESCRIPTION_2] = descriptionTextField2.text;
        invoiceDict[ITEM_PRICE_2] = priceTextField2.text;
        invoiceDict[ITEM_QTY_2] = qtyTextField2.text;
        invoiceDict[ITEM_NAME_3] = itemNameTextField3.text;
        invoiceDict[ITEM_DESCRIPTION_3] = descriptionTextField3.text;
        invoiceDict[ITEM_PRICE_3] = priceTextField3.text;
        invoiceDict[ITEM_QTY_3] = qtyTextField3.text;
        invoiceDict[ITEM_SUB_TOTAL] = subTotalTextField.text;
        invoiceDict[ITEM_TAX_AMOUNT] = taxAmountTextField.text;
        invoiceDict[ITEM_TOTAL] = totalTextField.text;
        invoiceDict[INVOICE_NUMBER] = invoiceNumberTextField.text;
        invoiceDict[INVOICE_CREATED_DATE] = createdDateTextField.text;
        invoiceDict[INVOICE_AMOUNT] = amountTextField.text;
        invoiceDict[INVOICE_CURRENCY] = currencyTextField.text;
        invoiceDict[INVOICE_DISCOUNT] = discountTextField.text;
        invoiceDict[INVOICE_DISCOUNT_PRICE] = discountPriceTextField.text;
        invoiceDict[TAX_TOTAL_AMOUNT] = totalAmountTextField.text;
        invoiceDict[TAX_PAYMENT_DATE] = paymentDateTextField.text;
        invoiceDict[TAX_PAID_AMOUNT] = paidAmountTextField.text;
        invoiceDict[TAX_PAID_STATUS] = paidStatusTextField.text;
        invoiceDict[TAX_DISCLAIMER] = disclaimerTextTextField.text;
        NSDictionary *customerDict = [NSDictionary dictionaryWithDictionary:invoiceDict];
        [sharedInstance updateInfo:ref withUpdates:customerDict withKey:snapshot.key withChild:INVOICE];
//        [sharedInstance fallback:self.navigationController];
        [self performSegueWithIdentifier:@"invoice" sender:self];
    }
}

-(IBAction)selectTypeSegmentControl:(UISegmentedControl *)sender {
    switch(sender.selectedSegmentIndex) {
        case 0:
            selectType = @"Tax Invoice";
            break;
        case 1:
            selectType = @"Retail Invoice";
            break;
    }
}

-(IBAction)datePickerSelected:(UIDatePicker *)sender {
    if([textFieldType  isEqual: @"createdDateTextField"]){
        createdDateTextField.text = [NSString stringWithFormat:@"%@", [[self dateFormatter]stringFromDate:sender.date]];
    }else{
        paymentDateTextField.text = [NSString stringWithFormat:@"%@", [[self dateFormatter]stringFromDate:sender.date]];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if(textField == createdDateTextField){
        textFieldType = @"createdDateTextField";
        [self hideDatePicker:NO];
    }else if(textField == paymentDateTextField){
        textFieldType = @"paymentDateTextField";
        [self hideDatePicker:NO];
    }else if((textField == customerNameTextField) || (textField == companyNameTextField) || (textField == emailTextField)){
        [self showingCustomerDetailsIfAny];
    }
}

- (NSString *)getTotalValue:(NSString *)initialText withText:(NSString *)secondaryText withDiscountOrTax:(NSString *)value withStatus:(CalculateTotal)status {
    switch (status) {
        case tax:
            return [NSString stringWithFormat: @"%.2f", (double)(([initialText integerValue]*[secondaryText integerValue])/100)+[value integerValue]];
        case discount:
            return [NSString stringWithFormat: @"%.2f", (double)[value integerValue]-(([initialText integerValue]*[secondaryText integerValue])/100)];
        default:
            break;
    }
    return @"";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField == subTotalTextField && ![taxAmountTextField.text isEqualToString:@""]) {
        totalTextField.text = @"";
        NSString *updatedText = [subTotalTextField.text stringByReplacingCharactersInRange:range withString:string];
        totalTextField.text = [self getTotalValue:updatedText withText:taxAmountTextField.text withDiscountOrTax:updatedText withStatus:tax];
    }else if(textField == taxAmountTextField && ![subTotalTextField.text isEqualToString:@""]) {
        totalTextField.text = @"";
        NSString *updatedText = [taxAmountTextField.text stringByReplacingCharactersInRange:range withString:string];
        totalTextField.text = [self getTotalValue:subTotalTextField.text withText:updatedText withDiscountOrTax:subTotalTextField.text withStatus:tax];
    }else if(textField == amountTextField && ![discountTextField.text isEqualToString:@""]) {
        discountPriceTextField.text = @"";
        NSString *updatedText = [amountTextField.text stringByReplacingCharactersInRange:range withString:string];
        discountPriceTextField.text = [self getTotalValue:updatedText withText:discountTextField.text withDiscountOrTax:updatedText withStatus:discount];
    }else if(textField == discountTextField && ![amountTextField.text isEqualToString:@""]) {
        discountPriceTextField.text = @"";
        NSString *updatedText = [discountTextField.text stringByReplacingCharactersInRange:range withString:string];
        discountPriceTextField.text = [self getTotalValue:amountTextField.text withText:updatedText withDiscountOrTax:amountTextField.text withStatus:discount];
    }
    else if(textField == priceTextField1 && ![qtyTextField1.text isEqualToString:@""]) {
        subTotalTextField.text = @"";
        if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {
        NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
        subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField1.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue]+[priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField1.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue])];
        }else if(![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField1.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else{
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField1.text integerValue]];
        }
    }else if(textField == qtyTextField1 && ![priceTextField1.text isEqualToString:@""]){
        subTotalTextField.text = @"";
        if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {

        NSString *updatedText = [qtyTextField1.text stringByReplacingCharactersInRange:range withString:string];
        subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField1.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue]+[priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField1.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue])];
        }else if(![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField1.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else{
            NSString *updatedText = [priceTextField1.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField1.text integerValue]];
        }
    }else if(textField == priceTextField2 && ![qtyTextField2.text isEqualToString:@""]) {
        subTotalTextField.text = @"";
        if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {

            NSString *updatedText = [priceTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField2.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue]+[priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField2.text integerValue]+([priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField2.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else{
            NSString *updatedText = [priceTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField2.text integerValue]];
        }
        
    }else if(textField == qtyTextField2 && ![priceTextField2.text isEqualToString:@""]){
        subTotalTextField.text = @"";
        if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {

            NSString *updatedText = [qtyTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField2.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue]+[priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {
            NSString *updatedText = [qtyTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField2.text integerValue]+([priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {
            NSString *updatedText = [qtyTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField2.text integerValue]+([priceTextField3.text doubleValue]*[qtyTextField3.text integerValue])];
        }else{
            NSString *updatedText = [qtyTextField2.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField2.text integerValue]];
        }
        
    }else if(textField == priceTextField3 && ![qtyTextField3.text isEqualToString:@""]) {
        subTotalTextField.text = @"";
        if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""] && ![qtyTextField3.text isEqualToString:@""]) {

            NSString *updatedText = [priceTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField3.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue]+[priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField3.text integerValue]+([priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""]) {
            NSString *updatedText = [priceTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField3.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue])];
        }else{
            NSString *updatedText = [priceTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[qtyTextField3.text integerValue]];
        }
    }else if(textField == qtyTextField3 && ![priceTextField3.text isEqualToString:@""]){
        
        subTotalTextField.text = @"";
        if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""] && ![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {

            NSString *updatedText = [qtyTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField3.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue]+[priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {
            NSString *updatedText = [qtyTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField3.text integerValue]+([priceTextField1.text doubleValue]*[qtyTextField1.text integerValue])];
        }else if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""]) {
            NSString *updatedText = [qtyTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField3.text integerValue]+([priceTextField2.text doubleValue]*[qtyTextField2.text integerValue])];
        }else{
            NSString *updatedText = [qtyTextField3.text stringByReplacingCharactersInRange:range withString:string];
            subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[updatedText integerValue]*[priceTextField3.text integerValue]];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //    if(textField == priceTextField1 || textField == priceTextField2 || textField == priceTextField3) {
    //        if(![priceTextField1.text isEqualToString:@""] && ![qtyTextField1.text isEqualToString:@""]) {
    //            if([subTotalTextField.text isEqualToString:@""]){
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[priceTextField1.text integerValue]*[qtyTextField1.text integerValue]];
    //            }else{
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[priceTextField1.text integerValue]*[qtyTextField1.text integerValue]+[subTotalTextField.text doubleValue]];
    //            }
    //        }else if(![priceTextField2.text isEqualToString:@""] && ![qtyTextField2.text isEqualToString:@""]) {
    //            if([subTotalTextField.text isEqualToString:@""]){
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[priceTextField2.text integerValue]*[qtyTextField2.text integerValue]];
    //            }else{
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[priceTextField2.text integerValue]*[qtyTextField2.text integerValue]+[subTotalTextField.text doubleValue]];
    //            }
    //
    //        }else if(![qtyTextField3.text isEqualToString:@""] && ![priceTextField3.text isEqualToString:@""]){
    //            if([subTotalTextField.text isEqualToString:@""]){
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[qtyTextField3.text integerValue]*[priceTextField3.text integerValue]];
    //            }else{
    //                subTotalTextField.text = [NSString stringWithFormat:@"%.2f", (double)[qtyTextField3.text integerValue]*[priceTextField3.text integerValue]+[subTotalTextField.text doubleValue]];
    //
    //            }
    //        }
    //    }
}

- (void)getValue:(NSArray *)value withIndex:(NSInteger)index {
    if(value.count>0){
        FIRDataSnapshot *snapshot = value[index];
        customerNameTextField.text = snapshot.value[CUSTOMER_NAME];
        companyNameTextField.text = snapshot.value[CUSTOMER_COMPANY];
        emailTextField.text = snapshot.value[CUSTOMER_EMAIL];
    }
}



@end
