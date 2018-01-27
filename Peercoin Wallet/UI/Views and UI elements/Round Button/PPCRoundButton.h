//
//  PPCRoundButton.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 27/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PPCRoundButtonTypeGreen = 0,
    PPCRoundButtonTypeDark,
    PPCRoundButtonTypeWhite
} PPCRoundButtonType;


@interface PPCRoundButton : UIButton

@property (nonatomic) PPCRoundButtonType roundButtonType;

@end
