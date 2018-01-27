//
//  BlocksAndProtocols.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#ifndef BlocksAndProtocols_h
#define BlocksAndProtocols_h
#import <Foundation/Foundation.h>

@protocol PPCWalletCreationDelegate 

- (void) walletSuccesfullyCreated;
- (void) walletSuccesfullyRecovered;
- (void) walletOperationCanceled;

@end


#endif /* BlocksAndProtocols_h */
