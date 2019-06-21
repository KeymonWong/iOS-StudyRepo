//
//  ViewController.m
//  StarEvaluation
//
//  Created by 小伴 on 2017/2/16.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "ViewController.h"
#import "ExampleView.h"
#import "StarEvaluationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ExampleView *v = [[ExampleView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:v];

//    StarEvaluationView *starView1 = [[StarEvaluationView alloc] initWithFrame:CGRectMake(20, 20+20, 170, 30) normalImageName:nil highlightedImageName:nil];
//    StarEvaluationView *starView2 = [[StarEvaluationView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(starView1.frame)+30+20, 170, 30) normalImageName:nil highlightedImageName:nil];
//    [self.view addSubview:starView1];
//    [self.view addSubview:starView2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
