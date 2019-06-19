//
//  OKViewController.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/5.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKViewController.h"
#import "OKDisplayDifferentImageVC.h"
#import "OKDifferentModeImageVC.h"
#import "OKPriceDescViewController.h"

#import "OKValuationView.h"
#import "OKPickCarTypeCardView.h"
#import "OKValuationCardView.h"

#import "OKCar.h"

@interface OKViewController ()<OKPickCarTypeCardViewDelegate>
@property (nonatomic, weak) OKValuationView *valuationV;
@property (nonatomic, weak) OKPickCarTypeCardView *pickCarCardV;
@property (nonatomic, weak) OKValuationCardView *valuationCardV;
@end

@implementation OKViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UILabel *descL = [[UILabel alloc] init];
        descL.text = @"滴滴出行 选择车辆叫车页面";
        descL.textAlignment = NSTextAlignmentCenter;
        descL.textColor = [UIColor whiteColor];
        descL.backgroundColor = [UIColor orangeColor];
        descL.frame = CGRectMake(20, 100, self.view.bounds.size.width - 20 * 2, 20);
        descL;
    })];
    
    [self.view addSubview:({
        OKValuationView *v = [[OKValuationView alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 140)];
        self.valuationV = v;
        v;
    })];
    
    [self.view addSubview:({
        UILabel *descL = [[UILabel alloc] init];
        descL.text = @"首汽约车 选择车辆叫车页面";
        descL.textAlignment = NSTextAlignmentCenter;
        descL.textColor = [UIColor whiteColor];
        descL.backgroundColor = [UIColor redColor];
        descL.frame = CGRectMake(20, CGRectGetMaxY(self.valuationV.frame)+50, self.view.bounds.size.width - 20 * 2, 20);
        descL;
    })];
    
    [self.view addSubview:({
        OKPickCarTypeCardView *v = [[OKPickCarTypeCardView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.valuationV.frame)+90, self.view.frame.size.width, 100)];
        self.pickCarCardV = v;
        self.pickCarCardV.delegate = self;
        v;
    })];
    
    [self.view addSubview:({
        OKValuationCardView *v = [[OKValuationCardView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pickCarCardV.frame), self.view.frame.size.width, 30)];
        self.valuationCardV = v;
        v;
    })];
    
    OKCar *car0 = [[OKCar alloc] init];
    car0.name = @"优享";
    car0.price = @"12.02元";
    
    OKCar *car1 = [[OKCar alloc] init];
    car1.name = @"经济";
    car1.price = @"7.20元";
    
    OKCar *car2 = [[OKCar alloc] init];
    car2.name = @"豪华";
    car2.price = @"35.32元";
    
    [self.pickCarCardV setModels:@[car0, car1, car2]];
    
    self.pickCarCardV.hidden = YES;
    car0.isValuationSuccess = 2;
    [self.valuationCardV configureLoadingViewWithModel:car0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        car0.isValuationSuccess = 1;
        [self.valuationCardV configureLoadingViewWithModel:car0];
        [self.valuationCardV configureValuation:car0];
        self.pickCarCardV.hidden = NO;
    });
    
    [self.valuationV setDidPickCar:^(OKCar * _Nonnull car) {
        OKPriceDescViewController *vc = [[OKPriceDescViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - OKPickCarTypeCardViewDelegate

- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView didSelectItem:(OLAValuation *)item
{
    OKPriceDescViewController *vc = [[OKPriceDescViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView isScrolling:(BOOL)isScrolling
{
    [self.valuationCardV configSwitchLoadAnimationWithScrolling:isScrolling];
}

- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView didEndScrollToIndex:(NSInteger)index withModel:(OKCar *)model
{
    [self.valuationCardV configureValuation:model];
}

- (IBAction)clickRightBarItem:(UIBarButtonItem *)sender {
    OKDifferentModeImageVC *vc = [[OKDifferentModeImageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickLeftBarItem:(UIBarButtonItem *)sender {
    OKDisplayDifferentImageVC *vc = [[OKDisplayDifferentImageVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
