//
//  PPCFirstLaunchViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCFirstLaunchViewController.h"
#import "PPCRoundButton.h"
#import "PPCIntroView.h"
#import "PPCCreateNewWalletViewController.h"

@interface PPCFirstLaunchViewController ()

@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonCreateNewWallet;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonRecoverWallet;
@property (nonatomic, strong) PPCIntroView *introView;

- (IBAction)pressedCreateNewWallet:(id)sender;
- (IBAction)pressedRecoverWallet:(id)sender;

@end

@implementation PPCFirstLaunchViewController


#pragma mark - allocation, memory and deallocation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
}

#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kPPCColor_dark;
    [self.navigationController setNavigationBarHidden:YES];
    
    self.buttonCreateNewWallet.roundButtonType = PPCRoundButtonTypeGreen;
    [self.buttonCreateNewWallet setTitle:NSLocalizedString(@"Button.createWallet", nil) forState:UIControlStateNormal];
    self.buttonCreateNewWallet.alpha = 0;
    
    self.buttonRecoverWallet.roundButtonType = PPCRoundButtonTypeWhite;
    [self.buttonRecoverWallet setTitle:NSLocalizedString(@"Button.recoverWallet", nil) forState:UIControlStateNormal];
    self.buttonRecoverWallet.alpha = 0;
    
    self.introView = [[PPCIntroView alloc] initWithFrame:self.view.bounds];
    self.introView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.introView.translatesAutoresizingMaskIntoConstraints = YES;
    [self.view addSubview:self.introView];
    self.introView.userInteractionEnabled = NO;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void) viewDidAppearOnce:(BOOL)animated {
    [super viewDidAppearOnce:animated];
    
    
    self.introView.baseView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    //intro animation

    [UIView animateWithDuration:0.2 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.introView.imageViewLogo.alpha = 0;
    } completion:^(BOOL finished) {
        CGRect rectB2 = self.buttonRecoverWallet.frame;
        CGRect rectB1 = self.buttonCreateNewWallet.frame;
        
        CGRect rectB1t = rectB1;
        CGRect rectB2t = rectB2;
        
        rectB1t.origin.y += 100;
        rectB2t.origin.y += 150;
        self.buttonCreateNewWallet.frame = rectB1t;
        self.buttonRecoverWallet.frame = rectB2t;


        [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.buttonCreateNewWallet.frame = rectB1;
            self.buttonRecoverWallet.frame = rectB2;

            CGRect rect = self.introView.imageViewLogoText.superview.frame;
            rect.origin.y = self.view.bounds.size.height * 0.0;
            self.introView.imageViewLogoText.superview.frame = rect;
            self.buttonRecoverWallet.alpha = 1;
            self.buttonCreateNewWallet.alpha = 1;
            [self.view setNeedsLayout];
            
        } completion:^(BOOL finished) {
            
        }];
    }];
}


#pragma mark - IBActions

- (IBAction)pressedCreateNewWallet:(id)sender {
    self.canBeRemovedFromNavigationController = YES;
    PPCCreateNewWalletViewController *createVC = [[PPCCreateNewWalletViewController alloc] initWithXIB];
    createVC.delegate = self.delegate;
    [self.navigationController pushViewController:createVC animated:YES];
}

- (IBAction)pressedRecoverWallet:(id)sender {
    self.canBeRemovedFromNavigationController = YES;
    
}


@end



