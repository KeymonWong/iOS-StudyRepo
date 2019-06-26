//
//  HQMPerson.m
//  objc-KVO
//
//  Created by 小伴 on 16/6/29.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMPerson.h"

@implementation HQMPerson

- (void)willChangeValueForKey:(NSString *)key {
    NSLog(@"\n%@", NSStringFromSelector(_cmd));
    [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"\n%@", NSStringFromSelector(_cmd));
    [super didChangeValueForKey:key];
}

@end
