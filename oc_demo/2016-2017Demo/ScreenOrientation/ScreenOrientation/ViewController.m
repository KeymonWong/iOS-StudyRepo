//
//  ViewController.m
//  ScreenOrientation
//
//  Created by 小伴 on 2017/2/7.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "ViewController.h"

#import "OrientationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    OrientationView *v = [[OrientationView alloc] init];
    v.frame = CGRectMake(25, self.view.center.y-75, 325, 150);
    [self.view addSubview:v];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
