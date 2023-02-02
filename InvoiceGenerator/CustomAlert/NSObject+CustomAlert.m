//
//  UIAlertController+CustomAlert.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "NSObject+CustomAlert.h"

@implementation NSObject (CustomAlert)

- (void)show:(NSString *)title withMessage:(NSString *)message {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [[[[UIApplication sharedApplication]keyWindow]rootViewController]presentViewController:alert animated:YES completion:^{
            
        }];
}

@end
