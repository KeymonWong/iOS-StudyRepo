//
//  KWRingProgressBar.m
//  RingProgressBar_UIBezierPath
//
//  Created by keymon on 2018/7/25.
//  Copyright © 2018 xiaoban. All rights reserved.
//

#import "KWRingProgressBar.h"

const CGFloat kLineWidth = 2.;

@interface KWRingProgressBar ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *outLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@end

@implementation KWRingProgressBar

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBgImage];
        [self setupOutLayer];
    }
    return self;
}

- (void)setupBgImage {
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.imageView];
}

- (void)setupOutLayer {
    self.outLayer = [[CAShapeLayer alloc] init];
    CGRect rect = {kLineWidth * 0.5, kLineWidth * 0.5, self.frame.size.width - kLineWidth, self.frame.size.height - kLineWidth};
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    self.outLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    self.outLayer.lineWidth = kLineWidth;
    self.outLayer.fillColor = [UIColor clearColor].CGColor;
    self.outLayer.lineCap = kCALineCapRound;
    self.outLayer.path = path.CGPath;
    [self.layer addSublayer:self.outLayer];
    
    self.progressLayer = [[CAShapeLayer alloc] init];
    self.progressLayer.strokeColor = [UIColor greenColor].CGColor;
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.lineWidth = kLineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = path.CGPath;
    [self.layer addSublayer:self.progressLayer];
    
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)setImageURL:(NSString *)url {
    self.imageView.image = [UIImage imageNamed:@"xiaohan_logo.png"];
}

- (void)updateProgressWithValue:(NSUInteger)value {
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.progressLayer.strokeEnd = value / 100.;
    [CATransaction commit];
}


@end
