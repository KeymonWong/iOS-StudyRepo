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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKRouteEventCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OKRouteEventCell class]) forIndexPath:indexPath];
    
    if (indexPath.row < self.datas.count) {
        [cell configureCellWithData:self.datas[indexPath.row] indexPath:indexPath];
    }
    
    [cell setRouteBlock:^{
        !self.routerEventBlock ?: self.routerEventBlock();
    }];
    
    return cell;
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OKRouteEventCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OKRouteEventCell class])];
    }
    return _tableView;
}

@end
