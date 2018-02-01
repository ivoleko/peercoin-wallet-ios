//
//  PPCPaperKey_3_ViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 31/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPaperKey_3_ViewController.h"
#import "PPCRoundButton.h"
#import "PPCPaperKeyTableViewCell.h"

@interface PPCPaperKey_3_ViewController () <PPCPaperKeyTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerBackground;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelStep2;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonSubmit;



@property (nonatomic, strong) NSMutableArray *arrayOfCells;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottomFooter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintButtonTopMargin;

- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedSubmit:(id)sender;

@end

@implementation PPCPaperKey_3_ViewController

#pragma mark - alloation, memmory and deallocation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayOfCells = [NSMutableArray array];
    
    self.headerBackground.backgroundColor = kPPCColor_dark;
    self.labelTitle.text = NSLocalizedString(@"Title.paperKey", nil);
    self.labelStep2.text = NSLocalizedString(@"Label.paperKey.step2", nil);
    self.labelDesc.text = NSLocalizedString(@"Label.paperKey.step2.desc", nil);
    [self.buttonSubmit setTitle:NSLocalizedString(@"Button.submit", nil) forState:UIControlStateNormal];
    self.buttonSubmit.roundButtonType = PPCRoundButtonTypeGreen;
    
    
    if (!isIphone4) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    
    
    //to avoid separators on empty cells
    UIView *emptyView = [[UIView alloc] init];
    emptyView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:emptyView];
    
    self.buttonSubmit.enabled = NO;
    
    
    //support for smaller devices
    if (isIphone5 || isIphone4) {//iPhone 5, 5s, SE and 4s
        self.constraintHeight.constant = 100;
        self.constraintButtonHeight.constant = 44;
        self.constraintButtonTopMargin.constant = 0;
    }
    
    
    
    [self.tableView reloadData];

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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self cleanNavigationStackOfViewControllers];
}

#pragma mark - IBActions

- (IBAction)pressedCancel:(id)sender {
    [self.delegate walletManagementFinished];
}

- (IBAction)pressedSubmit:(id)sender {
    //check words
    for (NSInteger i=0; i<PINcheckNumberOfWords; i++) {
        NSString *word = self.arrayOfWords[i];
        PPCPaperKeyTableViewCell *cell = self.arrayOfCells[i];
        if (![word.lowercaseString isEqualToString:cell.textField.text.lowercaseString]) {
            //wrong word!
            [self showBasicAlertWithTitle:NSLocalizedString(@"Alert.paperKey.wrongWords.title", nil) andMessage:NSLocalizedString(@"Alert.paperKey.wrongWords.message", nil)];
            return;
        }
    }
    
    //success
    [self showBasicAlertWithTitle:@"Success" andMessage:@"Success"];
    [self.delegate walletManagementFinished];
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
    
    [UIView animateWithDuration:duration.doubleValue delay:0.0 options:curve.integerValue animations:^{
        self.constraintBottomFooter.constant = keyboardBounds.size.height;
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
        self.constraintBottomFooter.constant = 0.0;
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - tableView

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfWords.count;
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
    
    cell.textField.placeholder = [NSString stringWithFormat:NSLocalizedString(@"Placeholder.word", nil), ([self.arrayOfPositions[indexPath.row] integerValue] + 1)];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // nothing
}

- (BOOL) textField: (UITextField *) textField willReturnFromCell: (PPCPaperKeyTableViewCell *) cell {
 
    NSInteger index = [self.arrayOfCells indexOfObject:cell];
    if (index < self.arrayOfWords.count-1) {
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
    if ([text isEqualToString:@""]) {
        self.buttonSubmit.enabled = NO;
    }
    else {
        for (NSInteger i = 0; i < self.arrayOfWords.count; i++) {
            PPCPaperKeyTableViewCell *cell = self.arrayOfCells[i];
            if ([cell.textField.text isEqualToString:@""]) {
                self.buttonSubmit.enabled = NO;
                return;
            }
        }
        self.buttonSubmit.enabled = YES;
    }
}





@end
