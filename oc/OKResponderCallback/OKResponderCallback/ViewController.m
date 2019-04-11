//
//  ViewController.m
//  OKSnippet
//
//  Created by keymon on 2019/4/9.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"

#import "OKRouteEventView.h"

#import "UIResponder+Router.h"

@interface ViewController ()
@property(nonatomic, strong) OKRouteEventView *routeEventV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.routeEventV];
    
    // block一层一层传递事件
    [self.routeEventV setRouterEventBlock:^{
        NSLog(@"\n>>>>>>\n通过block回调事件\n<<<<<<");
    }];
}

#pragma mark - event response

- (void)routerEventWithSelector:(NSString *)selector object:(id)object userInfo:(NSDictionary *)userInfo
{
    NSLog(@"\n>>>>>>\n通过UIResponder回调事件\n<<<<<<");
    NSLog(@"\n>>>>>>\nwow..., 太神奇了\n<<<<<<\n\n>>>>>>\n%@\n<<<<<<\n\n>>>>>>\n%@\n<<<<<<", object, userInfo);
}


- (OKRouteEventView *)routeEventV {
    if (!_routeEventV) {
        _routeEventV = [[OKRouteEventView alloc] initWithFrame:self.view.bounds];
    }
    return _routeEventV;
}


@end
