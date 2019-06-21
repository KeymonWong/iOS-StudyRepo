//
//  HQMLaunchViewController.m
//  WeiboPublish
//
//  Created by 小伴 on 2017/3/10.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMLaunchViewController.h"

#import "HQMPublishViewController.h"
#import "UIView+YYAdd.h"

#define kTransform -80

@interface HQMLaunchViewController ()
@property (nonatomic, weak) UIImageView *iconImgView;
@property (nonatomic, weak) UILabel *iconLabel;
@end

@implementation HQMLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubviews];

//    [self animate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self animate];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.iconImgView.size = CGSizeMake(100, 100);
    self.iconImgView.top = 100;
    self.iconImgView.centerX = self.view.centerX;

    self.iconLabel.top = 220.;
    self.iconLabel.centerX = self.view.centerX;
}

- (void)setupSubviews {
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"me.jpeg"];
    iconImg.contentMode = UIViewContentModeScaleAspectFill;
    iconImg.layer.cornerRadius = 100 * 0.5;
    iconImg.layer.masksToBounds = YES;
    iconImg.layer.borderWidth = 2.;
    iconImg.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:iconImg];
    self.iconImgView = iconImg;

    UILabel *iconLabel = [[UILabel alloc] init];
    iconLabel.font = [UIFont systemFontOfSize:15];
    iconLabel.textColor = [UIColor orangeColor];
    iconLabel.textAlignment = NSTextAlignmentCenter;
    iconLabel.text = @"黃小萌";
    [iconLabel sizeToFit];
    [self.view addSubview:iconLabel];
    self.iconLabel = iconLabel;
    self.iconLabel.alpha = 0.0;
}


- (void)animate {
    //改变参数的值会有不同的效果
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconImgView.transform = CGAffineTransformTranslate(self.iconImgView.transform, 0, kTransform);
        self.iconLabel.transform = CGAffineTransformTranslate(self.iconLabel.transform, 0, kTransform);
    } completion:^(BOOL finished) {
        //动画结束后设置欢迎label为不透明（使用首尾式动画区分block）
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        self.iconLabel.alpha = 1.;
        [UIView commitAnimations];
    }];
}

- (IBAction)publishBtnClick:(UIButton *)sender {
    HQMPublishViewController *publishVC = [[HQMPublishViewController alloc] init];
    UIImage *img = [self.view snapshotImage];
    publishVC.backgroudImg = img;

    [self addChildViewController:publishVC];
    [publishVC didMoveToParentViewController:self];
    [self.view addSubview:publishVC.view];
    publishVC.view.alpha = 0.;

    [UIView animateWithDuration:0.5 animations:^{
        publishVC.view.alpha = 1.;
    } completion:^(BOOL finished) {
    }];

//    [self presentViewController:publishVC animated:YES completion:NULL];
}

@end
