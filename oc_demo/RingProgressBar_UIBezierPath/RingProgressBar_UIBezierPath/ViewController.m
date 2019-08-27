//
//  ViewController.m
//  RingProgressBar_UIBezierPath
//
//  Created by keymon on 2018/7/25.
//  Copyright © 2018 xiaoban. All rights reserved.
//

#import "ViewController.h"

#import "KWRingProgressBar.h"
#import "KWBezierPathView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KWRingProgressBar *bar = [[KWRingProgressBar alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:bar];
    
    [bar setImageURL:@""];
    
    [bar updateProgressWithValue:30.];
    
    KWBezierPathView *pathV = [[KWBezierPathView alloc] initWithFrame:CGRectMake(80, 80, 80, 80)];
    pathV.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.];
    [self.view addSubview:pathV];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
