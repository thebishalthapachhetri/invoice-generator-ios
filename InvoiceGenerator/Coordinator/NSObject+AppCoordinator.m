//
//  NSObject+AppCoordinator.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "NSObject+AppCoordinator.h"
#import "Constants.h"

@implementation NSObject (AppCoordinator)

-(UIViewController *)storyboard:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:MAIN bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

- (void)navigate:(UINavigationController *)navigationController withController:(UIViewController *)controller {
    [navigationController pushViewController:controller animated:YES];
}

- (void)fallback:(UINavigationController *)navigationController {
    [navigationController popViewControllerAnimated:YES];
}

- (void)fallbackToViewController:(UINavigationController *)navigationController withController:(UIViewController *)controller {
    [navigationController popToViewController:controller animated:YES];
}

- (void)present:(UINavigationController *)navigationController withController:(UIViewController *)controller {
    [navigationController presentViewController:controller animated:YES completion:nil];
}

@end
