//
//  SignUpViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

#import "CountryListTableViewController.h"
#import "UITextField+TextFieldProperties.h"
#import "UIButton+ButtonProperties.h"
#import "NSObject+FirebaseStorage.h"
#import "NSObject+AppCoordinator.h"
#import "InvoiceTableViewController.h"
#import "UIView+CustomView.h"
#import "NSObject+CustomAlert.h"
#import "CountryListTableViewController.h"
#import "Constants.h"

@import FirebaseDatabase;
@import Firebase;
@import FirebaseAuth;

NS_ASSUME_NONNULL_BEGIN


@interface SignUpViewController : UIViewController<UITextFieldDelegate,FetchValueProtocol>

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
@property (weak, nonatomic) IBOutlet UIButton *termsAndConditionsButton;
@property (weak, nonatomic) IBOutlet UILabel *termsAndConditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAnAccountLabel;
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet UIView *customCountryListView;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

NS_ASSUME_NONNULL_END
