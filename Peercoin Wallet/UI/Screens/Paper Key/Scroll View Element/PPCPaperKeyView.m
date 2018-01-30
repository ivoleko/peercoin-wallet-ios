//
//  PPCPaperKeyView.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 30/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPaperKeyView.h"

@implementation PPCPaperKeyView

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
    [[NSBundle mainBundle] loadNibNamed:@"PPCPaperKeyView" owner:self options:nil];
    self.mainView.frame = self.bounds;
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mainView.translatesAutoresizingMaskIntoConstraints = YES;
    [self addSubview:self.mainView];
    
    [self.viewCircle setBackgroundColor:kPPCColor_green];
    [self.viewCircle circleMask];
    
    self.label.textColor = kPPCColor_white;
    self.label.alpha = 0.0;
    
}

- (void) showLabelWithAnimation: (BOOL) animation {
    if (self.label.alpha == 1.0)
        return;
    
    if (animation) {
        [UIView animateWithDuration:0.35 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.label.alpha = 1.0;

        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        self.label.alpha = 1.0;
    }
}

@end
