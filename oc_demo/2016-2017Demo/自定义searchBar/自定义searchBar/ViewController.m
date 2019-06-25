//
//  ViewController.m
//  自定义searchBar
//
//  Created by 小伴 on 16/10/20.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "ViewController.h"

#import "HQMSearchBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor orangeColor];

    HQMSearchBar *searchBar = [[HQMSearchBar alloc] initWithFrame:CGRectMake(50, 60, 300, 50)];
    [self.view addSubview:searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
