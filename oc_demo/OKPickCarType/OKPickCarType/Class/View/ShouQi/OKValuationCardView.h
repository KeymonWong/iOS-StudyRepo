//
//  OKValuationCardView.h
//  OLA-iOS
//
//  Created by keymon on 2019/3/31.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKCar;

@interface OKValuationCardView : UIView

@property (nonatomic, copy) void (^didRefreshBlock)(void); ///< 刷新估价
@property (nonatomic, copy) void (^didSeeDetailBlock)(void); ///< 点击估价文本跳到估价详情

/**
 * @brief 跟据滑动配置加载动画
 * @param scrolling 是否正在滑动，YES 显示价格加载中的小动画，NO 显示价格
 */
- (void)configSwitchLoadAnimationWithScrolling:(BOOL)scrolling;

/**
 * @brief 数据未请求出来之前配置加载的view
 * @param model model
 */
- (void)configureLoadingViewWithModel:(OKCar *)model;

/**
 * @brief 滑动结束之后配置 预估价格+抵扣费用
 * @param valuation valuation
 */
- (void)configureValuation:(OKCar *)valuation;


@end

NS_ASSUME_NONNULL_END
