//
//  OKViewController.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/5.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKViewController.h"
#import "OKDisplayDifferentImageVC.h"
#import "OKPriceDescViewController.h"

#import "OKValuationView.h"

@interface OKViewController ()
@property (nonatomic, weak) OKValuationView *valuationV;
@end

@implementation OKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UILabel *descL = [[UILabel alloc] init];
        descL.text = @"滴滴出行选择车辆叫车页面";
        descL.textAlignment = NSTextAlignmentCenter;
        descL.textColor = [UIColor orangeColor];
        descL.frame = CGRectMake(20, 100, self.view.bounds.size.width - 20 * 2, 20);
        descL;
    })];
    
    [self.view addSubview:({
        OKValuationView *v = [[OKValuationView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 140)];
        self.valuationV = v;
        v;
    })];
    
    
    [self.valuationV setDidPickCar:^(OKCar * _Nonnull car) {
        OKPriceDescViewController *vc = [[OKPriceDescViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (IBAction)clickRightBarItem:(UIBarButtonItem *)sender {
    OKDisplayDifferentImageVC *vc = [[OKDisplayDifferentImageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
