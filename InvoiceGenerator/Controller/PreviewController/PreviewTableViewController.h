//
//  PreviewTableViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
#import "PreviewTableViewCell.h"
#import "Constants.h"
@import  Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
@import FirebaseCore;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    update,
} Status;

@protocol PreviewProtocol <NSObject>
@required
-(void)updateInvoice:(Status)status withSnapshot:(FIRDataSnapshot *)snapshot;

@end

@interface PreviewTableViewController : UITableViewController
//@property (readwrite, assign) NSInteger index;
@property (nonatomic) id<PreviewProtocol> delegate;
@property (weak, nonatomic) FIRDataSnapshot *snapshot;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@end

NS_ASSUME_NONNULL_END
