//
//  PPCEnterPinViewController.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 29/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCViewController.h"
typedef void (^PPCPinAuthResponse)(NSError *error, BOOL userCanceled);



@interface PPCEnterPinViewController : PPCViewController

//configure before presenting
@property (nonatomic) BOOL showIntro;
@property (nonatomic) BOOL translucent;
@property (nonatomic) BOOL allowCancel;
@property (nonatomic) BOOL allowBiometrics;

//callback
- (void) setCallback: (PPCPinAuthResponse) block;
@end
