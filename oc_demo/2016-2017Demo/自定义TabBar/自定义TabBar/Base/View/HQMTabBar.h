//
//  HQMTabBar.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQMTabBar;

@protocol HQMTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPublishBtn:(HQMTabBar *)tabBar;

@end

@interface HQMTabBar : UITabBar
@property (nonatomic, weak) id<HQMTabBarDelegate> delegate0;
@end
