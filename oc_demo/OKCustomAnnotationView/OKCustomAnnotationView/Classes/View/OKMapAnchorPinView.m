//
//  OKMapAnchorPinView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/16.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKMapAnchorPinView.h"

#import "OKMapBubbleView.h"
#import "OKPulseAnimationView.h"

@interface OKMapAnchorPinView ()
@property (nonatomic, strong) UIView *containerV;
@property (nonatomic, strong) OKMapBubbleView *bubbleV; ///< 气泡
@property (nonatomic, strong) UIImageView *pinHeaderImgV; ///< 头部图片
@property (nonatomic, strong) UIImageView *pinImgV; ///< 中间部分
@property (nonatomic, strong) UIImageView *pinTailImgV; ///< 尾部图片，一个 点
@property (nonatomic, strong) OKPulseAnimationView *pulseAniV; ///< 动画 view
@end

@implementation OKMapAnchorPinView

#pragma mark - life circle

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:self.containerV];
    [self.containerV addSubview:self.bubbleV];
    [self.containerV addSubview:self.pinImgV];
    [self.containerV addSubview:self.pinHeaderImgV];
//    [self.containerV addSubview:self.pinTailImgV];
    [self.containerV insertSubview:self.pulseAniV belowSubview:self.pinImgV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerV.frame = self.bounds;
    self.bubbleV.frame = CGRectMake(0, 0, self.containerV.frame.size.width, 50);
    
    CGRect pinHeadFrame = CGRectMake((self.containerV.frame.size.width - self.pinHeaderImgV.image.size.width) * 0.5,
                                     CGRectGetMaxY(self.bubbleV.frame),
                                     self.pinHeaderImgV.image.size.width,
                                     self.pinHeaderImgV.image.size.height);
    self.pinHeaderImgV.frame = pinHeadFrame;
    
    CGRect pinFrame = CGRectMake((self.containerV.frame.size.width - self.pinImgV.image.size.width) * 0.5,
                                 CGRectGetMaxY(self.pinHeaderImgV.frame) - self.pinImgV.image.size.height * 0.5,
                                 self.pinImgV.image.size.width,
                                 self.pinImgV.image.size.height);
    self.pinImgV.frame = pinFrame;
    
    CGRect pinTailFrame = CGRectMake((self.containerV.frame.size.width - self.pinTailImgV.image.size.width) * 0.5,
                                     CGRectGetMaxY(self.pinImgV.frame) - 4,
                                     self.pinTailImgV.image.size.width,
                                     self.pinTailImgV.image.size.height);
    self.pinTailImgV.frame = pinTailFrame;
    
    self.pulseAniV.frame = CGRectMake((self.frame.size.width - 60) * 0.5, self.frame.size.height - 30 * 0.5 - 2, 60, 30);
}

- (void)movingMap {
    
}

- (void)endMoveMap {
    
}

- (void)startAnimation {
    [self.pulseAniV startAnimation];
}

- (void)stopAnimation {
    [self.pulseAniV stopAnimation];
}

#pragma mark - lazy load

- (UIView *)containerV {
    if (!_containerV) {
        _containerV = [[UIView alloc] init];
        _containerV.backgroundColor = [UIColor clearColor];
    }
    return _containerV;
}

- (OKMapBubbleView *)bubbleV {
    if (!_bubbleV) {
        _bubbleV = [[OKMapBubbleView alloc] init];
    }
    return _bubbleV;
}

- (UIImageView *)pinHeaderImgV {
    if (!_pinHeaderImgV) {
        _pinHeaderImgV = [[UIImageView alloc] init];
        _pinHeaderImgV.contentMode = UIViewContentModeScaleAspectFit;
        _pinHeaderImgV.image = [UIImage imageNamed:@"takecar_map_point_header"];
    }
    return _pinHeaderImgV;
}

- (UIImageView *)pinTailImgV {
    if (!_pinTailImgV) {
        _pinTailImgV = [[UIImageView alloc] init];
        _pinTailImgV.contentMode = UIViewContentModeScaleAspectFit;
        _pinTailImgV.image = [UIImage imageNamed:@"home_icon_recommended"];
    }
    return _pinTailImgV;
}

- (UIImageView *)pinImgV {
    if (!_pinImgV) {
        _pinImgV = [[UIImageView alloc] init];
        _pinImgV.contentMode = UIViewContentModeScaleAspectFit;
        _pinImgV.image = [UIImage imageNamed:@"takecar_map_point_tail"];
    }
    return _pinImgV;
}

- (OKPulseAnimationView *)pulseAniV {
    if (!_pulseAniV) {
        _pulseAniV = [[OKPulseAnimationView alloc] initWithFrame:CGRectMake(0, 0, 60, 30) pulseType:OKPulseTypeOval];
    }
    return _pulseAniV;
}

@end
