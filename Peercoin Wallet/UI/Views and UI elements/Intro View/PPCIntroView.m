//
//  PPCIntroView.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCIntroView.h"

@implementation PPCIntroView

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

- (void) commonInit {
    [[NSBundle mainBundle] loadNibNamed:@"PPCIntroView" owner:self options:nil];
    self.baseView.backgroundColor = kPPCColor_dark;
    self.baseView.frame = self.bounds;
    self.baseView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.baseView];
    self.backgroundColor = [UIColor clearColor];
}
@end
