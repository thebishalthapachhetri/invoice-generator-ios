//
//  CountryProtocol.h
//  InvoiceGenerator
//
//  Created by Aireddy Saikrishna on 23/03/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CountryProtocol <NSObject>
@required
-(void)getCountry:(NSString *)country;
@end

NS_ASSUME_NONNULL_END
