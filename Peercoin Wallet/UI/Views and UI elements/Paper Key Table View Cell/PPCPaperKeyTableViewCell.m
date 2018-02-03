//
//  PPCPaperKeyTableViewCell.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 31/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPaperKeyTableViewCell.h"

@implementation PPCPaperKeyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textField.tintColor = kPPCColor_green;
    self.textField.delegate = self;
    
    self.textField.floatingLabelFont = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.textField.floatingLabelTextColor = kPPCColor_green;
    self.textField.floatingLabelActiveTextColor = kPPCColor_green;
    self.textField.floatingLabelYPadding = 5;
    self.textField.placeholderColor = kPPCColor_grayFont;
    self.textField.textColor = kPPCColor_dark;
    
    [self.textField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

}


- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    return [self.delegate textField:textField willReturnFromCell:self];
}

- (void) textFieldDidChange:(UITextField *) textField {
    [self.delegate textField:textField fromCell:self changedText:textField.text];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textField: didBeginEditingFromCell:)])
        [self.delegate textField:textField didBeginEditingFromCell:self];
}

- (void) textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textField: didEndEditingFromCell:)])
        [self.delegate textField:textField didEndEditingFromCell:self];
}

@end
