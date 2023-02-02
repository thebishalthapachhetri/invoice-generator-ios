//
//  CustomTableViewCell.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak,nonatomic) IBOutlet UILabel *itemCurrencyLabel;
@property (weak,nonatomic) IBOutlet UILabel *itemDescriptionlabel;
@property (weak,nonatomic) IBOutlet UILabel *itemQtyLabel;
@property (weak,nonatomic) IBOutlet UILabel *itemPriceLabel;
@end

NS_ASSUME_NONNULL_END
