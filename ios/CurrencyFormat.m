#import "CurrencyFormat.h"
#import "StoreManager.h"

@implementation CurrencyFormat

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(format:(NSNumber * __nonnull)amount currencyCode:(NSString * __nonnull)currencyCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:(NSString *) currencyCode];
    resolve([formatter stringFromNumber:amount]);
}

RCT_EXPORT_METHOD(getStoreInfo:(NSString * __nonnull)productId resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    [[StoreManager shared] requestAppStoreInfoFor:productId resolver:resolve rejecter:reject];
}

@end
