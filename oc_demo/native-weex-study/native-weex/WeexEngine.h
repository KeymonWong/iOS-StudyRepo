//
//  WeexEngine.h
//  native-weex
//
//  Created by keymon on 2020/3/10.
//  Copyright © 2020 okay. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeexEngine : NSObject

- (instancetype)init OBJC_UNAVAILABLE("please use '+initEngine' instead!");

+ (void)initEngine;

@end

NS_ASSUME_NONNULL_END
