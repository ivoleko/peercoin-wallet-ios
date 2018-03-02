//
//  PPCCurrencyConverter.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 25/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPCCurrency.h"
#import "PPCAmount.h"

typedef void (^PPCCurrencyManagerBlock)(BOOL success, NSError *error);
typedef enum {
    PPCCurrencyFormatterStyle_BalanceOverview = 0,
    PPCCurrencyFormatterStyle_BalanceTitle,
    PPCCurrencyFormatterStyle_SendAmount,
    PPCCurrencyFormatterStyle_SendAmountDetail,
    PPCCurrencyFormatterStyle_RequestAmount,
    PPCCurrencyFormatterStyle_RequestAmountDetail,
    PPCCurrencyFormatterStyle_Transaction
} PPCCurrencyFormatterStyle;


@interface PPCCurrencyManager : NSObject

+ (PPCCurrencyManager *) shared;

@property (nonatomic, strong, readonly) PPCCurrency *mainCurrency;

- (CGFloat) getAmountInBitcoinsFor: (PPCAmount *) peercoinAmount;
- (CGFloat) getAmountInMainCurrencyFor: (PPCAmount *) peercoinAmount;

- (PPCAmount *) getPeercoinAmountForBitcoins: (CGFloat) bitcoinAmount;
- (PPCAmount *) getPeercoinAmountForMainCurrency: (CGFloat) currencyAmount;

- (void) setMainCurrency: (PPCCurrency *) currency finished: (PPCCurrencyManagerBlock *) block;

@end

@interface PPCCurrencyManager (Formatter)

- (NSAttributedString *) getAttributedStringForPeercoinAmount: (PPCAmount *) amount
                                           withFormatterStyle: (PPCCurrencyFormatterStyle) formatterStyle;

@end
