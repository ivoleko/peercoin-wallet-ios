//
//  PPCFirstLaunchViewController.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCViewController.h"

@interface PPCFirstLaunchViewController : PPCViewController

@property (nonatomic, weak) id <PPCWalletCreationDelegate> delegate;

@end
