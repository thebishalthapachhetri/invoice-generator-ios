//
//  UIView+CustomView.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CustomView)
-(void)setCustomBorderColor:(UIColor *)color withBorderWith:(CGFloat)width;
-(void)shadow:(UIColor *)shadowColor withRadius:(CGFloat)radius withOffSet:(CGSize)offSet withOpacity:(CGFloat)opacity;
-(void)setCustomCornerRadius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
