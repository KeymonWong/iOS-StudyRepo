//
//  RootViewController.m
//  OKiOSGodStudio
//
//  Created by keymon on 2019/11/18.
//  Copyright © 2019 okay. All rights reserved.
//

#import "RootViewController.h"

static NSString * const kCellId = @"UITableViewCell";

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *datas;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"list" ofType:@"json"];
    __autoreleasing NSError *err;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                         options:NSJSONReadingMutableLeaves
                                                           error:&err];
    if (err) {
        return;
    }
    NSLog(@"%@", json);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    cell.textLabel.text = @"";
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 40;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellId];
    }
    return _tableView;
}

@end
