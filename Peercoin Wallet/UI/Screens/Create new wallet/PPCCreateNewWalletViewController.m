//
//  PPCCreateNewWalletViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCCreateNewWalletViewController.h"
#import "PPCPINView.h"
#import "PPCVirtualKeyboard.h"
#import "PPCPaperKey_1_ViewController.h"

#define PINlenght   6

@interface PPCCreateNewWalletViewController () <PPCVirtualKeyboardDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *animationHolderView;
@property (weak, nonatomic) IBOutlet UIView *viewCheckMarkHolder;

@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription2;
@property (weak, nonatomic) IBOutlet UILabel *labelCheckMark;


@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet PPCPINView *pinView;
@property (weak, nonatomic) IBOutlet UILabel *labelFooterCaution;
@property (weak, nonatomic) IBOutlet UILabel *labelFooterExplanation;
@property (weak, nonatomic) IBOutlet PPCVirtualKeyboard *virtualKeyboard;



@property (nonatomic, strong) NSString *choosenPIN;
@property (nonatomic, strong) NSMutableString *currentEntry;



@end

@implementation PPCCreateNewWalletViewController

#pragma mark - allocation, memory and deallocation

- (void) dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentEntry = [NSMutableString string];
    
    self.virtualKeyboard.delegate = self;
    self.virtualKeyboard.keyboardBackground = kPPCColor_lightGrayBG;
    self.virtualKeyboard.buttonTint = kPPCColor_dark;
    self.virtualKeyboard.buttonBackground = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];

    self.view.backgroundColor = kPPCColor_lightGrayBG;
    
    self.title = NSLocalizedString(@"Title.setPIN", nil);
    self.labelFooterCaution.text = NSLocalizedString(@"Label.caution", nil);
    self.labelFooterExplanation.text = NSLocalizedString(@"Label.rememberPin", nil);
    self.labelDescription.text = NSLocalizedString(@"Label.setPinDesc", nil);
    self.labelDescription2.text = NSLocalizedString(@"Label.setPinDesc2", nil);

    
    
    self.pinView.highlightCount = 0;
    self.pinView.colorNormal = kPPCColor_dark;
    self.pinView.colorHighlighted = kPPCColor_green;
    
    
 }

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [UIView setAnimationsEnabled:NO];
    self.choosenPIN = nil;
    [UIView setAnimationsEnabled:YES];
}


#pragma mark - private methods

- (void) setChoosenPIN:(NSString *)choosenPIN {
    _choosenPIN = choosenPIN;
    if (choosenPIN == nil) {
        //animation
        CGRect rect1 = self.labelDescription.frame;
        rect1.origin.x = - self.view.bounds.size.width;
        self.labelDescription.frame = rect1;
        rect1.origin.x = (self.view.bounds.size.width - rect1.size.width)/2.0;
        
        CGRect rect2 = self.labelDescription2.frame;
        rect2.origin.x =  self.view.bounds.size.width;
        
        [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.labelDescription2.frame = rect2;
            self.labelDescription.frame = rect1;
            self.labelDescription.alpha = 1;
            self.labelDescription2.alpha = 0;
            
        } completion:^(BOOL finished) {
     
        }];
    }
    else {
        //animation
        CGRect rect2 = self.labelDescription2.frame;
        rect2.origin.x = self.view.bounds.size.width;
        self.labelDescription2.frame = rect2;
        rect2.origin.x = (self.view.bounds.size.width - rect2.size.width)/2.0;
        
        CGRect rect1 = self.labelDescription.frame;
        rect1.origin.x = - self.view.bounds.size.width;
        
        [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.labelDescription2.frame = rect2;
            self.labelDescription.frame = rect1;
            self.labelDescription.alpha = 0;
            self.labelDescription2.alpha = 1;
            
        } completion:^(BOOL finished) {
        
        }];
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pinView.highlightCount = 0;
    } completion:^(BOOL finished) {
    }];
}

- (void) pinConfirmed: (NSString *) pin {
    
  #warning need to create a wallet etc.
    
    //hide navigation back button and destroy previous VC
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self cleanNavigationStackOfViewControllers];
    
    
    //animation
    CGRect rectHolder = self.viewCheckMarkHolder.frame;
    rectHolder.origin.y = self.view.bounds.size.height;
    self.viewCheckMarkHolder.frame = rectHolder;
    self.labelCheckMark.text = NSLocalizedString(@"Label.pinSet", nil);
    self.labelCheckMark.textColor = kPPCColor_dark;
    
    self.animationHolderView.alpha = 1.0;
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.alpha = 0.0;
    } completion:^(BOOL finished) {
       
    }];
    
    [UIView animateWithDuration:0.5 delay:0.35 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.animationHolderView setNeedsLayout];
        [self.animationHolderView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 delay:0.35 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.labelCheckMark.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.canBeRemovedFromNavigationController = YES;
        PPCPaperKey_1_ViewController *newVC = [[PPCPaperKey_1_ViewController alloc] initWithXIB];
        newVC.delegate = self.delegate;
        [self.navigationController pushViewController:newVC animated:YES];
    });
}

- (void) wrongPIN {
    [self.pinView shakeIt];
    [self.currentEntry setString:@""];
    self.choosenPIN = nil;
}

- (void) firstPinEntered {
    self.choosenPIN = [NSString stringWithString:self.currentEntry];
    [self.currentEntry setString:@""];
}


#pragma mark - keyboard delegate
- (BOOL) canUserPressButtonWithDigit:(NSInteger)digit {
    if (self.currentEntry.length >= PINlenght) {
        //testing alert
        [self showBasicAlertWithTitle:NSLocalizedString(@"Alert.error", nil) andMessage:NSLocalizedString(@"Alert.PIN.exceedNumberOfDigits", nil)];
        return NO;
    }
    
    [self.currentEntry appendFormat:@"%ld", digit];
    self.pinView.highlightCount = self.currentEntry.length;
    
    if (self.currentEntry.length == PINlenght) {
        if (self.choosenPIN == nil) {
            [self firstPinEntered];
        }
        else {
            if ([self.choosenPIN isEqualToString:self.currentEntry]) {
                [self pinConfirmed:self.choosenPIN];
            }
            else {
                //wrong PIN, repeat
                [self wrongPIN];
            }
        }
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
