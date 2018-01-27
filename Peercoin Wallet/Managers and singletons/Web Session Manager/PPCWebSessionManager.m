//
//  PPCWebSessionManager.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCWebSessionManager.h"

@implementation PPCWebSessionManager

+ (PPCWebSessionManager *) shared {
    static PPCWebSessionManager* _sharedPPCWebSessionManager = nil;
    static dispatch_once_t onceTokenPPCWebSessionManager;
    
    dispatch_once(&onceTokenPPCWebSessionManager, ^{
        _sharedPPCWebSessionManager = [[PPCWebSessionManager alloc] init];
        
    });
    
    return _sharedPPCWebSessionManager;
}




@end
