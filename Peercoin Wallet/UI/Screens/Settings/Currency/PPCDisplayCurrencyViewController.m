//
//  PPCDisplayCurrencyViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 24/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCDisplayCurrencyViewController.h"
#import "PPCCurrency.h"
#define cellIdentifier  @"CurrencyCellIdentifier"


@interface PPCDisplayCurrencyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *arrayOfCurrencies;
@property (nonatomic) NSIndexPath *selectedRowIndex;

@end

@implementation PPCDisplayCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Title.DisplayCurrency", nil);
    self.tableView.backgroundColor = kPPCColor_lightGrayBG;
    self.arrayOfCurrencies = [PPCCurrency arrayOfCurrencies];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSInteger index = 0;
    for (PPCCurrency *currency in self.arrayOfCurrencies) {
        if ([currency isEqual:[PPCUserSettings.shared currency]]) {
            index = [self.arrayOfCurrencies indexOfObject:currency];
            break;
        }
    }
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
}



#pragma mark - tableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfCurrencies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.tintColor = kPPCColor_green;
    }
    
    PPCCurrency *currency = self.arrayOfCurrencies[indexPath.row];
    
    cell.detailTextLabel.text = currency.name;
    cell.textLabel.text = currency.code;
    
    if ([self.arrayOfCurrencies[indexPath.row] isEqual:[[PPCUserSettings shared] currency]]) {
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
    
    [[PPCUserSettings shared] setCurrency:self.arrayOfCurrencies[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedRowIndex = indexPath;
}


@end
