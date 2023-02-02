//
//  CustomOptionsView.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "CustomOptionView.h"
#import "UIView+CustomView.h"

@implementation CustomOptionView
@synthesize contentView;

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [contentView setCustomCornerRadius:10];
        [contentView setCustomBorderColor:[UIColor lightGrayColor] withBorderWith:1];
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


-(void)commonInit {
    [[NSBundle mainBundle] loadNibNamed:@"CustomOptionsView" owner:self options:nil];
    [self addSubview:self.contentView];
//    self.view.frame = self.bounds;
}

-(IBAction)helpButtonTapped:(UIButton *)sender {
    
}

-(IBAction)shareButtonTapped:(UIButton *)sender {
    
}

@end
