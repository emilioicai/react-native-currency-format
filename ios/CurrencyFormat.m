#import "CurrencyFormat.h"

@implementation CurrencyFormat

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(format:(NSNumber * __nonnull)amount currencyCode:(NSString * __nonnull)currencyCode resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject)
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:(NSString *) currencyCode];
    resolve([formatter stringFromNumber:amount]);
}

@end