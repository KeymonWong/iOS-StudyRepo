//
//  WeexViewController.m
//  native-weex
//
//  Created by keymon on 2020/3/9.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WeexViewController.h"

#import <WeexSDK/WXSDKInstance.h>

@interface WeexViewController ()
@property (nonatomic, weak) WXSDKInstance *wxInstance;
@property (nonatomic, strong) UIView *currentV;
@end

@implementation WeexViewController

- (void)dealloc {
    [self.wxInstance destroyInstance];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Weex 页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self renderWeexPage];
}

- (void)renderWeexPage {
    __weak typeof(self) weakSelf = self;
    self.wxInstance.onCreate = ^(UIView * _Nonnull view) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) return;
        [self.currentV removeFromSuperview];
        view.backgroundColor = [UIColor systemPurpleColor];
        self.currentV = view;
        [self.view addSubview:self.currentV];
    };
    
    self.wxInstance.onFailed = ^(NSError *error) {
        NSLog(@"weex渲染失败：%@", error);
    };
    
    self.wxInstance.renderFinish = ^ (UIView *view) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) return;
        self.wxInstance.state = WeexInstanceAppear;
    };
    
    self.wxInstance.refreshFinish = ^(UIView * _Nonnull view) {
        
    };
    
    self.wxInstance.onScroll = ^(CGPoint contentOffset) {
        
    };
    
    [self.wxInstance renderWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.wxInstance.frame = self.view.bounds;
}

- (WXSDKInstance *)wxInstance {
    if (!_wxInstance) {
        WXSDKInstance *ins = [[WXSDKInstance alloc] init];
        _wxInstance = ins;
        _wxInstance.viewController = self;
    }
    return _wxInstance;
}

@end
