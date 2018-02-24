//
//  PPCUserSettings.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 23/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPCUserSettings : NSObject

@property (nonatomic) NSDateFormatterStyle dateFormatterStyle;


+ (PPCUserSettings *) shared;
- (void) clearAllSettings;


@end
