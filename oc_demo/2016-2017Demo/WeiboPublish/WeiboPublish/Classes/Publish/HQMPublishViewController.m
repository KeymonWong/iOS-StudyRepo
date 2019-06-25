//
//  HQMPublishViewController.m
//  WeiboPublish
//
//  Created by 小伴 on 2017/3/10.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMPublishViewController.h"

#import "HQMComposeViewController.h"
#import "HQMMenuButton.h"
#import "UIView+YYAdd.h"

@interface HQMPublishViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) NSUInteger upIdx;
@property (nonatomic, assign) NSUInteger downIdx;
@property (nonatomic, strong) UIImageView *closeImgView;
@property (nonatomic, strong) NSArray *imgs;
@end

@implementation HQMPublishViewController

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (NSArray *)imgs {
    if (!_imgs) {
        _imgs = [NSArray arrayWithObjects:@"18001",@"18002",@"18003",@"18004",@"18005",@"18006", nil];
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupBackgroudImgView];

    [self setupCloseImg];

    [self setupMenus];

    [self addGesture];

    [self intializeTimer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [UIView animateWithDuration:0.35 animations:^{
        _closeImgView.transform = CGAffineTransformRotate(_closeImgView.transform, M_PI_2);

    } completion:^(BOOL finished) {}];
}

- (void)setupBackgroudImgView {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:_backgroudImg];
    UIView *blurView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [blurView setBackgroundColor:[UIColor colorWithWhite:.9 alpha:.9]];
    [imgView addSubview:blurView];

    [self.view addSubview:imgView];

    [self setupWeatherView];
}

- (void)setupWeatherView {
    UIView *weather = [[UIView alloc] initWithFrame:CGRectMake(10, 50, self.view.width-20, 120)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weather.jpg"]];
    imgView.frame = weather.bounds;
    [weather addSubview:imgView];
    [self.view addSubview:weather];
}

- (void)setupCloseImg {
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"]];
    imgView.frame = CGRectMake(self.view.centerX-15, self.view.height-30, 30, 30);
    [self.view addSubview:imgView];
    _closeImgView = imgView;
}

- (void)setupMenus {
    int cols = 3;
    int col = 0;
    int row = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat wh = 90;
    CGFloat padding = (self.view.width-cols*wh)/(cols+1);
    CGFloat originY = 300;

    NSArray *titles = @[@"文字", @"拍摄", @"相册", @"直播", @"头条文章", @"点评", @"签到", @"收藏", @"更多"];
    for (int i = 0; i < self.imgs.count; i++) {
        HQMMenuButton *btn = [HQMMenuButton buttonWithType:UIButtonTypeCustom];
        UIImage *img = [UIImage imageNamed:self.imgs[i]];
        NSString *title = titles[i];

        [btn setImage:img forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];

        col = i % cols;
        row = i / cols;

        x = padding + col * (padding + wh);
        y = row * (padding + wh) + originY;

        btn.frame = CGRectMake(x, y, wh, wh);
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.height);
        btn.tag = 1000 + i;
        [btn addTarget:self action:@selector(selectCurrentBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self.items addObject:btn];
        [self.view addSubview:btn];
    }
}

- (void)addGesture {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [self.view addGestureRecognizer:tapGR];
}

- (void)intializeTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popMenus) userInfo:nil repeats:YES];
}

- (void)selectCurrentBtn:(UIButton *)sender {
    NSLog(@"%ld为btn.tag的值",sender.tag);

    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformMakeScale(2., 2.);
        sender.alpha = 0.;
        [self.items removeObject:sender];
        for (UIButton *btn in self.items) {
            btn.transform = CGAffineTransformMakeScale(0.5, 0.5);
            btn.alpha = 0.;
        }
    } completion:^(BOOL finished) {
        HQMComposeViewController *composeVC = [[HQMComposeViewController alloc] init];
        [self presentViewController:composeVC animated:YES completion:^{}];
    }];
}

- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnLastVC) userInfo:nil repeats:YES];

    [UIView animateWithDuration:0.35 animations:^{
        _closeImgView.transform = CGAffineTransformRotate(_closeImgView.transform, -M_PI_4);
    } completion:^(BOOL finished) {}];
}

- (void)popMenus {
    if (_upIdx == self.imgs.count) {
        [self.timer invalidate];
        self.timer = nil;

        _upIdx = 0;
        return;
    }

    HQMMenuButton *btn = self.items[_upIdx];
    [self animationShowFromFirstItemBtn:btn];

    _upIdx++;
}

//设置按钮从第一个开始向上渐入
- (void)animationShowFromFirstItemBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        sender.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //获取当前显示的菜单控件的索引
        _downIdx = self.imgs.count - 1;
    }];
}

- (void)returnLastVC {
    if (_downIdx == -1) {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }

    HQMMenuButton *btn = self.items[_downIdx];
    [self animationDismissFromLastItemBtn:btn];
    _downIdx--;
}

//设置按钮从最后一个开始向下渐出
- (void)animationDismissFromLastItemBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.35 animations:^{
        sender.transform = CGAffineTransformMakeTranslation(0, self.view.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.35 animations:^{
            self.view.alpha = 0.;
        } completion:^(BOOL finished) {
            if (self.parentViewController) {
                [self willMoveToParentViewController:nil];
                [self removeFromParentViewController];
                [self.view removeFromSuperview];
                self.view = nil;
            }
        }];
//        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
}

@end
