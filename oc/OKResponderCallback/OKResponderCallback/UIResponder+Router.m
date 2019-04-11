//
//  UIResponder+Router.m
//  OKSnippet
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithSelector:(NSString *)selector object:(id)object userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithSelector:selector object:object userInfo:userInfo];
}

@end
