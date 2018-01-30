//
//  PPCPaperKey_2_ViewController.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 30/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCViewController.h"

@interface PPCPaperKey_2_ViewController : PPCViewController

@property (nonatomic, weak) id <PPCWalletManagementDelegate> delegate;

- (void) setArrayOfWords: (NSArray *) arrayOfWords;


@end
