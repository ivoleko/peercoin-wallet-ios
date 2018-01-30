//
//  PPCVirtualKeyboard.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 29/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCVirtualKeyboard.h"

@import AudioToolbox;

@interface PPCVirtualKeyboard ()
@property (weak, nonatomic) IBOutlet UIButton *buttonBackSpace;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *collectionOfButtons;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@end


@implementation PPCVirtualKeyboard

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
    [[NSBundle mainBundle] loadNibNamed:@"PPCVirtualKeyboard" owner:self options:nil];
    [self.buttonBackSpace setImage:[[self.buttonBackSpace imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor clearColor];
    self.mainView.frame = self.bounds;
    self.mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.mainView];
    
    [self setButtonBackground:kPPCColor_dark];
    [self setKeyboardBackground:[UIColor clearColor]];
    
    for (UIButton *button in self.collectionOfButtons) {
        //pressed
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

        
        //finger up
        [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchCancel];
        
        //finger down
        [button addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    }
    
    //and same for backspace
    [self.buttonBackSpace addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBackSpace addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBackSpace addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    [self.buttonBackSpace addTarget:self action:@selector(buttonTouchUp:) forControlEvents:UIControlEventTouchCancel];
    [self.buttonBackSpace addTarget:self action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
    
}

- (void) setButtonBackground:(UIColor *)buttonBackground {
    for (UIButton *btn in self.collectionOfButtons) {
        [btn setBackgroundColor:buttonBackground];
    }
}
- (void) setKeyboardBackground:(UIColor *)keyboardBackground {
    self.backgroundColor = keyboardBackground;
}

- (void) setButtonTint:(UIColor *)buttonTint {
    for (UIButton *btn in self.collectionOfButtons) {
        [btn setTitleColor:buttonTint forState:UIControlStateNormal];
    }
    self.buttonBackSpace.tintColor = buttonTint;
}

- (void)buttonPressed:(UIButton *)sender {
    if (self.delegate == nil)
        return;
    
    NSString *text = [sender titleForState:UIControlStateNormal];
    
    if (text != nil && ![text isEqual:[NSNull null]] && ![text isEqualToString:@""]) {
        NSInteger digit = [text integerValue];
        
        if ([self.delegate canUserPressButtonWithDigit:digit]) {
            [self playClick];
        }
    }
    else {
        if ([self.delegate canUserPressBackspace]) {
            [self playClick];
        }
    }
}
- (void)buttonTouchDown:(UIButton *)sender {
    if (sender.backgroundColor == [UIColor clearColor])
        return;
    sender.backgroundColor = [sender.backgroundColor colorWithAlphaComponent:0.7];
}

- (void)buttonTouchUp:(UIButton *)sender { //and cancel
    if (sender.backgroundColor == [UIColor clearColor])
        return;
    sender.backgroundColor = [sender.backgroundColor colorWithAlphaComponent:1.0];
}


- (void)playClick {
    AudioServicesPlaySystemSound(0x450);
}

@end
