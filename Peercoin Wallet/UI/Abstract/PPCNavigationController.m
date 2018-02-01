//
//  PPCNavigationController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCNavigationController.h"

@interface PPCNavigationController () {
    BOOL onceWill;
    BOOL onceDid;
}

@end

@implementation PPCNavigationController

- (id) initWithXIB {
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
    if (self) {
        
    }
    return self;
}
+ (id) viewControllerFromStoryboard {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self.class) bundle:nil];
    PPCNavigationController *vc = [storyboard instantiateInitialViewController];
    return vc;
}

#pragma mark - override

- (BOOL) shouldAutorotate {
    return [(UIViewController *)self.navigationController.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [(UIViewController *)self.navigationController.viewControllers.lastObject supportedInterfaceOrientations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!onceWill) {
        [self viewWillAppearOnce:animated];
    }
    onceWill = YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!onceDid) {
        [self viewDidAppearOnce:animated];
    }
    onceDid = YES;
}


- (void) viewWillAppearOnce: (BOOL)animated {
    
}
- (void) viewDidAppearOnce: (BOOL) animated {
    
}

#pragma mark - public methods
- (void) cleanNavigationStackOfViewControllers {
    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.viewControllers];
    for (PPCViewController *viewController in self.viewControllers) {
        if (self.viewControllers.lastObject == viewController)
            continue;
        
        if (viewController.canBeRemovedFromNavigationController)
            [arrayM removeObject:viewController];
    }
    
    self.viewControllers = [NSArray arrayWithArray:arrayM];
}




@end
