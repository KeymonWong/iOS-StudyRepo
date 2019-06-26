//
//  OKRouteEventView.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKRouteEventView.h"
#import "OKRouteEventCell.h"

#import "OKEventName.h"
#import "UIResponder+Router.h"

@interface OKRouteEventView ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy) NSArray *datas;
@end

@implementation OKRouteEventView

#pragma mark - life circle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        
        // 配置数据一般从数据层来，此处只是个demo，写在这里方便
        [self configureData];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)configureData {
    self.datas = @[
                   @{
                       @"title" : @"早餐",
                       @"eventName" : kHaveBreakfastName
                       },
                   @{
                       @"title" : @"写代码",
                       @"eventName" : kCodeName
                       },
                   @{
                       @"title" : @"午饭",
                       @"eventName" : kHaveLunchName
                       }
                   ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKRouteEventCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OKRouteEventCell class]) forIndexPath:indexPath];
    
    // 策略模式场景化到 cell, 点击不同的 cell 处理不同的事件
    if (indexPath.row < self.datas.count) {
        [cell configureCellWithData:self.datas[indexPath.row] indexPath:indexPath];
    }
    
    // 方式1：采用block回调的方式交互
    [cell setRouteBlock:^{
        !self.routerEventBlock ?: self.routerEventBlock();
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self routerEventWithName:self.datas[indexPath.row][@"eventName"] userInfo:@{@"indexPath":indexPath}];
}

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        // 关掉估算行高
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        _tableView.rowHeight = 80;
        
#ifdef __IPHONE_11_0
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
#endif
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OKRouteEventCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OKRouteEventCell class])];
    }
    return _tableView;
}

@end
