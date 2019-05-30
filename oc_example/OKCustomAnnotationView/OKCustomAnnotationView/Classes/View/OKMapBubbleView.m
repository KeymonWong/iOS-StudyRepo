//
//  OKMapBubbleView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/7.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKMapBubbleView.h"

@interface OKMapBubbleView ()
@property (nonatomic, weak) UIView *containerV;
@property (nonatomic, weak) UIImageView *bgImgV;

@property (nonatomic, weak) UIImageView *leftImgV;
@property (nonatomic, weak) UIImageView *rightImgV;
@property (nonatomic, weak) UILabel *contentL;
@end

@implementation OKMapBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
//    UIView *cardV = [[UIView alloc] init];
//    cardV.frame = CGRectMake(0, 0, 200, 46);
//    [self addSubview:cardV];
//
//    UIImageView *leftImgV = [[UIImageView alloc] init];
//    leftImgV.frame = CGRectMake(0, 0, 100, 64);
//    leftImgV.image = [UIImage imageNamed:@"map-bubble_bg_tworow_left"];
////    [cardV addSubview:leftImgV];
//
//    UIImageView *rightImgV = [[UIImageView alloc] init];
//    rightImgV.frame = CGRectMake(100, 0, 100, 64);
//    rightImgV.image = [UIImage imageNamed:@"map-bubble_bg_tworow_right"];
////    [cardV addSubview:rightImgV];
//
//    UIImageView *timerImgV = [[UIImageView alloc] init];
//    timerImgV.frame = CGRectMake(6, 6.5, 46, 46);
//    timerImgV.image = [UIImage imageNamed:@"map-bubble_timer_bg"];
//    [leftImgV addSubview:timerImgV];
//
//    UIImageView *dotImgV = [[UIImageView alloc] init];
//    dotImgV.frame = CGRectMake(-1, -1, 50, 50);
//    dotImgV.image = [UIImage imageNamed:@"map-bubble_timer_ball1"];
//    [timerImgV addSubview:dotImgV];
////    [self addRotationAnimatorForView:dotImgV];
//
//    [cardV addSubview:({
//        UIImageView *bg = [[UIImageView alloc] init];
//        bg.image = [UIImage imageNamed:@"map_bubble_bg"];
//        bg.frame = CGRectMake(0, 0, 200, 40);
//        self.bgImgV = bg;
//        bg;
//    })];
//
//    UIImageView *arrowImgV = [[UIImageView alloc] init];
//    arrowImgV.image = [UIImage imageNamed:@"map_bubble_arrow_down"];
//    arrowImgV.frame = CGRectMake((CGRectGetWidth(cardV.frame)-arrowImgV.image.size.width)*0.5, CGRectGetHeight(self.bgImgV.frame)-1, 11, 6);
//    [cardV addSubview:arrowImgV];
    
    
    [self addSubview:({
        UIImageView *leftImgV = [[UIImageView alloc] init];
        leftImgV.image = [UIImage imageNamed:@"map-bubble_bg_onerow_left"];
        self.leftImgV = leftImgV;
        leftImgV;
    })];
    
    [self addSubview:({
        UIImageView *rightImgV = [[UIImageView alloc] init];
        rightImgV.image = [UIImage imageNamed:@"map-bubble_bg_onerow_right"];
        self.rightImgV = rightImgV;
        rightImgV;
    })];
    
    [self addSubview:({
        UILabel *l = [[UILabel alloc] init];
        l.textColor = [UIColor purpleColor];
        l.font = [UIFont systemFontOfSize:12];
        l.textAlignment = NSTextAlignmentCenter;
        l.text = @"3分钟 附件暂无车辆";
        self.contentL = l;
        l;
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.leftImgV.image.size.height;
    
    self.leftImgV.frame = CGRectMake(0, 0, width * 0.5, height);
    self.rightImgV.frame = CGRectMake(width * 0.5, 0, width * 0.5, height);
    
    [self.contentL sizeToFit];
    self.contentL.frame = CGRectMake(10, (height - self.contentL.frame.size.height) * 0.5 - 2, width - 10 * 2, self.contentL.frame.size.height);
}

- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
    
}

- (void)addRotationAnimatorForView:(UIImageView *)view {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = @(M_PI * 2);
    ani.cumulative = YES;
    ani.duration = 1;
    ani.repeatCount = MAXFLOAT;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    ani.removedOnCompletion = YES;
    
    [view.layer addAnimation:ani forKey:@"rotationAni"];
    [view.layer removeAnimationForKey:@"rotationAni"];
}

@end
