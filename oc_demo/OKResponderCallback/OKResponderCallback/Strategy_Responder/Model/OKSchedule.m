//
//  OKSchedule.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKSchedule.h"

#import "OKEventName.h"

@interface OKSchedule ()
@property(nonatomic, strong) NSDictionary *strategy;
@end

@implementation OKSchedule

- (void)doWithTime:(NSString *)time userInfo:(NSDictionary *)userInfo
{
    if (self.strategy[time]) {
        NSInvocation *doWhat = self.strategy[time];
        // index表示第几个参数,注意0和1已经被占用了(self和_cmd),所以我们传递参数的时候要从2开始.
        [doWhat setArgument:&(userInfo) atIndex:2];
        [doWhat invoke];
    }
    else {
        NSLog(@"nothing to do");
    }
}

- (NSInvocation *)createInvocationWithSelector:(SEL)sel {
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:sel];
    
    if (!sig) {
        NSString *reson = [NSString stringWithFormat:@"提示：The method %@ is not find", NSStringFromSelector(sel)];
        @throw [NSException exceptionWithName:@"错误" reason:reson userInfo:nil];
    }
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
    inv.target = self;
    inv.selector = sel;
    
    return inv;
}

#pragma mark - 统一管理事件交互

- (void)haveBreakfast:(NSDictionary *)useInfo {
    NSLog(@"\n早餐\n");
}

- (void)code:(NSDictionary *)useInfo {
    NSLog(@"\n写代码-\n%@\n", useInfo);
}

- (void)haveLunch:(NSDictionary *)useInfo {
    NSLog(@"\n午饭\n");
}

- (void)haveRest:(NSDictionary *)useInfo {
    NSLog(@"\n午休\n");
}

- (void)paint:(NSDictionary *)useInfo {
    NSLog(@"\n绘画\n");
}

#pragma mark - lazy load

- (NSDictionary *)strategy {
    if (!_strategy) {
        _strategy = @{
                      kHaveBreakfastName : [self createInvocationWithSelector:@selector(haveBreakfast:)],
                      kCodeName : [self createInvocationWithSelector:@selector(code:)],
                      kHaveLunchName : [self createInvocationWithSelector:@selector(haveLunch:)],
                      kHaveRestName : [self createInvocationWithSelector:@selector(haveRest:)],
                      kPaintName : [self createInvocationWithSelector:@selector(paint:)]
                      };
    }
    return _strategy;
}

@end
