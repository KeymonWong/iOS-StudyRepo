
//
//  RefreshDefault.h
//  RefreshControl
//
//  Created by 小伴 on 2017/2/21.
//  Copyright © 2017年 小伴. All rights reserved.
//

#ifndef RefreshDefault_h
#define RefreshDefault_h

typedef void(^RefreshHandler)(void);

typedef NS_ENUM(NSInteger, RefreshState) {
    RefreshStateNormal = 666,
    RefreshStateTrigger,
    RefreshStateLoading
};

#define NORMAL_TITLE    @"下拉刷新"
#define TRIGGER_TITLE   @"松开立即刷新"
#define LOADING_TITLE   @"正在刷新..."

#define gScreenWidth    [UIScreen mainScreen].bounds.size.width
#define TITLE_HEIGHT    100

#endif /* RefreshDefault_h */
