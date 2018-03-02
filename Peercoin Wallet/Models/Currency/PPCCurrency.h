//
//  PPCCurrency.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 24/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPCCurrency : NSObject

+ (PPCCurrency *) defaultCurrency; // USD by default
+ (NSArray <PPCCurrency *> *) arrayOfCurrencies;
+ (NSDictionary <NSString *, PPCCurrency *> *) dicOfCurrencies;


@property (nonatomic, strong, readonly) NSString *code;
@property (nonatomic, strong, readonly) NSString *symbol;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger decimalDigits;
@property (nonatomic, readonly) BOOL prefixSymbol;

- (id) initWithDictionary: (NSDictionary *)dic;


@end
