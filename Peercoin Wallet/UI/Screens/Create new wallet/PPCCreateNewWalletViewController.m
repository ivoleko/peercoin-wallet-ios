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

@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet PPCPINView *pinView;
@property (weak, nonatomic) IBOutlet UILabel *labelFooterCaution;
@property (weak, nonatomic) IBOutlet UILabel *labelFooterExplanation;
@property (weak, nonatomic) IBOutlet PPCVirtualKeyboard *virtualKeyboard;
@property (weak, nonatomic) IBOutlet UIView *backgroundViewForIPhoneX;


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
    self.virtualKeyboard.keyboardBackground = kPPCColor_lightGrey;
    self.virtualKeyboard.buttonTint = kPPCColor_dark;
    self.virtualKeyboard.buttonBackground = [UIColor colorWithRed:221.0/255.0 green:221.0/255.0 blue:221.0/255.0 alpha:1.0];

    self.view.backgroundColor = kPPCColor_lightGrey;
    
    self.title = NSLocalizedString(@"Title.setPIN", nil);
    self.labelFooterCaution.text = NSLocalizedString(@"Label.caution", nil);
    self.labelFooterExplanation.text = NSLocalizedString(@"Label.rememberPin", nil);
    
    self.pinView.highlightCount = 0;
    self.pinView.colorNormal = kPPCColor_dark;
    self.pinView.colorHighlighted = kPPCColor_green;
    
    self.backgroundViewForIPhoneX.backgroundColor = kPPCColor_dark;
    
 }

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.choosenPIN = nil;
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


#pragma mark - private methods

- (void) setChoosenPIN:(NSString *)choosenPIN {
    _choosenPIN = choosenPIN;
    if (choosenPIN == nil) {
        self.labelDescription.text = NSLocalizedString(@"Label.setPinDesc", nil);
    }
    else {
        self.labelDescription.text = NSLocalizedString(@"Label.setPinDesc2", nil);
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.pinView.highlightCount = 0;
    } completion:^(BOOL finished) {
    }];
}

- (void) pinConfirmed: (NSString *) pin {
    
  #warning need to create a wallet etc.
    
    
    PPCPaperKey_1_ViewController *newVC = [[PPCPaperKey_1_ViewController alloc] initWithXIB];
    newVC.delegate = self.delegate;
    [self.navigationController pushViewController:newVC animated:YES];
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
            self.choosenPIN = [NSString stringWithString:self.currentEntry];
            [self.currentEntry setString:@""];
        }
        else {
            if ([self.choosenPIN isEqualToString:self.currentEntry]) {
                [self pinConfirmed:self.choosenPIN];
            }
            else {
                //wrong PIN, repeat
                [self.pinView shakeIt];
                [self.currentEntry setString:@""];
                self.choosenPIN = nil;
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
