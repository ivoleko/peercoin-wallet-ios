//
//  Constants.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 26/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

//
// CONDITIONS
//
#define isIphone5                   ([[UIScreen mainScreen] bounds].size.height == 568)
#define isIphone4                   ([[UIScreen mainScreen] bounds].size.height == 480)


//
// COLORS
//
#define kPPCColor_dark              [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]
#define kPPCColor_green             [UIColor colorWithRed:60.0/255.0 green:176.0/255.0 blue:84.0/255.0 alpha:1.0]
#define kPPCColor_white             [UIColor whiteColor]
#define kPPCColor_grayFont          [UIColor colorWithRed:154.0/255.0 green:154.0/255.0 blue:154.0/255.0 alpha:1.0]
#define kPPCColor_lightGrayBG       [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0] // used for background
#define kPPCColor_keyboardButton    [UIColor colorWithRed:114.0/255.0 green:114.0/255.0 blue:114.0/255.0 alpha:1.0]
#define kPPCColor_red               [UIColor colorWithRed:209.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]
#define kPPCColor_grayTabBar        [UIColor colorWithRed:194.0/255.0 green:194.0/255.0 blue:194.0/255.0 alpha:1.0] // used for background



//constants
#define PINlenght                   6
#define PINcheckNumberOfWords       3
#define kPPCpaperKeyNumberOfWords   12



#endif /* Constants_h */
