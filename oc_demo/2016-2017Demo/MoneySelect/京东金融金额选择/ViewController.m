//
//  ViewController.m
//  京东金融金额选择
//
//  Created by 小伴 on 2017/4/28.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "ViewController.h"

#import "FundSelectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightTextColor];

//    CAShapeLayer *line = [[CAShapeLayer alloc] init];
//    line.frame = CGRectMake(0, 0, 20, 20);
//    line.position = self.view.center;
//    line.lineWidth = 2;
//    line.strokeColor = [UIColor redColor].CGColor;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(30, 50)];
//    [path addLineToPoint:CGPointMake(30, 60)];
//    line.path = path.CGPath;
//    [self.view.layer addSublayer:line];

    FundSelectView *fundView = [[FundSelectView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 105)];
    [fundView setAmount:@""];
    [self.view addSubview:fundView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
