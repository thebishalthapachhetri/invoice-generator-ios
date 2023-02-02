//
//  NSObject+AppCoordinator.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppCoordinator)

-(UIViewController *)storyboard:(NSString *)identifier;
- (void)navigate:(UINavigationController *)navigationController withController:(UIViewController *)controller;
-(void)fallback:(UINavigationController *)navigationController;
-(void)fallbackToViewController:(UINavigationController *)navigationController withController:(UIViewController *)controller;
-(void)present:(UINavigationController *)navigationController withController:(UIViewController *)controller;
@end

NS_ASSUME_NONNULL_END
