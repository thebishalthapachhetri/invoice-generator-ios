//
//  CustomerDetailsViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
#import "Constants.h";
NS_ASSUME_NONNULL_BEGIN

@interface CustomerDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addCustomerButton;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak,nonatomic) FIRDataSnapshot *snapshot;
@property BOOL isEditable;
@end

NS_ASSUME_NONNULL_END
