//
//  NSObject+FirebaseStorage.m
//  InvoiceGenerator
//
//  Created by Bishal Thapa Chhetri on 19/04/22.
//

#import "NSObject+FirebaseStorage.h"
#import "NSObject+CustomAlert.h"
@import MBProgressHUD;
@import Network;
@import AFNetworking;

@implementation NSObject (FirebaseStorage)

- (void)signIn:(NSString *)email withPassword:(NSString *)password withCompletionHandler:(void (^)(NSString *err))completionHandler {
    [self show];
    [[FIRAuth auth]signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        [self hide];
        if(error == NULL) {
            completionHandler(@"");
        }else{
            completionHandler(error.localizedDescription);
        }
    }];
}

- (void)signUp:(NSDictionary *)userInfoDict withRef:(FIRDatabaseReference *)ref withCompletionHandler:(void (^)(NSString *err))completionHandler {
    
    [self show];
    [[FIRAuth auth]createUserWithEmail:userInfoDict[@"email"] password:userInfoDict[@"password"] completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        [self hide];
        if(error == NULL) {
            [[[ref child:@"Users"]child:authResult.user.uid]setValue:userInfoDict];
            completionHandler(@"");
        }else{
            completionHandler(error.localizedDescription);
        }
    }];
}

- (void)save:(NSDictionary *)infoDict withRef:(FIRDatabaseReference *)ref withChild:(NSString *)child withUUID:(NSString *)uid withCompletionHandler:(void(^)(void))completionHandler {
    [self show];
    [[[[ref child:child]child:uid]childByAutoId]setValue:infoDict];
    [self hide];
    completionHandler();
}

- (void)fetch:(NSString *)child withRef:(FIRDatabaseReference *)ref withUUID:(NSString *)uid withCompletionHandler:(void (^)(NSMutableArray *userInfoArray))completionHandler {
    [self show];
    NSMutableArray *infoArray = [[NSMutableArray alloc]init];
    
    FIRDatabaseReference *reference = [[ref child:child]child:uid];
    [reference observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        if(snapshot.exists) {
            [infoArray addObject:snapshot];
            completionHandler(infoArray);
        }else{
            completionHandler(infoArray);
        }
    }];
    [self hide];
}

-(void)updateInfo:(FIRDatabaseReference *)ref withUpdates:(NSDictionary *)customerUpdatedInfo withKey:(NSString *)key withChild:(NSString *)child {
    NSDictionary *infoDict = @{[NSString stringWithFormat:@"/%@/%@/%@/",child, FIRAuth.auth.currentUser.uid, key]: customerUpdatedInfo};
    [ref updateChildValues:infoDict];
}

-(void)delete:(FIRDatabaseReference *)ref withChild:(NSString *)child withUID:(NSString *)uid withAutoID:(NSString *)autoID {
    [self show];
    [[[[ref child:child]child:uid]child:autoID]removeValue];
    [self hide];
}

-(void)show {
    [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow.rootViewController.view animated:YES];
}

-(void)hide {
    [MBProgressHUD hideHUDForView:UIApplication.sharedApplication.keyWindow.rootViewController.view animated:YES];
}

-(BOOL)checkingInterConnectionAvailble {
    __block BOOL isInternetAvailable = NO;
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%@",AFStringFromNetworkReachabilityStatus(status));
        if(status == AFNetworkReachabilityStatusReachableViaWiFi) {
            isInternetAvailable = YES;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager]startMonitoring];
    return isInternetAvailable;
}

@end

