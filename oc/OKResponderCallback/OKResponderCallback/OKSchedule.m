//
//  OKSchedule.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKSchedule.h"

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

#pragma mark -

- (void)haveBreakfast:(NSDictionary *)useInfo {
    NSLog(@"早餐");
}

- (void)code:(NSDictionary *)useInfo {
    NSLog(@"写代码-%@", useInfo);
}

- (void)haveLunch:(NSDictionary *)useInfo {
    NSLog(@"午饭");
}

- (void)haveRest:(NSDictionary *)useInfo {
    NSLog(@"午休");
}

- (void)paint:(NSDictionary *)useInfo {
    NSLog(@"绘画");
}

#pragma mark - lazy load

- (NSDictionary *)strategy {
    if (!_strategy) {
        _strategy = @{
                      @"8:30-9:00": [self createInvocationWithSelector:@selector(haveBreakfast:)],
                      @"9:10-11:30": [self createInvocationWithSelector:@selector(code:)],
                      @"12:00-13:00": [self createInvocationWithSelector:@selector(haveLunch:)],
                      @"13:20-14:00": [self createInvocationWithSelector:@selector(haveRest:)],
                      @"14:10-15:30": [self createInvocationWithSelector:@selector(paint:)]
                      };
    }
    return _strategy;
}

@end
