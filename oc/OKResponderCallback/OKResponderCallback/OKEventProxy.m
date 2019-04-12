//
//  OKEventProxy.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKEventProxy.h"

#import "OKEventName.h"

#import "OKHaveBreakfastViewController.h"
#import "OKCodeViewController.h"
#import "OKHaveLunchViewController.h"

@interface OKEventProxy ()
@property(nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;
@end

@implementation OKEventProxy

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if (eventName) {
        NSInvocation *inv = self.eventStrategy[eventName];
        [inv setArgument:&(userInfo) atIndex:2];
        [inv invoke];
    }
}

- (NSInvocation *)createInvocationWithSelector:(SEL)sel {
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:sel];
    
    if (!sig) {
        NSString *reason = [NSString stringWithFormat:@"提示：the method %@ is not find", NSStringFromSelector(sel)];
        @throw [NSException exceptionWithName:@"错误" reason:reason userInfo:nil];
    }
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    inv.target = self;
    inv.selector = sel;
    
    return inv;
}

- (void)haveBreakfastEvent:(NSDictionary *)userInfo {
    NSLog(@"\nhaveBreakfastEvent:\n%@\n", userInfo);
    
    OKHaveBreakfastViewController *jumpVC = [[OKHaveBreakfastViewController alloc] init];
    UIViewController *currentVC = userInfo[@"currentVC"];
    [currentVC.navigationController pushViewController:jumpVC animated:YES];
}

- (void)codeEvent:(NSDictionary *)userInfo {
    NSLog(@"\ncodeEvent:\n%@\n", userInfo);
    
    OKCodeViewController *jumpVC = [[OKCodeViewController alloc] init];
    UIViewController *currentVC = userInfo[@"currentVC"];
    [currentVC.navigationController pushViewController:jumpVC animated:YES];
}

- (void)haveLunchEvent:(NSDictionary *)userInfo {
    NSLog(@"\nhaveLunchEvent:\n%@\n", userInfo);
    
    OKHaveLunchViewController *jumpVC = [[OKHaveLunchViewController alloc] init];
    UIViewController *currentVC = userInfo[@"currentVC"];
    [currentVC.navigationController pushViewController:jumpVC animated:YES];
}

- (NSDictionary<NSString *,NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kHaveBreakfastName : [self createInvocationWithSelector:@selector(haveBreakfastEvent:)],
                           kCodeName : [self createInvocationWithSelector:@selector(codeEvent:)],
                           kHaveLunchName : [self createInvocationWithSelector:@selector(haveLunchEvent:)]
                           };
    }
    return _eventStrategy;
}

@end
