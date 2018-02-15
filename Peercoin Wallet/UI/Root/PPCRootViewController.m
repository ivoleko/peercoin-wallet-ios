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
#import "PPCEnterPinViewController.h"


#import "PPCOverviewViewController.h"
#import "PPCSendViewController.h"
#import "PPCReceiveViewController.h"
#import "PPCSettingsViewController.h"


@interface PPCRootViewController ()

@property (weak, nonatomic) IBOutlet ILContainerView *containerView;
@property (nonatomic, strong) UITabBarController *mainTabBarController;

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
    //[self createOrRecoverWallet];
    [self showLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UI next step
- (void) enterTheWallet {
    //called when user successfully create wallet or authentificate into existing one
    
    self.mainTabBarController = nil;
    self.containerView.childViewController = nil;
    
    
    NSMutableArray *arrayOfViewControllers = [NSMutableArray arrayWithCapacity:4];
    
    {
        PPCOverviewViewController *vc = [[PPCOverviewViewController alloc] initWithXIB];
        vc.title = NSLocalizedString(@"Title.Overview", nil);
        PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = [UIImage imageNamed:@"tabOverview"];
        [arrayOfViewControllers addObject:nav];
    }
    {
        PPCSendViewController *vc = [[PPCSendViewController alloc] initWithXIB];
        vc.title = NSLocalizedString(@"Title.Send", nil);
        PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = [UIImage imageNamed:@"tabSend"];
        [arrayOfViewControllers addObject:nav];
    }
    {
        PPCReceiveViewController *vc = [[PPCReceiveViewController alloc] initWithXIB];
        vc.title = NSLocalizedString(@"Title.Receive", nil);
        PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = [UIImage imageNamed:@"tabReceive"];
        [arrayOfViewControllers addObject:nav];
    }
    {
        PPCSettingsViewController *vc = [[PPCSettingsViewController alloc] initWithXIB];
        vc.title = NSLocalizedString(@"Title.Settings", nil);
        PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem.image = [UIImage imageNamed:@"tabSettings"];
        [arrayOfViewControllers addObject:nav];
    }
    
    
    self.mainTabBarController = [[UITabBarController alloc] init];
    self.mainTabBarController.viewControllers = [NSArray arrayWithArray:arrayOfViewControllers];
    self.containerView.childViewController = self.mainTabBarController;
    self.mainTabBarController.tabBar.barStyle = UIBarStyleBlack;
    self.mainTabBarController.tabBar.translucent = NO;
    self.mainTabBarController.tabBar.barTintColor = kPPCColor_dark;
    self.mainTabBarController.tabBar.tintColor = kPPCColor_green;\
    

    if (@available(iOS 10.0, *)) {
        self.mainTabBarController.tabBar.unselectedItemTintColor = kPPCColor_grayTabBar;
    } else {
        // Fallback on earlier versions
    }
    
}
- (void) createOrRecoverWallet {
    // it will show modal view controller for creating new wallet address or recoving old wallet
    
    PPCFirstLaunchViewController *firstVC = [[PPCFirstLaunchViewController alloc] initWithXIB];
    PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:firstVC];
    [self presentViewController:nav animated:NO completion:^{
        
    }];
}


- (void) showLogin {
    
    //if wallet is configured, but user needs to authentificate
    PPCEnterPinViewController *enterPinVC = [[PPCEnterPinViewController alloc] initWithXIB];
    enterPinVC.showIntro = YES;
    enterPinVC.translucent = NO;
    enterPinVC.allowCancel = NO;
    enterPinVC.allowBiometrics = YES;
    [enterPinVC setCallback:^(NSError *error, BOOL userCanceled) {
        [self enterTheWallet];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    PPCNavigationController *nav = [[PPCNavigationController alloc] initWithRootViewController:enterPinVC];
    [self presentViewController:nav animated:NO completion:nil];
}


@end
