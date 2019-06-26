//
//  UIView+Overlap.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "UIView+Overlap.h"

@implementation UIView (Overlap)
- (BOOL)is_intersectsWithAnotherView:(UIView *)anotherView {
    //如果anotherView为nil，那么就代表keyWindow
    if (anotherView == nil) {
        anotherView = [UIApplication sharedApplication].keyWindow;
    }

    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect anotherRect = [anotherView convertRect:anotherView.bounds toView:nil];
    //CGRectIntersectsRect是否有交叉
    BOOL intersect = CGRectIntersectsRect(selfRect, anotherRect);

    return intersect;
}
@end
