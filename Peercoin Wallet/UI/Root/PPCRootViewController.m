//
//  PPCRootViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCRootViewController.h"
#import "PPCIntroView.h"
#import "PPCFirstLaunchViewController.h"


@interface PPCRootViewController ()

@property (weak, nonatomic) IBOutlet ILContainerView *containerView;

@end

@implementation PPCRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //show Peercoin logo and background
    PPCIntroView *introView = [[PPCIntroView alloc] initWithFrame:self.view.bounds];
    introView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view insertSubview:introView atIndex:0];
    self.view.backgroundColor = kPPCColor_dark;
    
    
    
    //configure container view
    self.containerView.currentViewController = self;
}

- (void) viewDidAppearOnce:(BOOL)animated {
    [super viewDidAppearOnce:animated];
    
    //TEST - show creation of new wallet
    [self createOrRecoverWallet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UI next step
- (void) enterTheWallet {
    //called when user successfully create wallet or authentificate into existing one
    
    //this method needs to show tab controller inside container view
    
}
- (void) createOrRecoverWallet {
    // it will show modal view controller for creating new wallet address or recoving old wallet
    
    PPCFirstLaunchViewController *firstVC = [[PPCFirstLaunchViewController alloc] initWithXIB];
    PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:firstVC];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}


- (void) showLogin {
    //if wallet is configured, bust user needs to authentificate
    
}


@end
