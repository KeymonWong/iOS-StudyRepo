//
//  OKPickCarTypeCardView.h
//  OLA-iOS
//
//  Created by keymon on 2019/3/30.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKPickCarTypeCardView, OKCar, OLAValuation;

@protocol OKPickCarTypeCardViewDelegate <NSObject>

@optional
- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView didSelectItem:(OKCar *)item;

- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView
        didEndScrollToIndex:(NSInteger)index
                  withModel:(OKCar *)model;

/**
 * @brief 滑动
 * @param carTypeView view
 * @param isScrolling 是否正在滑动，YES 显示价格加载中的小动画，NO 显示价格
 */
- (void)pickCarTypeCardView:(OKPickCarTypeCardView *)carTypeView
                isScrolling:(BOOL)isScrolling;

@end

@interface OKPickCarTypeCardView : UIView

@property (nonatomic, weak) id<OKPickCarTypeCardViewDelegate> delegate;

@property (nonatomic, copy) NSArray<OKCar *> *models;

/** 可以调用此方法手动控制滚动到哪一个index */
- (void)makeCellScrollToIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
