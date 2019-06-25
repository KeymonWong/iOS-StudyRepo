//
//  ViewController.m
//  RefreshControl
//
//  Created by 小伴 on 2017/2/21.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "ViewController.h"

#import "RefreshView.h"

#import "UITableView+Associated.h"

#define kReuseID @"refreshTestCell"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;

    [self setupRefreshHeader];

    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[self getImageFromColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)setupRefreshHeader {
    __weak typeof(self) weakSelf = self;
    void (^handler)() = ^() {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.refreshView stopRefresh];
        });
    };
    self.tableView.refreshView = [[RefreshView alloc] initWithHandler:handler];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseID forIndexPath:indexPath];

    cell.textLabel.text = @"拖我...😯😯";

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];

        CGFloat alpha = (scrollView.contentOffset.y) / 90. > 1. ? 1. : scrollView.contentOffset.y / 90.;
        [self.navigationController.navigationBar setBackgroundImage:[self getImageFromColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:alpha]] forBarMetrics:UIBarMetricsDefault];
    }
}

- (UIImage *)getImageFromColor:(UIColor *)color {
    CGSize colorSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(colorSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, CGRectMake(0, 0, 1, 1));

    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
