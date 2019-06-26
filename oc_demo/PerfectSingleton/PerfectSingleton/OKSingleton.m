//
//  OKSingleton.m
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKSingleton.h"

@implementation OKSingleton

+ (instancetype)sharedInstance {
    static OKSingleton *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super alloc] init];
    });
    return _instance;
}

@end
