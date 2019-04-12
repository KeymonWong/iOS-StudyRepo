//
//  OKEventProxy.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKEventProxy.h"

#import "OKEventName.h"

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
}

- (void)codeEvent:(NSDictionary *)userInfo {
    NSLog(@"\ncodeEvent:\n%@\n", userInfo);
}

- (NSDictionary<NSString *,NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kHaveBreakfastName : [self createInvocationWithSelector:@selector(haveBreakfastEvent:)],
                           kCodeName : [self createInvocationWithSelector:@selector(codeEvent:)]
                           };
    }
    return _eventStrategy;
}

@end
