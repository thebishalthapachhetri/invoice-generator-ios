//
//  ViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "SignInViewController.h"
#import "UITextField+TextFieldProperties.h"
#import "UIButton+ButtonProperties.h"
#import "NSObject+AppCoordinator.h"
#import "InvoiceTableViewController.h"
#import "SignUpViewController.h"
#import "NSObject+FirebaseStorage.h"
#import "NSObject+CustomAlert.h"

@interface SignInViewController ()
@end

@implementation SignInViewController
@synthesize emailIDTextField;
@synthesize passwordTextField;
@synthesize signInButton;
NSObject *sharedInstance;

#pragma mark - VIEWLIFECYCLE METHODS
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SIGN_IN;
    sharedInstance = [[NSObject alloc]init];
    self.navigationItem.hidesBackButton = true;
    if([FIRAuth auth].currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:INVOICE_CONTROLLER];
        [self.navigationController pushViewController:vc animated:NO];

    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    emailIDTextField.text = EMPTY_STRING;
    passwordTextField.text = EMPTY_STRING;
}

#pragma mark - SETUPUI METHOD
-(void)setUpUI {
    
    [emailIDTextField setCustomCornerRadius:25];
    [emailIDTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [emailIDTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [passwordTextField setCustomCornerRadius:25];
    [passwordTextField setCustomBorderColor:[UIColor lightGrayColor] withWidth:2];
    [passwordTextField setCustomLeftView:CGRectMake(10, 10, 20, 20)];
    [signInButton setCustomCornerRadius:25];
}

#pragma mark - ACTIONS

-(IBAction)signInButtonTapped:(UIButton *)sender {
    [sharedInstance signIn:emailIDTextField.text withPassword:passwordTextField.text withCompletionHandler:^(NSString * _Nonnull err) {
        if([err isEqual: EMPTY_STRING]) {
            [self performSegueWithIdentifier:INVOICE_CONTROLLER sender:sender];
        }else{
            [sharedInstance show:SIGN_IN withMessage:err];
        }
    }];
}

-(IBAction)signUpButtonTapped:(UIButton *)sender { }

- (IBAction)unwindToLoginViewController:(UIStoryboardSegue *)unwindSegue {}

@end
