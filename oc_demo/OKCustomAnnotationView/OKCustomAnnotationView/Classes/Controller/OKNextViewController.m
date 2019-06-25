//
//  OKNextViewController.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/6.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKNextViewController.h"

@interface OKNextViewController ()

@end

@implementation OKNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *cardV = [[UIView alloc] init];
//    cardV.backgroundColor = [UIColor greenColor];
    
    UIImageView *leftImgV = [[UIImageView alloc] init];
    leftImgV.frame = CGRectMake(0, 0, 100, 76);
    leftImgV.image = [UIImage imageNamed:@"map-bubble_bg_tworow_left"];
    [cardV addSubview:leftImgV];
    
    UIImageView *rightImgV = [[UIImageView alloc] init];
    rightImgV.frame = CGRectMake(100, 0, 100, 76);
    rightImgV.image = [UIImage imageNamed:@"map-bubble_bg_tworow_right"];
    [cardV addSubview:rightImgV];
    
    cardV.frame = CGRectMake(100, 100, 200, 76);
    [self.view addSubview:cardV];
}

@end
