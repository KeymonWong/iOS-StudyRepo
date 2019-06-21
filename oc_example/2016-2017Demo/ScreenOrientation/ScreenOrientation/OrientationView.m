//
//  OrientationView.m
//  ScreenOrientation
//
//  Created by 小伴 on 2017/2/7.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "OrientationView.h"

@interface OrientationView ()
@property (nonatomic, assign) BOOL isFullScreen;
@property (nonatomic, assign) BOOL isOriginalFrame;
@property (nonatomic, assign) BOOL isBarHidden;
@property (nonatomic, strong) UIWindow *keyWindow;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, weak) UILabel *l;
@end

@implementation OrientationView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (instancetype)init {
    self = [super init];
    if (self) {

        UILabel *l = [[UILabel alloc] init];
        l.text = @"头--------------------------------尾";
        [self addSubview:l];
        self.l = l;

        self.backgroundColor = [UIColor greenColor];

        self.keyWindow = [UIApplication sharedApplication].keyWindow;

        //屏幕方向改变
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];

        _isBarHidden = YES;
    }
    return self;
}

- (void)statusBarOrientationChange:(NSNotification *)noti {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (orientation == UIDeviceOrientationLandscapeLeft) {
        [self orientationLeft];
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        [self orientationRight];
    } else if (orientation == UIDeviceOrientationPortrait) {
        if (_isFullScreen) {
            [self orientationPortrait];
        }
    }
}

- (void)orientationLeft {
    _isFullScreen = YES;
    [self.keyWindow addSubview:self];

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];

    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI / 2);
//        self.frame = self.keyWindow.bounds;
    }];

    [self setStatusBarHidden:YES];
}

- (void)orientationRight {
    _isFullScreen = YES;
    [self.keyWindow addSubview:self];

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeRight] forKey:@"orientation"];

    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
//        self.frame = self.keyWindow.bounds;
    }];

    [self setStatusBarHidden:YES];
}

- (void)orientationPortrait {
    _isFullScreen = NO;

    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];

    [self updateConstraintsIfNeeded];

    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = self.originalFrame;
    }];

    [self setStatusBarHidden:NO];
}

- (void)setStatusBarHidden:(BOOL)hidden {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.hidden = hidden;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.l.frame = CGRectMake(20, 70, 280, 15);

    if (!_isOriginalFrame) {
        self.originalFrame = self.frame;
        _isOriginalFrame = YES;
    }
}

@end
