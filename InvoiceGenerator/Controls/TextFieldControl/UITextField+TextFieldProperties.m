//
//  UITextField+TextFieldProperties.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "UITextField+TextFieldProperties.h"

@implementation UITextField (TextFieldProperties)

-(void)setCustomCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}

-(void)setCustomBorderColor:(UIColor *)color withWidth:(CGFloat)borderWidth {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
}

-(void)setCustomLeftView:(CGRect)rect {
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = [[UIView alloc]initWithFrame:rect];
}

-(void)setCustomRightView:(CGRect)rect {
    
    self.rightViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 25, 18)];
    imageView.image = [[UIImage systemImageNamed: @"chevron.down"]imageWithTintColor:[UIColor lightGrayColor]];
    UIView *customView = [[UIView alloc]initWithFrame:rect];
    [customView addSubview:imageView];
    self.rightView = customView;
}

@end
