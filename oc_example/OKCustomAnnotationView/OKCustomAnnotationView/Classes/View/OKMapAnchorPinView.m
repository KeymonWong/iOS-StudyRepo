//
//  OKMapAnchorPinView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/16.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKMapAnchorPinView.h"

#import "OKMapBubbleView.h"

@interface OKMapAnchorPinView ()
@property (nonatomic, strong) UIView *containerV;
@property (nonatomic, strong) OKMapBubbleView *bubbleV; ///< 气泡
@property (nonatomic, strong) UIImageView *pinHeaderImgV; ///< 头部图片
@property (nonatomic, strong) UIImageView *pinImgV; ///< 中间部分
@property (nonatomic, strong) UIImageView *pinTailImgV; ///< 尾部图片，一个 点
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
    [self.containerV addSubview:self.pinHeaderImgV];
    [self.containerV addSubview:self.pinImgV];
    [self.containerV addSubview:self.pinTailImgV];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
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
        _pinHeaderImgV.image = [UIImage imageNamed:@"driver_map_point_header_black"];
    }
    return _pinHeaderImgV;
}

- (UIImageView *)pinTailImgV {
    if (!_pinTailImgV) {
        _pinTailImgV = [[UIImageView alloc] init];
        _pinTailImgV.contentMode = UIViewContentModeScaleAspectFit;
        _pinTailImgV.image = [UIImage imageNamed:@""];
    }
    return _pinTailImgV;
}

- (UIImageView *)pinImgV {
    if (!_pinImgV) {
        _pinImgV = [[UIImageView alloc] init];
        _pinImgV.contentMode = UIViewContentModeScaleAspectFit;
        _pinImgV.image = [UIImage imageNamed:@"driver_map_point_tail_black"];
    }
    return _pinImgV;
}

@end
