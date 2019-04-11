//
//  OKRouteEventView.m
//  OKSnippet
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKRouteEventView.h"
#import "OKRouteEventCell.h"

@interface OKRouteEventView ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation OKRouteEventView

#pragma mark - life circle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.tableView];
    self.tableView.frame = self.bounds;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKRouteEventCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OKRouteEventCell class]) forIndexPath:indexPath];
    
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
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OKRouteEventCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OKRouteEventCell class])];
    }
    return _tableView;
}

@end
