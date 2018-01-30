//
//  PPCViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCViewController.h"

@interface PPCViewController (){
    BOOL onceWill;
    BOOL onceDid;
}

@end

@implementation PPCViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) initWithXIB {
    self = [super initWithNibName:NSStringFromClass(self.class) bundle:nil];
    if (self) {
        
    }
    return self;
}

+ (id) viewControllerFromStoryboard {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:NSStringFromClass(self.class) bundle:nil];
    PPCViewController *vc = [storyboard instantiateInitialViewController];
    return vc;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - view lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void) showBasicAlertWithTitle: (NSString *) title andMessage: (NSString *) message {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Alert.OK", nil) style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}



@end
