//
//  OKEventProxy.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKEventProxy.h"

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

- (void)ticketEvent:(NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
}

- (void)serviceEvent:(NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
}

- (NSDictionary<NSString *,NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           @"ticketEvent" : [self createInvocationWithSelector:@selector(ticketEvent:)],
                           @"serviceEvent" : [self createInvocationWithSelector:@selector(serviceEvent:)]
                           };
    }
    return _eventStrategy;
}

@end
