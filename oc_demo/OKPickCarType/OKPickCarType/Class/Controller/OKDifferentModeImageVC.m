//
//  OKDifferentModeImageVC.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/15.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKDifferentModeImageVC.h"

#import "OKImageDetailViewController.h"

static NSString * const kCellId = @"UITableViewCell";


@interface OKDifferentModeImageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation OKDifferentModeImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *mode = self.dataArray[indexPath.row];
    OKImageDetailViewController *vc = [[OKImageDetailViewController alloc] init];
    vc.mode = mode;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-90) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        // 0关掉估算行高
        _tableView.rowHeight = 60;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@"UIViewContentModeScaleToFill"];
        [_dataArray addObject:@"UIViewContentModeScaleAspectFit"];
        [_dataArray addObject:@"UIViewContentModeScaleAspectFill"];
        [_dataArray addObject:@"UIViewContentModeCenter"];
        [_dataArray addObject:@"UIViewContentModeTop"];
        [_dataArray addObject:@"UIViewContentModeBottom"];
        [_dataArray addObject:@"UIViewContentModeLeft"];
        [_dataArray addObject:@"UIViewContentModeRight"];
        [_dataArray addObject:@"UIViewContentModeTopLeft"];
        [_dataArray addObject:@"UIViewContentModeTopRight"];
        [_dataArray addObject:@"UIViewContentModeBottomLeft"];
        [_dataArray addObject:@"UIViewContentModeBottomRight"];
    }
    return _dataArray;
}


@end
