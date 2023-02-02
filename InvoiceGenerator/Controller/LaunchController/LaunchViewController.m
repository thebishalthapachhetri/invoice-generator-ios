//
//  LaunchViewController.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "LaunchViewController.h"
#import "NSObject+AppCoordinator.h"
#import "InvoiceTableViewController.h"
#import "SignInViewController.h"
#import "Constants.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController
NSObject *sharedInstance;

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedInstance = [[NSObject alloc]init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:NO block:^(NSTimer * _Nonnull timer) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
            UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:SIGN_IN_CONTROLLER];
            [self.navigationController pushViewController:vc animated:NO];

    }];
}

@end
