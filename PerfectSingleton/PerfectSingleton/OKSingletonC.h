//
//  OKSingletonC.h
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Macro.h"

NS_ASSUME_NONNULL_BEGIN

@interface OKSingletonC : NSObject

OK_SINGLETON_DEF(OKSingletonC);

@end

NS_ASSUME_NONNULL_END
