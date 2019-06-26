//
//  ViewController.m
//  Waterflow_Example
//
//  Created by apple on 15/8/9.
//  Copyright (c) 2015年 Keymon. All rights reserved.
//

#import "ViewController.h"
#import "HKWaterflowView.h"
#import "HKWaterflowViewCell.h"

@interface ViewController () <HKWaterflowViewDataSource, HKWaterflowViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HKWaterflowView *waterflowView = [[HKWaterflowView alloc] init];
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
}

#pragma mark - 数据源方法
- (NSUInteger)numberOfCellsInWaterflowView:(HKWaterflowView *)waterflowView
{
    return 60;
}

- (NSUInteger)numberOfColumnsInWaterflowView:(HKWaterflowView *)waterflowView
{
    return 3;
}

- (HKWaterflowViewCell *)waterflowView:(HKWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    static NSString *ID = @"cell";
    HKWaterflowViewCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HKWaterflowViewCell alloc] init];
        cell.identifier = ID;
        cell.backgroundColor = HKRandomColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = 10;
        label.frame = CGRectMake(30, 30, 50, 20);
        [cell addSubview:label];
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%ld", index];
    
    // 打印序号和地址查看是否循环重用
    NSLog(@"---%ld---%p", index, cell);
    return cell;
}

#pragma mark - 代理
- (CGFloat)waterflowView:(HKWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    switch (index % 3) {
        case 0:
            return 80;
        case 1:
            return 90;
        case 2:
            return 100;
        default:
            return 120;
    }
}

- (CGFloat)waterflowView:(HKWaterflowView *)waterflowView marginForType:(HKWaterflowViewMarginType)type
{
    //    if (type == 0) {
    //        return 10;
    //    }
    //
    //    return 5;
    
    switch (type) {
        case HKWaterflowViewMarginTypeTop:
        case HKWaterflowViewMarginTypeBottom:
        case HKWaterflowViewMarginTypeLeft:
        case HKWaterflowViewMarginTypeRight:
            return 20;
            
        default: return 10;
    }
}

- (void)waterflowView:(HKWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    NSLog(@"点击了第%ld个cell", index);
}


@end
