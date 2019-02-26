//
//  OKSingleton.h
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKSingleton : NSObject

+ (OKSingleton *)sharedInstance;

/** 1.温柔派：直接告诉外面，alloc，new，copy，mutableCopy方法不可以直接调用。否则编译不过 */
+ (instancetype)alloc OBJC_UNAVAILABLE("call sharedInstance instead");
+ (instancetype)new OBJC_UNAVAILABLE("call sharedInstance instead");
- (id)copy OBJC_UNAVAILABLE("call sharedInstance instead");
- (id)mutableCopy OBJC_UNAVAILABLE("call sharedInstance instead");

@end

NS_ASSUME_NONNULL_END
