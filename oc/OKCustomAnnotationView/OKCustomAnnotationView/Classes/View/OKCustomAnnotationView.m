//
//  OKCustomAnnotationView.m
//  OKSegment
//
//  Created by 小伴 on 16/11/15.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "OKCustomAnnotationView.h"

#import "UIView+AddBadgeView.h"
#import "OKCustomAnnotation.h"

@interface OKCustomAnnotationView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *dotImageView;

@property (nonatomic, assign) NSInteger number;
@end

@implementation OKCustomAnnotationView

#pragma mark - Life Cycle

- (void)dealloc {
    self.backgroundImageView = nil;
    self.avatarImageView = nil;
    self.dotImageView = nil;
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    OKCustomAnnotation *ann = (OKCustomAnnotation *)annotation;
    self = [super initWithAnnotation:ann reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initializeAnnotation:ann];
    }

    return self;
}

- (void)initializeAnnotation:(OKCustomAnnotation *)ann {
    [self setupAnnotation:ann];
}


- (void)setAnnotation:(id<MAAnnotation>)annotation {
    [super setAnnotation:annotation];

    OKCustomAnnotation *ann = (OKCustomAnnotation *)self.annotation;

    // 当annotation滑出地图时候，即ann为nil时，不设置(否则由于枚举的类型会执行不该执行的方法)，
    // 只有annotation在地图范围内出现时才设置，可以打断点调试
    if (ann) {
        [self setupAnnotation:ann];
    }
}

- (void)setupAnnotation:(OKCustomAnnotation *)ann {
    NSString *mask = @"";
    CGRect frame = CGRectZero;
    switch (ann.type) {
        case CustomAnnotationTypeMe: {//我的头像背景
            frame = CGRectMake(0, 0, 48., 60.);
            mask = @"xh_dq_zb_bg.png";

            break;
        }
        case CustomAnnotationTypeFemale: {
            frame = CGRectMake(0, 0, 34., 46.);
            mask = @"xh_zb_red_ic.png";
            break;
        }
        case CustomAnnotationTypeMale: {
            frame = CGRectMake(0, 0, 34., 46.);
            mask = @"xh_zb_ic.png";
            break;
        }
    }

    self.bounds = frame;
    self.centerOffset = CGPointMake(0, -self.bounds.size.height*0.5);

    //设置背景图片
    self.backgroundImageView.image = [UIImage imageNamed:mask];
    self.backgroundImageView.frame = self.bounds;

    //设置头像图片
    self.avatarImageView.frame = CGRectMake(3, 3, self.bounds.size.width-6, self.bounds.size.width-6);
    self.avatarImageView.layer.cornerRadius = (self.bounds.size.width-6) * 0.5;
    self.avatarImageView.layer.masksToBounds = YES;

    if (ann.type == CustomAnnotationTypeMe) {
        if (!self.dotImageView) {
            self.dotImageView = [[UIImageView alloc] init];
            self.dotImageView.frame = CGRectMake((frame.size.width - 11)/2, frame.size.height - 8, 12, 12);
            [self addSubview:self.dotImageView];
            [self sendSubviewToBack:self.dotImageView];
            self.dotImageView.image = [UIImage imageNamed:@"xh_yuandian_ic.png"];
        }

        if (ann.number != 0) {
            [self addBadgeViewWithNumber:ann.number];
        }

    } else {
        if (self.dotImageView) {
            [self.dotImageView removeFromSuperview];
            self.dotImageView = nil;
        }

        if (self.badgeView) {
            [self.badgeView removeFromSuperview];
            self.badgeView = nil;
        }
    }

    [self setupAvatarImage];
}

- (void)setupAvatarImage {
    OKCustomAnnotation *ann = (OKCustomAnnotation *)self.annotation;

    self.avatarImageView.image = [UIImage imageNamed:ann.imagePath];
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        [self.backgroundImageView addSubview:_avatarImageView];
    }
    return _avatarImageView;
}






#pragma mark - Override


//- (NSString *)title
//{
//    return self.titleLabel.text;
//}
//
//- (void)setTitle:(NSString *)name
//{
//    self.titleLabel.text = name;
//}
//
//- (UIImage *)portrait
//{
//    return self.portraitImageView.image;
//}
//
//- (void)setPortrait:(UIImage *)portrait
//{
//    self.portraitImageView.image = portrait;
//}
//
////- (void)setupModel {
////    self.titleLabel.text = _title;
////    self.portraitImageView.image = _portrait;
////}
////
////- (void)setAnnotation:(id<MAAnnotation>)annotation {
////    [super setAnnotation:annotation];
////
////    [self setupModel];
////}
//
//- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.bounds = CGRectMake(0, 0, 35, 45);
//        self.backgroundColor = [UIColor clearColor];
//
//        [self setupSubviews];
//    }
//    return self;
//}
//
//- (void)setupSubviews {
//    self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 45)];
//    [self addSubview:self.portraitImageView];
//
//    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 13, 35, 20)];
//    self.titleLabel.font = [UIFont systemFontOfSize:13];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.textColor = [UIColor greenColor];
//    [self addSubview:self.titleLabel];
//}

@end
