//
//  PPCDateFormatViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 23/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCDateFormatViewController.h"
#define cellIdentifier  @"DateCellIdentifier"


@interface PPCDateFormatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayOfDateFormats;
@property (nonatomic, strong) NSDate *now;
@property (nonatomic) NSIndexPath *selectedRowIndex;


@end

@implementation PPCDateFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.now = [NSDate date];
    self.title = NSLocalizedString(@"Title.DateFormat", nil);
    self.tableView.backgroundColor = kPPCColor_lightGrayBG;
    self.arrayOfDateFormats = @[
                                @(NSDateFormatterShortStyle),
                                @(NSDateFormatterMediumStyle),
                                @(NSDateFormatterLongStyle),
                                @(NSDateFormatterFullStyle)
                                ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfDateFormats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:16];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = [self.arrayOfDateFormats[indexPath.row] integerValue];
    cell.textLabel.text = [dateFormatter stringFromDate:self.now];
    
    if ([self.arrayOfDateFormats[indexPath.row] integerValue] == (NSInteger)[[PPCUserSettings shared] dateFormatterStyle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedRowIndex = indexPath;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedRowIndex];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    [[PPCUserSettings shared] setDateFormatterStyle:[self.arrayOfDateFormats[indexPath.row] integerValue]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedRowIndex = indexPath;
}


@end
