//
//  InvoiceDetailsViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseDatabase;
@import FirebaseAuth;
#import "Constants.h"
#import "CountryListTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface InvoiceDetailsViewController : UIViewController<UITextFieldDelegate,FetchValueProtocol>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField1;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField1;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField1;
@property (weak, nonatomic) IBOutlet UITextField *qtyTextField1;
@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField2;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField2;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField2;
@property (weak, nonatomic) IBOutlet UITextField *qtyTextField2;
@property (weak, nonatomic) IBOutlet UITextField *itemNameTextField3;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField3;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField3;
@property (weak, nonatomic) IBOutlet UITextField *qtyTextField3;
@property (weak, nonatomic) IBOutlet UITextField *subTotalTextField;
@property (weak, nonatomic) IBOutlet UITextField *taxAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalTextField;
@property (weak, nonatomic) IBOutlet UITextField *invoiceNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *createdDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *currencyTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountTextField;
@property (weak, nonatomic) IBOutlet UITextField *discountPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *paidAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *paidStatusTextField;
@property (weak, nonatomic) IBOutlet UITextField *disclaimerTextTextField;
@property (weak, nonatomic) IBOutlet UIView *customerDetailsView;
@property (weak, nonatomic) IBOutlet UIView *itemDescriptionView;
@property (weak, nonatomic) IBOutlet UIView *goodsAndServiceView;
@property (weak, nonatomic) IBOutlet UIView *totalAmountView;
@property (weak, nonatomic) IBOutlet UIButton *createInvoiceButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic)FIRDatabaseReference *ref;
@property (weak, nonatomic) FIRDataSnapshot *snapshot;
@end

NS_ASSUME_NONNULL_END
