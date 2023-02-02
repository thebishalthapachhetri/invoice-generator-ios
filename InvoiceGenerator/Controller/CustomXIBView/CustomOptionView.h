//
//  CustomOptionsView.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CustomOptionView : UIView
@property (weak,nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@end

NS_ASSUME_NONNULL_END
