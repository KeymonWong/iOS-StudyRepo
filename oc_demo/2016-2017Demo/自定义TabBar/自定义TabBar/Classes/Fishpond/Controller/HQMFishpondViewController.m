//
//  HQMFishpondViewController.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMFishpondViewController.h"

#import "HQMRegisterViewController.h"

@interface HQMFishpondViewController ()

@end

@implementation HQMFishpondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *bn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [bn setFrame:CGRectMake(50, 100, 20, 20)];
    [bn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push {
    HQMRegisterViewController *regVC = [[HQMRegisterViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
}

@end
