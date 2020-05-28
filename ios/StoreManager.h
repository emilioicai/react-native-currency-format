#import <React/RCTBridgeModule.h>

#ifndef StoreManager_h
#define StoreManager_h


@interface StoreManager : NSObject <RCTBridgeModule>

+ (StoreManager *)shared;

- (void) requestAppStoreInfoFor:(NSString *)productId
                              resolver:(RCTPromiseResolveBlock)resolve
                              rejecter:(RCTPromiseRejectBlock)reject;

@end

#endif /* StoreManager_h */