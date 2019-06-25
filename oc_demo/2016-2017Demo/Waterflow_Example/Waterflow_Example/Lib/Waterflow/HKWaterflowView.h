//
//  HKWaterflowView.h
//  瀑布流
//
//  Created by apple on 15/8/8.
//  Copyright (c) 2015年 Keymon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HKWaterflowViewMarginTypeTop,
    HKWaterflowViewMarginTypeBottom,
    HKWaterflowViewMarginTypeLeft,
    HKWaterflowViewMarginTypeRight,
    HKWaterflowViewMarginTypeColumn,  // 每一列
    HKWaterflowViewMarginTypeRow  // 每一行
} HKWaterflowViewMarginType;


@class HKWaterflowView, HKWaterflowViewCell;

#pragma mark - 数据源
@protocol HKWaterflowViewDataSource <NSObject>
@required
/**
 *  一共有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(HKWaterflowView *)waterflowView;

/**
 *  返回 index 位置对应的 cell
 */
- (HKWaterflowViewCell *)waterflowView:(HKWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(HKWaterflowView *)waterflowView;

@end

#pragma mark - 代理
@protocol HKWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  index 位置对应的高度
 */
- (CGFloat)waterflowView:(HKWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;

/**
 *  选中第 index 位置的 cell
 */
- (void)waterflowView:(HKWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;

/**
 *  返回间距
 */
- (CGFloat)waterflowView:(HKWaterflowView *)waterflowView marginForType:(HKWaterflowViewMarginType)type;

@end


@interface HKWaterflowView : UIScrollView

/**
 *  数据源
 */
@property (nonatomic, weak) id<HKWaterflowViewDataSource> dataSource;

/**
 *  代理
 */
@property (nonatomic, weak) id<HKWaterflowViewDelegate> delegate;

/**
 *  刷新数据(只要调用这个方法,会重新向数据源和代理发送请求,请求数据)
 */
- (void)reloadData;

/**
 *  根据标识去缓存池查找可循环利用的 cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 *  cell 的宽度(瀑布流每列的宽度都一样)
 */
- (CGFloat)cellWidth;

@end
