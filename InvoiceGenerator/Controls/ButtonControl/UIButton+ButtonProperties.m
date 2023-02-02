//
//  UIButton+ButtonProperties.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "UIButton+ButtonProperties.h"

@implementation UIButton (ButtonProperties)

-(void)setCustomCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}
@end
