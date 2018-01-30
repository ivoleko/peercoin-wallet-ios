//
//  PPCPINView.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPINView.h"

@implementation PPCPINView

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
    [[NSBundle mainBundle] loadNibNamed:@"PPCPINView" owner:self options:nil];
    self.mainView.frame = self.bounds;
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.mainView.translatesAutoresizingMaskIntoConstraints = YES;
    [self addSubview:self.mainView];
    _colorNormal = [UIColor blackColor];
    _colorHighlighted = [UIColor whiteColor];
  
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.mainView setNeedsLayout];
    [self.mainView layoutIfNeeded];
    for (UIView *view in self.collectionOfPinElements) {
        [view circleMask];
    }
}

- (void) setColorNormal:(UIColor *)colorNormal {
    _colorNormal = colorNormal;
    self.highlightCount = self.highlightCount;
}

- (void) setColorHighlighted:(UIColor *)colorHighlighted {
    _colorHighlighted = colorHighlighted;
    self.highlightCount = self.highlightCount;
}


- (void) setHighlightCount:(NSInteger)highlightCount {
    if (highlightCount > self.collectionOfPinElements.count)
        highlightCount = self.collectionOfPinElements.count;
    
    if (highlightCount < 0)
        highlightCount = 0;
    
    _highlightCount = highlightCount;
    
    for (NSInteger i = 0;  i < self.collectionOfPinElements.count; i++) {
        if (i < highlightCount)
            [(UIView *)self.collectionOfPinElements[i] setBackgroundColor:self.colorHighlighted];
        else
            [(UIView *)self.collectionOfPinElements[i] setBackgroundColor:self.colorNormal];
    }
}

- (void) shakeIt {
    
    CGRect frame = self.mainView.frame;
    
    [UIView animateKeyframesWithDuration:0.4 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            CGRect rect = frame;
            rect.origin.x -= 18;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.25 animations:^{
            CGRect rect = frame;
            rect.origin.x += 15;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.45 relativeDuration:0.2 animations:^{
            CGRect rect = frame;
            rect.origin.x -= 12;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.65 relativeDuration:0.15 animations:^{
            CGRect rect = frame;
            rect.origin.x += 9;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.1 animations:^{
            CGRect rect = frame;
            rect.origin.x -= 6;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.05 animations:^{
            CGRect rect = frame;
            rect.origin.x += 3;
            self.mainView.frame = rect;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.95 relativeDuration:0.05 animations:^{
            CGRect rect = frame;
            self.mainView.frame = rect;
        }];
    } completion:^(BOOL finished) {
        self.mainView.frame = frame;
    }];
}


@end
