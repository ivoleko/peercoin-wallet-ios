//
//  PPCNavigationController.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPCNavigationController : UINavigationController

+ (id) viewControllerFromStoryboard;
- (id) initWithXIB;

- (void) viewWillAppearOnce: (BOOL)animated;
- (void) viewDidAppearOnce: (BOOL) animated;

- (void) cleanNavigationStackOfViewControllers;

@end
