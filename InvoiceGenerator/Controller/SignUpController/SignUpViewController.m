//
//  SignUpViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "SignUpViewController.h"


@interface SignUpViewController () 
@end

@implementation SignUpViewController
@synthesize customView;
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize emailTextField;
@synthesize confirmPasswordTextField;
@synthesize companyNameTextField;
@synthesize countryTextField;
@synthesize termsAndConditionsLabel;
@synthesize signInButton;
@synthesize signUpButton;
@synthesize termsAndConditionsButton;
@synthesize createAnAccountLabel;
@synthesize ref;
NSObject *sharedInstance;

#pragma mark - VIEWLIFECYCLE METHODS

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SIGN_UP;
    sharedInstance = [[NSObject alloc]init];
    ref = [[FIRDatabase database]reference];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setEmpty];
}


#pragma mark - SETUPUI METHOD
-(void)setUpUI {
    
    [usernameTextField setCustomCornerRadius:25];
    [usernameTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [usernameTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [emailTextField setCustomCornerRadius:25];
    [emailTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [emailTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [signUpButton setCustomCornerRadius:25];
    [passwordTextField setCustomCornerRadius:25];
    [passwordTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [passwordTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [confirmPasswordTextField setCustomCornerRadius:25];
    [confirmPasswordTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [confirmPasswordTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [companyNameTextField setCustomCornerRadius:25];
    [companyNameTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [companyNameTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [countryTextField setCustomCornerRadius:25];
    [countryTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [countryTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [countryTextField setCustomRightView:CGRectMake(10, 10, 50, 40)];
    [signUpButton setCustomCornerRadius:25];
    [customView setCustomBorderColor:[UIColor whiteColor] withBorderWith:2];
    
}

-(void)setEmpty {
    usernameTextField.text = EMPTY_STRING;
    passwordTextField.text = EMPTY_STRING;
    emailTextField.text = EMPTY_STRING;
    confirmPasswordTextField.text = EMPTY_STRING;
    companyNameTextField.text = EMPTY_STRING;
    countryTextField.text = EMPTY_STRING;
    countryTextField.delegate = self;
}

-(void)validations:(void (^)(void))completionHandler {
    if(![usernameTextField.text isEqual:EMPTY_STRING] || ![emailTextField.text isEqual:EMPTY_STRING] || ![passwordTextField.text isEqual:EMPTY_STRING] || ![confirmPasswordTextField.text isEqual:EMPTY_STRING] || ![companyNameTextField.text isEqual:EMPTY_STRING] || ![countryTextField.text isEqual:EMPTY_STRING]) {
        if(![passwordTextField.text isEqual:confirmPasswordTextField.text]){
            [sharedInstance show:SIGN_UP withMessage:@"Password and Confirm password not matching."];
        }else{
            if(termsAndConditionsButton.isSelected == YES) {
                [self signUpData:^{
                    completionHandler();
                }];
            }else{
                [sharedInstance show:SIGN_UP withMessage:@"Please select Terms and Conditions."];
            }
        }
    }else{
        [sharedInstance show:SIGN_UP withMessage:@"All fields are required."];
    }
}

-(void)signUpData:(void (^)(void))completionHandler {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [dict setValue:usernameTextField.text forKey:USERNAME];
    [dict setValue:emailTextField.text forKey: EMAIL_ID];
    [dict setValue:passwordTextField.text forKey:PASSWORD];
    [dict setValue:confirmPasswordTextField.text forKey:CONFIRM_PASSWORD];
    [dict setValue:companyNameTextField.text forKey: COMPANY_NAME];
    [dict setValue:countryTextField.text forKey:COUNTRY];
    [dict setValue:SELECTED forKey:TERMS_AND_CONDITIONS];
    [array addObject:dict];
    NSDictionary *signUpInfoDict = [NSDictionary dictionaryWithDictionary:dict];
    [sharedInstance signUp:signUpInfoDict withRef:ref withCompletionHandler:^(NSString * _Nonnull err) {
        if([err isEqual:EMPTY_STRING]){
            completionHandler();
        }else{
            [sharedInstance show:SIGN_UP withMessage:err];
        }
    }];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = REGEX;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:FORMAT, emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - ACTIONS

-(IBAction)signUpButtonTapped:(UIButton *)sender {
    [self validations:^{
        [self performSegueWithIdentifier:INVOICE_CONTROLLER sender:sender];
    }];
}

-(IBAction)signInButtonTapped:(UIButton *)sender { }

-(IBAction)termsAndConditionsButtonTapped:(UIButton *)sender {
    if([termsAndConditionsButton isSelected] == YES){
        termsAndConditionsButton.selected = NO;
    }else{
        termsAndConditionsButton.selected = YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if(textField == countryTextField){
        [textField resignFirstResponder];
    }
}

- (void)getValue:(NSArray *)value withIndex:(NSInteger)index {
    if(value.count>0){
        countryTextField.text = value[index];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"SignUpCountryField"]){
        CountryListTableViewController *vc = [segue destinationViewController];
        vc.delegate = self;
    }
}


@end
