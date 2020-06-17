#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "StoreManager.h"

@interface StoreManager () <SKProductsRequestDelegate>

@property (strong, nonatomic) SKProductsRequest *request;
@property(nonatomic, retain) RCTPromiseResolveBlock resolve;
@property(nonatomic, retain) RCTPromiseRejectBlock reject;

@end

@implementation StoreManager: NSObject

+ (StoreManager *)shared {
    static dispatch_once_t onceToken;
    static StoreManager *shared;
    
    dispatch_once(&onceToken, ^{
        shared = [[StoreManager alloc] init];
    });
    return shared;
}

- (void) requestAppStoreInfoFor:(NSString * __nonnull)productId
                              resolver:(RCTPromiseResolveBlock)resolve
                              rejecter:(RCTPromiseRejectBlock)reject
{
    self.resolve = resolve;
    self.reject = reject;
    self.request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: productId]];
    self.request.delegate = self;
    [self.request start];
}

- (void) request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.reject(@"error", @"Error requesting product data", error);
}

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *storeProducts = response.products;
    if [storeProducts count] == 0 {
        NSError *err = [NSError errorWithDomain:@"org.domestika.error" code:404
                               userInfo:@{
                                           NSLocalizedDescriptionKey:@"Error finding product"
                               }];
        self.reject(@"error", @"Error finding product", error);
    } else {
        SKProduct *product = [storeProducts firstObject];
        NSLocale *storeLocale = product.priceLocale;
        NSString *countryCode = (NSString*)CFLocaleGetValue((CFLocaleRef)storeLocale, kCFLocaleCountryCode);
        NSString *currencyCode = (NSString*)CFLocaleGetValue((CFLocaleRef)storeLocale, kCFLocaleCurrencyCode);
        NSDictionary *storeInfo = [NSDictionary dictionaryWithObjectsAndKeys:
            countryCode, @"countryCode",
            currencyCode, @"currencyCode",
            nil
        ];
        self.resolve(storeInfo);
    }
}

@end
