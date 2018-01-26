//
//  PPCWebSessionManager.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface PPCWebSessionManager : AFHTTPSessionManager

+ (PPCWebSessionManager *) shared;

@end
