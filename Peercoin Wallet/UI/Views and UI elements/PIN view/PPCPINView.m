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
    
    for (UIView *view in self.collectionOfPinElements) {
        [view circleMask];
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
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


@end
