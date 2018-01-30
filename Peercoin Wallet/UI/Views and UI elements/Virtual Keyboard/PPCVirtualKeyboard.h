//
//  PPCVirtualKeyboard.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 29/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PPCVirtualKeyboardDelegate

- (BOOL) canUserPressButtonWithDigit: (NSInteger) digit;
- (BOOL) canUserPressBackspace;

@end


@interface PPCVirtualKeyboard : UIView

@property (nonatomic, strong) UIColor *buttonTint;
@property (nonatomic, strong) UIColor *buttonBackground;
@property (nonatomic, strong) UIColor *keyboardBackground;


@property (nonatomic, weak) id <PPCVirtualKeyboardDelegate> delegate;



@end
