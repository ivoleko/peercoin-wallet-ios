//
//  PPCRoundButton.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCRoundButton.h"

@implementation PPCRoundButton

- (id) init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    NSAssert(NO, @"buttonWithType: not supported");
    return nil;
}

- (void) commonInit {
    [self roundMask:3.0];
    self.roundButtonType = PPCRoundButtonTypeGreen;
}

- (void) setRoundButtonType:(PPCRoundButtonType)roundButtonType {
    _roundButtonType = roundButtonType;
    
    if (roundButtonType == PPCRoundButtonTypeGreen) {
        self.backgroundColor = kPPCColor_green;
        [self setTitleColor:kPPCColor_white forState:UIControlStateNormal];
    }
    else if (roundButtonType == PPCRoundButtonTypeDark) {
        self.backgroundColor = kPPCColor_dark;
        [self setTitleColor:kPPCColor_white forState:UIControlStateNormal];
    }
    else if (roundButtonType == PPCRoundButtonTypeWhite) {
        self.backgroundColor = kPPCColor_white;
        [self setTitleColor:kPPCColor_green forState:UIControlStateNormal];
    }
}

- (void) setEnabled:(BOOL)enabled {
    enabled = enabled;
    self.alpha = enabled ? 1.0 : 0.5;
}

- (void) setHighlighted:(BOOL)highlighted {
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:highlighted ? 0.8 : 1.0];
}

@end
