//
//  PPCNavigationController.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPCNavigationController : UINavigationController

- (void) viewWillAppearOnce: (BOOL)animated;
- (void) viewDidAppearOnce: (BOOL) animated;

- (id) initWithXIB;
+ (id) viewControllerFromStoryboard;

@end
