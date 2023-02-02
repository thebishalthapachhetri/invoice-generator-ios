//
//  UIView+CustomView.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "UIView+CustomView.h"

@implementation UIView (CustomView)

- (void)setCustomBorderColor:(UIColor *)color withBorderWith:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)shadow:(UIColor *)shadowColor withRadius:(CGFloat)radius withOffSet:(CGSize)offSet withOpacity:(CGFloat)opacity{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offSet;
    self.layer.shadowOpacity = opacity;
}

- (void)setCustomCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = true;
}
@end
