//
//  PPCPaperKeyView.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 30/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPCPaperKeyView : UIView

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *viewCircle;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintCenterVertical;


- (void) showLabelWithAnimation: (BOOL) animation;

@end
