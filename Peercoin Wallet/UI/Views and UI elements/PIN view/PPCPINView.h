//
//  PPCPINView.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPCPINView : UIView

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *collectionOfPinElements;
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorHighlighted;
@property (nonatomic) NSInteger highlightCount;



@end
