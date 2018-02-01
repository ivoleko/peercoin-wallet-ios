//
//  PPCPaperKey_2_ViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 30/01/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCPaperKey_2_ViewController.h"
#import "PPCRoundButton.h"
#import "PPCPaperKeyView.h"
#import "PPCPaperKey_3_ViewController.h"

@interface PPCPaperKey_2_ViewController () < UIScrollViewDelegate> {
    NSInteger currentPage;
    
}

//UI
@property (weak, nonatomic) IBOutlet UILabel *labelStep;
@property (weak, nonatomic) IBOutlet UILabel *labelDesc;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelPosition;

@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonPrevious;
@property (weak, nonatomic) IBOutlet PPCRoundButton *buttonNext;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *headerBackground;

@property (nonatomic, strong) NSArray *arrayOfPaperKeyViews;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintVerticalCenter;



//data
@property (nonatomic, strong, readonly) NSArray *arrayOfWords;


- (IBAction)pressedCancel:(id)sender;
- (IBAction)pressedNext:(id)sender;
- (IBAction)pressedPrevious:(id)sender;

@end

@implementation PPCPaperKey_2_ViewController

#pragma mark - allocation, memory and deallocation

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kPPCColor_white;
    self.headerBackground.backgroundColor = kPPCColor_dark;
    self.labelTitle.text = NSLocalizedString(@"Title.paperKey", nil);
    self.labelStep.text = NSLocalizedString(@"Label.paperKey.step1", nil);
    self.labelDesc.text = NSLocalizedString(@"Label.paperKey.step1.desc", nil);
    
    self.buttonNext.roundButtonType = PPCRoundButtonTypeDark;
    [self.buttonNext setTitle:NSLocalizedString(@"Button.next", nil) forState:UIControlStateNormal];
    self.buttonPrevious.enabled = NO;
    self.buttonPrevious.roundButtonType = PPCRoundButtonTypeDark;
    [self.buttonPrevious setTitle:NSLocalizedString(@"Button.previous", nil) forState:UIControlStateNormal];
    
    [self setUpScrollView];
}

- (void) viewWillAppearOnce:(BOOL)animated {
    [super viewWillAppearOnce:animated];
    [self calculateAndUpdateIndex:self.scrollView];
    [(PPCPaperKeyView *)self.arrayOfPaperKeyViews[0] showLabelWithAnimation:YES];
}

#pragma mark - public
- (void) setArrayOfWords: (NSArray *) arrayOfWords {
    NSAssert(!self.arrayOfWords, @"Array if already set!");
    NSAssert(self.arrayOfWords.count != kPPCpaperKeyNumberOfWords, @"Array needs to have 12 words");

    _arrayOfWords = [NSArray arrayWithArray:arrayOfWords];
}

#pragma mark - private

- (void) proceedToStep2 {
    //find random words
    NSMutableArray *mutableArrayOfWords = [NSMutableArray array];
    NSMutableArray *mutableArrayOfPositions = [NSMutableArray array];
    NSMutableArray *mutableArrayOfAllPositions = [NSMutableArray arrayWithArray: @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10, @11]];
    
    for (NSInteger i = 0; i < PINcheckNumberOfWords; i++) {
        NSInteger randomIndex = arc4random() % mutableArrayOfAllPositions.count;
        NSInteger position = [[mutableArrayOfAllPositions objectAtIndex:randomIndex] integerValue];
        [mutableArrayOfWords addObject:self.arrayOfWords[position]];
        [mutableArrayOfPositions addObject:@(position)];
        [mutableArrayOfAllPositions removeObjectAtIndex:randomIndex];
    }
    
    
    //bubble sorting
    BOOL swapped;
    do {
        swapped = NO;
        for (int i=0; i < PINcheckNumberOfWords-1; i++) {
            if ([mutableArrayOfPositions[i] integerValue] > [mutableArrayOfPositions[i+1] integerValue]) {
                NSNumber *temp = mutableArrayOfPositions[i];
                mutableArrayOfPositions[i] = mutableArrayOfPositions[i+1];
                mutableArrayOfPositions[i+1] = temp;
                
                NSString *tempS = mutableArrayOfWords[i];
                mutableArrayOfWords[i] = mutableArrayOfWords[i+1];
                mutableArrayOfWords[i+1] = tempS;
                swapped = YES;
            }
        }
    } while (swapped);
    
    
    PPCPaperKey_3_ViewController *vc = [[PPCPaperKey_3_ViewController alloc] initWithXIB];
    vc.delegate = self.delegate;
    vc.arrayOfWords = [NSArray arrayWithArray:mutableArrayOfWords];
    vc.arrayOfPositions = [NSArray arrayWithArray:mutableArrayOfPositions];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void) setUpScrollView {

    CGFloat deltaCircleCenter = -30;
    CGFloat circleLabelDistance = 25;
    
    
    CGFloat scrollWidth = self.scrollView.bounds.size.width * self.arrayOfWords.count;
    CGRect rect = CGRectMake(0, 0, scrollWidth, self.scrollView.bounds.size.height);
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor clearColor];
   
    [self.scrollView addSubview:view];
    [view autoPinEdgesToSuperviewEdges];

    //create and set childrens
    NSMutableArray *arrayOfPaperKeyViews = [NSMutableArray arrayWithCapacity:self.arrayOfWords.count];
    for (NSInteger i = 0; i < self.arrayOfWords.count; i++) {
        CGRect paperRect = self.scrollView.bounds;
        paperRect.origin.x = i*paperRect.size.width;
        
        PPCPaperKeyView *paperKeyView = [[PPCPaperKeyView alloc] initWithFrame:paperRect];
        [view addSubview:paperKeyView];
        paperKeyView.constraintCenterVertical.constant = deltaCircleCenter;
        [paperKeyView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [paperKeyView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [paperKeyView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.scrollView];
        [paperKeyView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.scrollView];
        paperKeyView.label.text = self.arrayOfWords[i];
        
        if (i == 0) //first view
            [paperKeyView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        else
            [paperKeyView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:arrayOfPaperKeyViews.lastObject withOffset:0.0];
        
        if (i == self.arrayOfWords.count-1) //last view
            [paperKeyView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [arrayOfPaperKeyViews addObject:paperKeyView];
    }
    
  
    [self.scrollView setContentSize:rect.size];
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.arrayOfPaperKeyViews = [NSArray arrayWithArray:arrayOfPaperKeyViews];
    
    
    CGFloat heightOfCircle = [[self.arrayOfPaperKeyViews objectAtIndex:0] viewCircle].frame.size.height;
    self.constraintVerticalCenter.constant = heightOfCircle/2.0 + deltaCircleCenter + circleLabelDistance;
}


#pragma mark - scrollView delegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self calculateAndUpdateIndex:scrollView];
    [(PPCPaperKeyView *)self.arrayOfPaperKeyViews[currentPage] showLabelWithAnimation:YES];
}



- (void) calculateAndUpdateIndex: (UIScrollView *) scrollView {
    //find page
    CGFloat offset = scrollView.contentOffset.x;
    CGFloat scrollWidth = scrollView.contentSize.width;
    CGFloat singlePageWidth = scrollWidth / (CGFloat) self.arrayOfWords.count;
    NSInteger index = (offset / singlePageWidth) + 0.5;
    
    //update label
    self.labelPosition.text = [NSString stringWithFormat:NSLocalizedString(@"Label.paperKey.position", nil), index+1, self.arrayOfWords.count];
    
    //update button
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.buttonPrevious.enabled = (index < 1) ? NO : YES;
    } completion:^(BOOL finished) {
        
    }];
    
    if (index<0)
        currentPage = 0;
    else if (index > self.arrayOfWords.count-1)
        currentPage = self.arrayOfWords.count-1;
    else
        currentPage = index;
    
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (currentPage == self.arrayOfWords.count-1) {
            [self.buttonNext setRoundButtonType:PPCRoundButtonTypeGreen];
            [self.buttonNext setTitle:NSLocalizedString(@"Button.finish", nil) forState:UIControlStateNormal];
        }
        else {
            [self.buttonNext setRoundButtonType:PPCRoundButtonTypeDark];
            [self.buttonNext setTitle:NSLocalizedString(@"Button.next", nil) forState:UIControlStateNormal];
        }
    } completion:^(BOOL finished) {
        
    }];
}



#pragma mark - IBActions

- (IBAction)pressedCancel:(id)sender {
    if (self.delegate)
        [self.delegate walletManagementFinished];
}

- (IBAction)pressedNext:(id)sender {
    NSInteger newPage = currentPage+1;
    
    if (newPage > self.arrayOfWords.count-1) {
        [self proceedToStep2];
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(newPage*self.scrollView.frame.size.width, 0) animated:YES];
    [(PPCPaperKeyView *)self.arrayOfPaperKeyViews[newPage] showLabelWithAnimation:YES];

}

- (IBAction)pressedPrevious:(id)sender {
    NSInteger newPage = currentPage-1;
    if (newPage < 0) {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(newPage*self.scrollView.frame.size.width, 0) animated:YES];
}


@end


