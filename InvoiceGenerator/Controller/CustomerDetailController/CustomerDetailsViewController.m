//
//  CustomerDetailsViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.s
//

#import "CustomerDetailsViewController.h"
#import "UITextField+TextFieldProperties.h"
#import "UIButton+ButtonProperties.h"
#import "NSObject+FirebaseStorage.h"
#import "NSObject+CustomAlert.h"
#import "NSObject+AppCoordinator.h"
#import "CustomerTableViewController.h"


@interface CustomerDetailsViewController ()

@end

@implementation CustomerDetailsViewController
@synthesize customerNameTextField;
@synthesize emailTextField;
@synthesize companyNameTextField;
@synthesize addCustomerButton;
@synthesize ref;
@synthesize snapshot;
@synthesize isEditable;
NSObject *sharedInstance;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Invoice Details";
    [self setUpUI];
    sharedInstance = [[NSObject alloc]init];
    ref = [[FIRDatabase database]reference];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showingCustomerDetails];
}

-(void)setUpUI {
    
    [self setCustomProperties:customerNameTextField];
    [self setCustomProperties:emailTextField];
    [self setCustomProperties:companyNameTextField];
    [addCustomerButton setCustomCornerRadius:10];
}

-(void)setCustomProperties:(UITextField *)textField {
    [textField setCustomCornerRadius:10];
    [textField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [textField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
}

-(void)showingCustomerDetails {
    if(snapshot.value != NULL){
        [self editViews:NO];
        NSDictionary *dict = snapshot.value;
        customerNameTextField.text = dict[CUSTOMER_NAME];
        emailTextField.text = dict[CUSTOMER_EMAIL];
        companyNameTextField.text = dict[CUSTOMER_COMPANY];
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
        [self.addCustomerButton setTitle:@"Update Customer" forState:UIControlStateNormal];
    }
}

-(void)editViews:(BOOL)isEditable{
    customerNameTextField.enabled = isEditable;
    emailTextField.enabled = isEditable;
    companyNameTextField.enabled = isEditable;
    addCustomerButton.enabled = isEditable;
}

-(IBAction)addCustomerButtonTapped:(UIButton *)sender {
    if(snapshot.value == NULL){
        [self validations];
    }else{
        NSDictionary *customerDict = @{CUSTOMER_NAME: customerNameTextField.text,
                               CUSTOMER_EMAIL: emailTextField.text,
                               CUSTOMER_COMPANY: companyNameTextField.text};
        [sharedInstance updateInfo:ref withUpdates:customerDict withKey:snapshot.key withChild:CUSTOMER];
        
    }
}

-(void)validations {
    
    if(![customerNameTextField.text isEqual:EMPTY_STRING] || ![emailTextField.text isEqual:EMPTY_STRING] || ![companyNameTextField.text isEqual:EMPTY_STRING]) {
        [self customerData:^{
        }];
    }else{
        [sharedInstance show:@"Invoice Details" withMessage:@"All fields are required."];
    }
}

-(void)customerData:(void (^)(void))completionHandler {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue: customerNameTextField.text forKey:CUSTOMER_NAME];
    [dict setValue:emailTextField.text forKey: CUSTOMER_EMAIL];
    [dict setValue:companyNameTextField.text forKey:CUSTOMER_COMPANY];
    NSString *uid = FIRAuth.auth.currentUser.uid;
    NSLog(@"%@", uid);
    [sharedInstance save:dict withRef:ref withChild:CUSTOMER withUUID:uid withCompletionHandler:^{
        completionHandler();
    }];
}


@end
