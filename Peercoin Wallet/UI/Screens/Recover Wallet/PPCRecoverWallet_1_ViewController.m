//
//  PPCRecoverWallet_1_ViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 02/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCRecoverWallet_1_ViewController.h"
#import "PPCRoundButton.h"
#import "PPCPaperKeyTableViewCell.h"
#import "PPCSetWalletPinViewController.h"

@interface PPCRecoverWallet_1_ViewController () <PPCPaperKeyTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonNext;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonBottom;

@property (nonatomic, strong) NSMutableArray *arrayOfCells;
@property (nonatomic, strong) NSArray *arrayOfAllWords;

@end

@implementation PPCRecoverWallet_1_ViewController


#pragma mark - allocation, memory, decentralization

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfCells = [NSMutableArray array];
    
    //only 12 words for testing purposes
    self.arrayOfAllWords = @[@"acid", @"case", @"enroll", @"fox", @"green", @"junk", @"magnet", @"media", @"price", @"safe", @"unknown", @"water"];
    
    UILabel *labelHeader = [[UILabel alloc] init];
    labelHeader.textColor = kPPCColor_dark;
    labelHeader.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    labelHeader.numberOfLines = 0;
    labelHeader.textAlignment = NSTextAlignmentJustified;
    
    
    self.title = NSLocalizedString(@"Title.recoverWallet", nil);
    labelHeader.text = NSLocalizedString(@"Label.recoverWallet.desc", nil);
    [self.buttonNext setTitle:NSLocalizedString(@"Button.next", nil) forState:UIControlStateNormal];
    self.buttonNext.roundButtonType = PPCRoundButtonTypeGreen;
    self.buttonNext.enabled = NO;

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    
    
    //to avoid separators on empty cells
    UIView *emptyView = [[UIView alloc] init];
    emptyView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:emptyView];
    
    //inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 16, 0);
    
    //header
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    viewHeader.backgroundColor = [UIColor clearColor];
    [viewHeader addSubview:labelHeader];
    [labelHeader autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [labelHeader autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:16];
    [labelHeader autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [labelHeader autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    viewHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView setTableHeaderView:viewHeader];
    [self.tableView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:viewHeader];

}

- (void) viewWillAppearOnce:(BOOL)animated{
    [super viewWillAppearOnce:animated];
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    
    
    if (self.arrayOfCells.count > 0) {
        PPCPaperKeyTableViewCell *cell = self.arrayOfCells[0];
        [cell.textField becomeFirstResponder];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark - keyboard events

- (void) keyboardWillShow: (NSNotification *) notification {
    // get keyboard size and location
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    if (@available(iOS 11.0, *)) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        CGFloat bottomPadding = window.safeAreaInsets.bottom;
        keyboardBounds.size.height -= bottomPadding; //reduce safe area insets
    }
    
    [UIView animateWithDuration:duration.doubleValue delay:0.0 options:curve.integerValue animations:^{
        self.constraintButtonBottom.constant = keyboardBounds.size.height;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void) keyboardWillHide: (NSNotification *) notification {
    // get keyboard size and location
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:duration.doubleValue delay:0.0 options:curve.integerValue animations:^{
        self.constraintButtonBottom.constant = 0.0;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}




#pragma mark - IBActions

- (IBAction)pressedNext:(id)sender {
    
#warning check is paper key valid
    PPCSetWalletPinViewController *vc = [[PPCSetWalletPinViewController alloc] initWithXIB];
    vc.delegate = self.delegate;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private

- (BOOL) isValidWord: (NSString *) word {
    for (NSString *string in self.arrayOfAllWords) {
        if ([string.lowercaseString isEqualToString:word.lowercaseString])
            return YES;
    }
    return NO;
}



#pragma mark - tableView

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kPPCpaperKeyNumberOfWords;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    //we need to store cells in memory all the time (static cells)
    PPCPaperKeyTableViewCell *cell;
    
    for (PPCPaperKeyTableViewCell *cellT in self.arrayOfCells) {
        if ([cellT.customCellIdentifier isEqualToString:cellIdentifier]) {
            cell = cellT;
            break;
        }
    }
    
    if(cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PPCPaperKeyTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.customCellIdentifier = cellIdentifier;
        [self.arrayOfCells addObject:cell];
    }
    
    cell.textField.placeholder = [NSString stringWithFormat:NSLocalizedString(@"Placeholder.word", nil), (indexPath.row + 1)];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // nothing
}

- (BOOL) textField: (UITextField *) textField willReturnFromCell: (PPCPaperKeyTableViewCell *) cell {
    
    //focus next textfield
    NSInteger index = [self.arrayOfCells indexOfObject:cell];
    if (index < kPPCpaperKeyNumberOfWords-1) {
        NSInteger newIndex = index+1;
        PPCPaperKeyTableViewCell *cell = self.arrayOfCells[newIndex];
        [cell.textField becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void) textField: (UITextField *) textField fromCell: (PPCPaperKeyTableViewCell *) cell changedText: (NSString *) text {
    
    //update color
    if (textField.tag == 22) {
        if (![textField.text isEqualToString:@""] && ![self isValidWord:textField.text]) {
            //invalid word
            textField.textColor = kPPCColor_red;
        }
        else {
            textField.textColor = kPPCColor_dark;
        }
    }
    
    //check for submit button
    if ([text isEqualToString:@""]) {
        self.buttonNext.enabled = NO;
    }
    else {
        for (NSInteger i = 0; i < kPPCpaperKeyNumberOfWords; i++) {
            PPCPaperKeyTableViewCell *cell = self.arrayOfCells[i];
            if ([cell.textField.text isEqualToString:@""] || ![self isValidWord:cell.textField.text]) {
                self.buttonNext.enabled = NO;
                return;
            }
        }
        self.buttonNext.enabled = YES;
    }
}

- (void) textField: (UITextField *) textField didBeginEditingFromCell: (PPCPaperKeyTableViewCell *) cell {
    
   

}
- (void) textField: (UITextField *) textField didEndEditingFromCell: (PPCPaperKeyTableViewCell *) cell {
    
    //detect if word is valid
    if (![textField.text isEqualToString:@""] && ![self isValidWord:textField.text]) {
        //invalid word
        textField.textColor = kPPCColor_red;
        textField.tag = 22; // red
    }
    else {
        textField.textColor = kPPCColor_dark;
        textField.tag = 0; // dark
    }
}

@end
