//
//  PPCPaperKeyTableViewCell.h
//  Peercoin Wallet
//
//  Created by Ivo Leko on 31/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVFloatLabeledText/JVFloatLabeledText.h>

@class PPCPaperKeyTableViewCell;

@protocol PPCPaperKeyTableViewCellDelegate

- (BOOL) textField: (UITextField *) textField willReturnFromCell: (PPCPaperKeyTableViewCell *) cell;
- (void) textField: (UITextField *) textField fromCell: (PPCPaperKeyTableViewCell *) cell changedText: (NSString *) text;

@end


@interface PPCPaperKeyTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *textField;
@property (nonatomic, weak) id <PPCPaperKeyTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *customCellIdentifier;

@end
