//
//  UIAlertController+CustomAlert.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CustomAlert)

-(void)show:(NSString *)title withMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
