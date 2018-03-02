//
//  PPCSettingsViewController.m
//  Peercoin Wallet
//
//  Created by Ivo Leko on 15/02/2018.
//  Copyright © 2018 Ivo Leko. All rights reserved.
//

#import "PPCSettingsViewController.h"
#import "PPCDateFormatViewController.h"
#import "PPCDisplayCurrencyViewController.h"

#define cellIdentifier  @"SettingsCellIdentifier"
typedef enum {
    SettingsType_SecurityCenter = 0,
    SettingsType_ImportWallet,
    SettingsType_RecoverWallet,
    SettingsType_DisplayCurrency,
    SettingsType_DateFormat,
    SettingsType_About,
    SettingsType_Help,
    SettingsType_RateThisApp
} SettingsType;



@interface PPCSettingsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <NSArray *> *arrayOfCategories;
@property (nonatomic, strong, readonly) NSDictionary *cellData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PPCSettingsViewController

#pragma mark - viewLifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = kPPCColor_lightGrayBG;
    
    //load cell order data
    NSMutableArray *arrayM = [NSMutableArray array];
    [arrayM addObject:@[@(SettingsType_SecurityCenter)]];
    [arrayM addObject:@[@(SettingsType_ImportWallet), @(SettingsType_RecoverWallet)]];
    [arrayM addObject:@[@(SettingsType_DisplayCurrency), @(SettingsType_DateFormat)]];
    [arrayM addObject:@[@(SettingsType_About), @(SettingsType_Help), @(SettingsType_RateThisApp)]];
    self.arrayOfCategories = [NSArray arrayWithArray:arrayM];
    
    [self loadCellData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //update selected cell
    NSIndexPath *indexPathForSelectedRow = self.tableView.indexPathForSelectedRow;
    if (indexPathForSelectedRow) {
        [self updateCell:[self.tableView cellForRowAtIndexPath:indexPathForSelectedRow] forIndexPath:indexPathForSelectedRow];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //deselect animation
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}



#pragma mark - private

- (void) loadCellData {
    _cellData = @{
                  @(SettingsType_SecurityCenter):@{
                          @"title": @"Settings.SecurityCenter",
                          @"imageName": @"settingsSecurityCenter",
                          @"showArrow": @(YES)
                          },
                  @(SettingsType_ImportWallet):@{
                          @"title": @"Settings.ImportWallet",
                          @"imageName": @"settingsImportWallet",
                          @"showArrow": @(YES)
                          },
                  @(SettingsType_RecoverWallet):@{
                          @"title": @"Settings.RecoverWallet",
                          @"imageName": @"settingsRecoverWallet",
                          @"showArrow": @(YES)
                          },
                  @(SettingsType_DisplayCurrency):@{
                          @"title": @"Settings.DisplayCurrency",
                          @"imageName": @"settingsCurrency",
                          @"showArrow": @(NO)
                          },
                  @(SettingsType_DateFormat):@{
                          @"title": @"Settings.DateFormat",
                          @"imageName": @"settingsDateFormat",
                          @"showArrow": @(NO)
                          },
                  @(SettingsType_About):@{
                          @"title": @"Settings.About",
                          @"imageName": @"settingsAbout",
                          @"showArrow": @(YES)
                          },
                  @(SettingsType_Help):@{
                          @"title": @"Settings.Help",
                          @"imageName": @"settingsHelp",
                          @"showArrow": @(YES)
                          },
                  @(SettingsType_RateThisApp):@{
                          @"title": @"Settings.RateThisApp",
                          @"imageName": @"settingsRate",
                          @"showArrow": @(NO)
                          }
                  };
}



#pragma mark - tableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayOfCategories.count;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.tableView.rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrayOfCells = self.arrayOfCategories[section];
    return arrayOfCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:16];
    }
    [self updateCell:cell forIndexPath:indexPath];
    
    return cell;
}


- (void) updateCell: (UITableViewCell *)cell forIndexPath: (NSIndexPath *) indexPath {
    SettingsType type = (SettingsType)[self.arrayOfCategories[indexPath.section][indexPath.row] integerValue];
    cell.imageView.image = [UIImage imageNamed: [self.cellData[@(type)] objectForKey:@"imageName"]];
    cell.textLabel.text = NSLocalizedString([self.cellData[@(type)] objectForKey:@"title"], nil);
    
    
    if ([[self.cellData[@(type)] objectForKey:@"showArrow"] boolValue])
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    if (type == SettingsType_DisplayCurrency) {
        cell.detailTextLabel.text = [[[PPCUserSettings shared] currency] code];
    }
    
    if (type == SettingsType_DateFormat) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = [[PPCUserSettings shared] dateFormatterStyle];
        cell.detailTextLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    }
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingsType type = (SettingsType)[self.arrayOfCategories[indexPath.section][indexPath.row] integerValue];
    
    switch (type) {
        case SettingsType_DateFormat: {
            PPCDateFormatViewController *vc = [[PPCDateFormatViewController alloc] initWithXIB];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case SettingsType_DisplayCurrency: {
            PPCDisplayCurrencyViewController *vc = [[PPCDisplayCurrencyViewController alloc] initWithXIB];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}





@end
