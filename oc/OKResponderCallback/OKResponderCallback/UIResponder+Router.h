//
//  UIResponder+Router.h
//  OKSnippet
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)

- (void)routerEventWithSelector:(NSString *)selector object:(id)object userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
