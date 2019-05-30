//
//  OKPulseAnimationView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/30.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKPulseAnimationView.h"

@interface OKPulseAnimationView ()
@property (nonatomic, assign) OKPulseType pulseType;
@property (nonatomic, strong) CAShapeLayer *pulseLayer;
@end

@implementation OKPulseAnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame pulseType:OKPulseTypeCircle];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectZero pulseType:OKPulseTypeCircle];
}

- (instancetype)initWithFrame:(CGRect)frame pulseType:(OKPulseType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pulseType = type;
        [self configureLayer];
    }
    return self;
}

- (void)configureLayer {
    self.pulseLayer = [CAShapeLayer layer];
    self.pulseLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.pulseLayer.position = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    self.pulseLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    self.pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.pulseLayer.bounds].CGPath;
    self.pulseLayer.fillColor = [UIColor orangeColor].CGColor;
    self.pulseLayer.opacity = 0;
    
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.bounds = self.pulseLayer.bounds;
    repLayer.position = self.pulseLayer.position;
    
    if (self.pulseType == OKPulseTypeCircle) {
        repLayer.instanceCount = 3; // 3 个复制图层
    } else if (self.pulseType == OKPulseTypeOval) {
        repLayer.instanceCount = 3; // 1 个复制图层
    }
    
    repLayer.instanceDelay = 1;
    [repLayer addSublayer:self.pulseLayer];
    [self.layer insertSublayer:repLayer atIndex:0];
}

- (void)startAnimation {
    [self stopAnimation];
    
    // 透明度动画
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.fromValue = @(1);
    opacityAni.toValue = @(0);
    
    // 扩散动画
    CABasicAnimation *spreadAni = [CABasicAnimation animationWithKeyPath:@"transform"];
    spreadAni.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0, 0, 0)];
    spreadAni.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
    
    // 组合动画
    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
    aniGroup.animations = @[opacityAni, spreadAni];
    aniGroup.duration = 3; // 持续时间
    aniGroup.autoreverses = false; // 是否循环
    
    if (self.pulseType == OKPulseTypeCircle) {
        aniGroup.repeatCount = MAXFLOAT; // 无限次循环
    } else if (self.pulseType == OKPulseTypeOval) {
        aniGroup.repeatCount = MAXFLOAT;
    }
    
    [self.pulseLayer addAnimation:aniGroup forKey:nil];
}

- (void)stopAnimation {
    [self.pulseLayer removeAllAnimations];
}

@end
