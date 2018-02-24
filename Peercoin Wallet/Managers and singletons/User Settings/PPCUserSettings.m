//
//  PPCUserSettings.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 23/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCUserSettings.h"
#define settings @"SettingsDefaults"

@interface PPCUserSettings ()

@end

@implementation PPCUserSettings

+ (PPCUserSettings *) shared {
    static PPCUserSettings* _sharedPPCUserSettings = nil;
    static dispatch_once_t onceTokenPPCUserSettings;
    
    dispatch_once(&onceTokenPPCUserSettings, ^{
        _sharedPPCUserSettings = [[PPCUserSettings alloc] init];
        [_sharedPPCUserSettings loadSettings];
    });
    
    return _sharedPPCUserSettings;
}

- (void) setDateFormatterStyle:(NSDateFormatterStyle)dateFormatterStyle {
    _dateFormatterStyle = dateFormatterStyle;
    [self saveSettings];
}

- (void) saveSettings {
    NSDictionary *dic = @{
                          @"dateStyle" : @((NSInteger)self.dateFormatterStyle)
                          };
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:settings];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadSettings {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:settings];
    if (dic == nil) {
        
        //set defaults
        self.dateFormatterStyle = NSDateFormatterMediumStyle;
        
        [self saveSettings];
        [self loadSettings];
        return;
    }
    
    self.dateFormatterStyle = (NSDateFormatterStyle)[dic[@"dateStyle"] integerValue];
}

- (void) clearAllSettings {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:settings];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




@end
