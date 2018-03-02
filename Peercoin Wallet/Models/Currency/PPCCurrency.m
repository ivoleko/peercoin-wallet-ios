//
//  PPCCurrency.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 24/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCCurrency.h"

static NSCharacterSet *symbolSet;

@implementation PPCCurrency


+ (PPCCurrency *) defaultCurrency {
    PPCCurrency *currency =  [[self dicOfCurrencies] objectForKey:@"USD"];
    NSAssert(currency, @"No USD currency!");
    return currency;
}

+ (NSArray <PPCCurrency *> *) arrayOfCurrencies {
    NSDictionary *dic = [self dicOfCurrencies];
    NSArray *array = [dic allValues];
    array = [array sortedArrayUsingComparator:^NSComparisonResult(PPCCurrency  * _Nonnull  obj1, PPCCurrency  * _Nonnull  obj2) {
        NSComparisonResult result = [obj1.code compare:obj2.code];
        return result;
    }];
    
    return array;
}

+ (NSDictionary <NSString *, PPCCurrency *> *) dicOfCurrencies {
    NSError *error = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Common-Currency" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:&error];
    NSAssert(data, error.localizedDescription);
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSAssert(data, error.localizedDescription);
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    
    for (NSString *key in [jsonData allKeys]) {
        NSDictionary *dic = [jsonData objectForKey:key];
        PPCCurrency *currency = [[PPCCurrency alloc] initWithDictionary:dic];
        [dicM setObject:currency forKey:key];
    }
    
    return [NSDictionary dictionaryWithDictionary:dicM];
}

- (id) initWithDictionary: (NSDictionary *)dic {
    self = [super init];
    if (self) {
        _code = dic[@"code"];
        _symbol = dic[@"symbol"];
        _name = dic[@"name"];
        _decimalDigits = [dic[@"decimal_digits"] integerValue];
        
        [self checkPrefixSymbol];
    }
    return self;
}

- (void) checkPrefixSymbol {
    if (symbolSet == nil)
        symbolSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    if ([_code rangeOfCharacterFromSet:symbolSet].length > 0)
        _prefixSymbol = YES;
    else
        _prefixSymbol = NO;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _code = [decoder decodeObjectForKey:@"code"];
        _symbol = [decoder decodeObjectForKey:@"symbol"];
        _name = [decoder decodeObjectForKey:@"name"];
        _decimalDigits = [[decoder decodeObjectForKey:@"decimal_digits"] integerValue];
        [self checkPrefixSymbol];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.symbol forKey:@"symbol"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:@(self.decimalDigits) forKey:@"decimal_digits"];
}

- (BOOL) isEqual:(id)object {
    if ([object isKindOfClass:[PPCCurrency class]]) {
        PPCCurrency *currency = object;
        if ([self.code isEqualToString:currency.code])
            return YES;
    }
    return [super isEqual:object];
}



@end
