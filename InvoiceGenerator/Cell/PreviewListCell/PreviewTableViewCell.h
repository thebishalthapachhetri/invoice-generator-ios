//
//  PreviewTableViewCell.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *customerCompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *itemDescriptionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemSubtotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemTaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceCreatedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceDiscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *invoiceTotalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPaymentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPaidAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPaidStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalDisclaimerTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedTypeLabel;

@end

NS_ASSUME_NONNULL_END
