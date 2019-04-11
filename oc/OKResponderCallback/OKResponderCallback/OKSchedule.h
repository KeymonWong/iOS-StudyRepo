//
//  OKSchedule.h
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKSchedule : NSObject

- (void)doWithTime:(NSString *)time userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
