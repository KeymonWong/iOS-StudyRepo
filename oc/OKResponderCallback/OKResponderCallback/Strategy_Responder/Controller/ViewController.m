//
//  ViewController.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/9.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"

#import "OKRouteEventView.h"

#import "UIResponder+Router.h"

#import "OKSchedule.h"

#import "OKEventProxy.h"

#import "OKEventName.h"

@interface ViewController ()
@property(nonatomic, strong) OKRouteEventView *routeEventV;
@property(nonatomic, strong) OKEventProxy *eventProxy;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.routeEventV];
    
    // block一层一层向上传递事件
    // 方式1：采用block回调的方式交互
    [self.routeEventV setRouterEventBlock:^{
        NSLog(@"\n>>>>>>\n通过block回调事件\n<<<<<<");
    }];
    
    // 策略模式
    OKSchedule *sch = [[OKSchedule alloc] init];
    [sch doWithTime:kCodeName userInfo:@{@"happy" : @"代码使我快乐"}];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.routeEventV.frame = self.view.bounds;
}

#pragma mark - event response based on UIResponder chain

// 方式2：采用基于响应链的方式交互
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSLog(@"\n>>>>>>\n通过 responder chain 回调事件\n<<<<<<");
    NSLog(@"\n>>>>>>\nwow..., 太神奇了\n<<<<<<\n\n>>>>>>\n%@\n<<<<<<", userInfo);
    
    /*
     * do whatever u want to do
     */
    
    // 可以把事件统一传到一个类里面做统一处理
    [self.eventProxy handleEvent:eventName userInfo:userInfo];
    
    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark - lazy load

- (OKRouteEventView *)routeEventV {
    if (!_routeEventV) {
        _routeEventV = [[OKRouteEventView alloc] initWithFrame:self.view.bounds];
    }
    return _routeEventV;
}

- (OKEventProxy *)eventProxy {
    if (!_eventProxy) {
        _eventProxy = [[OKEventProxy alloc] init];
    }
    return _eventProxy;
}

@end
