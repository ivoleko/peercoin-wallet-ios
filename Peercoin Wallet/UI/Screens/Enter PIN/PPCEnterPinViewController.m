//
//  PPCEnterPinViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 29/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCEnterPinViewController.h"
#import "PPCIntroView.h"
#import "PPCVirtualKeyboard.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "PPCPINView.h"

@interface PPCEnterPinViewController () <PPCVirtualKeyboardDelegate>

@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurView;
@property (weak, nonatomic) IBOutlet PPCIntroView *introView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet PPCVirtualKeyboard *virtualKeyboard;
@property (weak, nonatomic) IBOutlet PPCPINView *pinView;
@property (weak, nonatomic) IBOutlet UIButton *buttonTouchID;
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UILabel *labelEnterPin;
@property (nonatomic, strong) NSMutableString *currentEntry;

//callback
@property (nonatomic, copy) PPCPinAuthResponse authResponseBlock;

@property (nonatomic, strong) LAContext *context;

- (IBAction)pressedTouchID:(id)sender;

@end

@implementation PPCEnterPinViewController


#pragma mark - allocation, memory and deallocation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) dealloc {
    
}


#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.currentEntry = [NSMutableString string];
    
    self.virtualKeyboard.delegate = self;
    self.mainView.alpha = 0;
    
    //touch id (for testing)
    self.context = [[LAContext alloc] init];


    if (!_translucent) {
        [self.buttonTouchID setTitleColor:kPPCColor_white forState:UIControlStateNormal];
        [self.blurView removeFromSuperview];
        self.virtualKeyboard.keyboardBackground = kPPCColor_dark;
        self.virtualKeyboard.buttonBackground = kPPCColor_keyboardButton;
        self.virtualKeyboard.buttonTint = kPPCColor_white;
        self.view.backgroundColor = kPPCColor_dark;
        self.labelEnterPin.textColor = kPPCColor_white;
        self.pinView.colorNormal = kPPCColor_white;
        self.pinView.colorHighlighted = kPPCColor_green;
    }
    else {
        //blur
        [self.buttonTouchID setTitleColor:kPPCColor_white forState:UIControlStateNormal];
        self.virtualKeyboard.keyboardBackground = kPPCColor_dark;
        self.virtualKeyboard.buttonBackground = kPPCColor_keyboardButton;
        self.virtualKeyboard.buttonTint = kPPCColor_white;
        self.view.backgroundColor = [UIColor clearColor];
        self.labelEnterPin.textColor = kPPCColor_white;
        self.pinView.colorNormal = kPPCColor_white;
        self.pinView.colorHighlighted = kPPCColor_green;
    }
    
    if (!self.showIntro) {
        [self.introView removeFromSuperview];
    }

    
    if (!_allowCancel) {
        [self.buttonCancel removeFromSuperview];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void) viewDidAppearOnce:(BOOL)animated {
    [super viewDidAppearOnce:animated];
    
    if (_showIntro) {
        self.introView.baseView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.introView.imageViewLogo.alpha = 0;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                CGRect rect = self.introView.imageViewLogoText.superview.frame;
                rect.origin.y = self.view.bounds.size.height * 0.0;
                rect.size.width = 234.0;
                rect.origin.x = self.view.bounds.size.width/2.0 - rect.size.width/2.0;
                self.introView.imageViewLogoText.superview.frame = rect;
                [self.view setNeedsLayout];
                
            } completion:^(BOOL finished) {
                [self proceedWithBiometricsAuth];
            }];
        }];
    }
    else {
        [self proceedWithBiometricsAuth];
    }
}

#pragma mark - private methods

- (void) proceedWithBiometricsAuth {
    if (_allowBiometrics && [self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        self.buttonTouchID.alpha = 1;
        [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Unlock wallet with your finger." reply:^(BOOL success, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self callResponseBlockWithError:nil andUserCanceled:NO];
                }
                else {
                    [self proceedWithPinAuth];
                }
            });
        }];
    }
    else {
        [self proceedWithPinAuth];
    }
}

- (void) proceedWithPinAuth {
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void) callResponseBlockWithError: (NSError *)error andUserCanceled: (BOOL) userCanceled {
    if (self.authResponseBlock)
        self.authResponseBlock(error, userCanceled);
    
    self.authResponseBlock = nil;
}

#pragma mark - public methods
- (void) setCallback: (PPCPinAuthResponse) block {
    self.authResponseBlock = block;
}


#pragma mark - IBactions

- (IBAction)pressedTouchID:(id)sender {
    [self proceedWithBiometricsAuth];
}

- (IBAction)pressedCancel:(id)sender {
     [self callResponseBlockWithError:nil andUserCanceled:YES];
}



#pragma mark - keyboard delegate
- (BOOL) canUserPressButtonWithDigit:(NSInteger)digit {
    if (self.currentEntry.length >= PINlenght) {
        return NO;
    }
    
    [self.currentEntry appendFormat:@"%ld", (long)digit];
    self.pinView.highlightCount = self.currentEntry.length;
    
    if (self.currentEntry.length == PINlenght) {
        //for testing, it is success
        self.authResponseBlock(nil, NO);
    }
    return YES;
}

- (BOOL) canUserPressBackspace {
    if (self.currentEntry.length == 0) {
        return NO;
    }
    
    [self.currentEntry deleteCharactersInRange:NSMakeRange(self.currentEntry.length-1, 1)];
    self.pinView.highlightCount = self.currentEntry.length;
    return YES;
}



@end
