//
//  PPCPaperKey_1_ViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 29/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPaperKey_1_ViewController.h"
#import "PPCRoundButton.h"
#import "PPCEnterPinViewController.h"
#import "PPCPaperKey_2_ViewController.h"

@interface PPCPaperKey_1_ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonWriteDown;
@property (weak, nonatomic) IBOutlet UIView *headerBackground;


- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedWriteDown:(id)sender;

@end

@implementation PPCPaperKey_1_ViewController

#pragma mark - allocation, memory and deallocation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kPPCColor_lightGray;
    self.headerBackground.backgroundColor = kPPCColor_dark;
    
    self.labelTitle.text = NSLocalizedString(@"Title.paperKey", nil);
    self.labelDesc.text = NSLocalizedString(@"Label.paperKey.desc", nil);
    [self.buttonWriteDown setTitle:NSLocalizedString(@"Button.writeDownPaperKey", nil) forState:UIControlStateNormal];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - IBActions

- (IBAction)pressedCancel:(id)sender {
    if (self.delegate)
        [self.delegate walletManagementFinished];
}

- (IBAction)pressedWriteDown:(id)sender {
    PPCEnterPinViewController *enterPinVC = [[PPCEnterPinViewController alloc] initWithXIB];
    enterPinVC.showIntro = NO;
    enterPinVC.translucent = YES;
    enterPinVC.allowCancel = YES;
    enterPinVC.allowBiometrics = YES;
  
    [enterPinVC setCallback:^(NSError *error, BOOL userCanceled) {
        
        PPCPaperKey_2_ViewController *vc = [[PPCPaperKey_2_ViewController alloc] initWithXIB];
        vc.delegate = self.delegate;
        [vc setArrayOfWords:@[@"acid", @"case", @"enroll", @"fox", @"green", @"junk", @"magnet", @"media", @"price", @"safe", @"unknown", @"water"]];
        
        [self dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
    
    PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:enterPinVC];
    nav.modalPresentationStyle = UIModalPresentationCustom;
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nav.view.backgroundColor = [UIColor clearColor];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
