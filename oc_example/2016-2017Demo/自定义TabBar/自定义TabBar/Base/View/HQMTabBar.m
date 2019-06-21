//
//  HQMTabBar.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMTabBar.h"

#import "UIImage+ColorToImage.h"


CGFloat const kPadding = 11;
NSInteger const kTabBarTAG = 1000;

@interface HQMTabBar ()
//{
//    UIButton *_publishBtn;
//}
@property (nonatomic, weak) UIButton *publishBtn;
@property (nonatomic, weak) UILabel *publishLabel;
/** 记录上一次被点击按钮的tag */
@property (nonatomic, assign) NSInteger previousClickedTag;
@end

@implementation HQMTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //PS:必须 tabbar 的背景图片为自定义的时候，设置shadowImage才有效，即去掉系统自带的那条横线
        self.backgroundImage = [UIImage imageWithColor:RGBA(248, 248, 248, 1)];
        self.shadowImage = [[UIImage alloc] init];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:publishBtn];
    self.publishBtn = publishBtn;

    UILabel *publishLabel = [[UILabel alloc] init];
    publishLabel.text = @"发布";
    publishLabel.textAlignment = NSTextAlignmentCenter;
    publishLabel.font = [UIFont systemFontOfSize:10.];
    publishLabel.textColor = [UIColor grayColor];
    [publishLabel sizeToFit];
    [self addSubview:publishLabel];
    self.publishLabel = publishLabel;
}

- (void)publishBtnClick:(UIButton *)sender {
    if (self.delegate0 && [self.delegate0 respondsToSelector:@selector(tabBarDidClickPublishBtn:)]) {
        [self.delegate0 tabBarDidClickPublishBtn:self];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat tabBarBtnW = self.width / 5;
    NSInteger tabBarBtnIndex = 0;
    NSInteger i = 0;
    Class cls = NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:cls]) {
            child.x = tabBarBtnIndex * tabBarBtnW;
            child.width = tabBarBtnW;

            UIButton *tabBarBtn = (UIButton *)child;
            tabBarBtn.tag = i + kTabBarTAG;
            [tabBarBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            tabBarBtnIndex++;
            i++;
            
            if (tabBarBtnIndex == 2) {
                tabBarBtnIndex++;
            }
        }
    }

    _publishBtn.size = _publishBtn.currentBackgroundImage.size;
    _publishBtn.centerX = self.centerX;
    _publishBtn.centerY = self.height * 0.5 - kPadding * 2;
    DLog(@"%@", NSStringFromCGRect(_publishBtn.frame));

    _publishLabel.centerX = self.center.x;
    _publishLabel.centerY = CGRectGetMaxY(_publishBtn.frame) + kPadding;
}

- (void)tabBarBtnClick:(UIControl *)sender {
    if (_previousClickedTag == sender.tag - kTabBarTAG) {
        [NotificationCenter postNotificationName:HQMTabBarItemDidClickRepeatNotification object:NULL];
    }

    //记录
    _previousClickedTag = sender.tag - kTabBarTAG;
    DLog(@"%ld", _previousClickedTag);
}

//重写hitTest方法，去监听自定义按钮的点击，目的为了让凸出的部分点击也响应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //这一判断是关键，不判断的push到其他页面，点击自定义按钮的位置也是会有响应的
    if (!self.isHidden) {
        //将当前tabbar的触摸点转换坐标系，转换到自定义按钮的身上，生成一个新的点
        //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
        //在导航控制器根控制器页面，就需要判断点击的位置是否在自定义按钮身上
        //是的话让自定义按钮处理事件，不是的话让系统自己处理
        CGPoint newP = [self convertPoint:point toView:_publishBtn];
        if ([_publishBtn pointInside:newP withEvent:event]) {
            return _publishBtn;
        } else {
            return [super hitTest:point withEvent:event];
        }
    }
    
    //tabbar隐藏了，说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
    return [super hitTest:point withEvent:event];
}

@end
