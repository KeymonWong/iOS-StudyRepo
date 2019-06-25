//
//  HQMHomeViewController.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMHomeViewController.h"

#import "UIView+Overlap.h"


@interface HQMHomeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HQMHomeViewController

- (void)dealloc {
    [NotificationCenter removeObserver:self name:HQMTabBarItemDidClickRepeatNotification
                                object:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //接收通知
    [NotificationCenter addObserver:self selector:@selector(tabbarButtonClick)
                               name:HQMTabBarItemDidClickRepeatNotification
                             object:NULL];


    [self setupSubviews];
}

- (void)tabbarButtonClick {
    //判断window是否在窗口上
    if (self.view.window == nil) return;
    //判断当前的view是否与窗口重合，nil代表屏幕左上角
    if (![self.view is_intersectsWithAnotherView:nil]) return;

    //实现界面的回滚
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)setupSubviews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    self.tableView = tableView;

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"sss";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

    return cell;
}


@end
