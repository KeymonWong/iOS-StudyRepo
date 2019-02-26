//
//  OKSingletonB.m
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKSingletonB.h"

@implementation OKSingletonB

+ (OKSingletonB *)sharedInstance {
    static OKSingletonB *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
    });
    return _instance;
}

/** 2.冷酷派：从OC的对象创建角度出发，就是把创建对象的各种入口给封死了。alloc，copy等等，无论是采用哪种方式创建，我都保证给出的对象是同一个。*/
//由Objective-C的一些特性可以知道，在对象创建的时候，无论是alloc还是new，都会调用到 allocWithZone方法。
//在通过拷贝的时候创建对象时，会调用到-(id)copyWithZone:(NSZone *)zone，-(id)mutableCopyWithZone:(NSZone *)zone方法。
//因此，可以重写这些方法，让创建的对象唯一。

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [OKSingletonB sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [OKSingletonB sharedInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [OKSingletonB sharedInstance];
}

@end
