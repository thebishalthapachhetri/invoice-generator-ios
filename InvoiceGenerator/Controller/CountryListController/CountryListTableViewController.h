//
//  CountryListTableViewController.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
#import "Constants.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    name,
    company,
    email,
} Customer;

#pragma mark - Protocol
@protocol FetchValueProtocol <NSObject>
@required
-(void)getValue:(NSArray *)value withIndex:(NSInteger)index;

@end

@interface CountryListTableViewController : UITableViewController
@property (weak,nonatomic) id<FetchValueProtocol> delegate;
@property (weak,nonatomic) NSArray *customerDetailsArray;
@end

NS_ASSUME_NONNULL_END
