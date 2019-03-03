//
//  ViewController.m
//  Corner
//
//  Created by keymon on 2018/8/15.
//  Copyright © 2018 KeymonWong. All rights reserved.
//

#import "ViewController.h"

#import "UIView+RoundCorner.h"
#import "PathView.h"
#import "UIImage+RoundCorner.h"
#import "UIImageView+RoundCorner.h"

#import "TestCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGRect frame = CGRectMake(60, 60, self.view.frame.size.width-60*2, 400);
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    [bgView kw_addRoundCornersWithRect:frame backgroundColor:[UIColor whiteColor] borderColor:[UIColor redColor] borderWidth:0 cornerRadius:10 roundCornerTypes:UIRectCornerTopLeft|UIRectCornerTopRight];
    
//    [self.view addSubview:bgView];
    
    ///<jjjj
    //草泥马了爽肤水老骥伏枥
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    l.backgroundColor = [UIColor greenColor];
    l.text = @"我是里面内容";
    l.textColor = [UIColor whiteColor];
    l.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:l];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 80, 80)];
    imgV.contentMode = UIViewContentModeScaleAspectFill;
//    imgV.backgroundColor = [UIColor grayColor];
    imgV.image = [UIImage imageNamed:@"xiaobandriver1024"];
    [imgV kw_addRoundCornerWithRadius:20*0.5];
    [bgView addSubview:imgV];
    
    
    PathView *pV = [[PathView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    pV.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:pV];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TestCell" bundle:nil] forCellReuseIdentifier:@"TestCell"];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70.);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell" forIndexPath:indexPath];
    
    
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = 120.;
        _tableView.backgroundColor = [UIColor colorWithRed:244 green:244 blue:244 alpha:1];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
