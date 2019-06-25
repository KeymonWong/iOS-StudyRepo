//
//  UITableView+Associated.m
//  RefreshControl
//
//  Created by 小伴 on 2017/2/22.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "UITableView+Associated.h"
#import <objc/runtime.h>
#import "RefreshView.h"

const void * refresh_header_key = @"refresh_header_key";

@implementation UITableView (Associated)

- (void)setRefreshView:(RefreshView *)refreshView {
    id refreshHeader = [self refreshView];
    if (refreshHeader) {
        [refreshHeader removeFromSuperview];
    }

    if (refreshView) {
        [self addSubview:refreshView];
    }

    objc_setAssociatedObject(self, refresh_header_key, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RefreshView *)refreshView {
    return objc_getAssociatedObject(self, refresh_header_key);
}

@end
