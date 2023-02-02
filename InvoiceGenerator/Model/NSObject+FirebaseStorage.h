//
//  NSObject+FirebaseStorage.h
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import <Foundation/Foundation.h>
@import Firebase;
@import FirebaseAuth;
@import FirebaseStorage;
@import FirebaseDatabase;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FirebaseStorage)

- (void)signIn:(NSString *)email withPassword:(NSString *)password withCompletionHandler:(void (^)(NSString *err))completionHandler;
- (void)signUp:(NSDictionary *)userInfoDict withRef:(FIRDatabaseReference *)ref withCompletionHandler:(void (^)(NSString *err))completionHandler;
- (void)save:(NSDictionary *)infoDict withRef:(FIRDatabaseReference *)ref withChild:(NSString *)child withUUID:(NSString *)uid withCompletionHandler:(void(^)(void))completionHandler;
- (void)fetch:(NSString *)child withRef:(FIRDatabaseReference *)ref withUUID:(NSString *)uid withCompletionHandler:(void (^)(NSMutableArray *userInfoArray))completionHandler;
-(void)updateInfo:(FIRDatabaseReference *)ref withUpdates:(NSDictionary *)customerUpdatedInfo withKey:(NSString *)key withChild:(NSString *)child;
-(void)delete:(FIRDatabaseReference *)ref withChild:(NSString *)child withUID:(NSString *)uid withAutoID:(NSString *)autoID;

@end

NS_ASSUME_NONNULL_END
