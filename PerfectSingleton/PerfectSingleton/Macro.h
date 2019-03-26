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
#define OK_SINGLETON_DEF(_type_) + (instancetype)sharedInstance;\
+ (instancetype)alloc __attribute__((unavailable("call sharedInstance instead")));\
+ (instancetype)new __attribute__((unavailable("call sharedInstance instead")));\
- (id)copy __attribute__((unavailable("call sharedInstance instead")));\
- (id)mutableCopy __attribute__((unavailable("call sharedInstance instead")));\
//单利实现 .m
#define OK_SINGLETON_IMP(_type_) + (instancetype)sharedInstance {\
static _type_ *_instance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[super alloc] init];\
});\
return _instance;\
}

#endif /* Macro_h */
