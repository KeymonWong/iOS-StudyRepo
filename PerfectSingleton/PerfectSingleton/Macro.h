//
//  Macro.h
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//单利定义 .h
#define OK_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+ (instancetype)alloc __attribute__((unavailable("call sharedInstance instead")));\
+ (instancetype)new __attribute__((unavailable("call sharedInstance instead")));\
- (id)copy __attribute__((unavailable("call sharedInstance instead")));\
- (id)mutableCopy __attribute__((unavailable("call sharedInstance instead")));\
//单利实现 .m
#define OK_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance {\
static _type_ *theInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theInstance = [[super alloc] init];\
});\
return theInstance;\
}

#endif /* Macro_h */
