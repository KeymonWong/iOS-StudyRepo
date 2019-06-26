//
//  HKViewController.m
//  DifferentCellDisplay
//
//  Created by 小伴 on 16/3/30.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HKViewController.h"

#import "HKSettingCell.h"

#import "HKSettingItem.h"

@interface HKViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView      *settingTableView;
@property (nonatomic, strong)        NSMutableArray   *cellArray;

@end

@implementation HKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    HKSettingItem *item1 = [HKSettingArrowItem itemWithIcon:@"icon-list01" title:@"朋友圈"];
    HKSettingItem *item2 = [HKSettingSwitchItem itemWithIcon:@"3Normal" title:@"推送和提醒"];
    NSArray *group1 = @[item1, item2];

    HKSettingItem *item3 = [HKSettingArrowItem itemWithIcon:@"icon-list01" title:@"清理缓存"];
    HKSettingItem *item4 = [HKSettingArrowItem itemWithIcon:@"icon-list01" title:@"新的消息"];
    HKSettingItem *item5 = [HKSettingArrowItem itemWithIcon:@"icon-list01" title:@"设置"];
    NSArray *group2 = @[item3, item4, item5];

    self.cellArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self.cellArray addObjectsFromArray:@[group1, group2]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 57.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HKSettingCell *cell = [HKSettingCell cellWithTableView:tableView];
    HKSettingItem *item = self.cellArray[indexPath.section][indexPath.row];
    cell.item = item;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
