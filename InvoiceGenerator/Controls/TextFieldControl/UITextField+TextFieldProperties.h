//
//  UITextField+TextFieldProperties.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (TextFieldProperties)
-(void)setCustomCornerRadius:(CGFloat)radius;
-(void)setCustomBorderColor:(UIColor *)color withWidth:(CGFloat)borderWidth;
-(void)setCustomLeftView:(CGRect)rect;
-(void)setCustomRightView:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
