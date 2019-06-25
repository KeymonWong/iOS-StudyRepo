//
//  OKCollectionFlipPageLayout.h
//  FlipPage
//
//  Created by keymon on 2019/3/12.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OKCollectionFlipPageLayoutStyle) {
    OKCollectionFlipPageLayoutStyleNormal, ///< 普通模式,水平滑动
    OKCollectionFlipPageLayoutStyleZoom ///< 缩放模式,两边的item会小一点,逐渐向中间放大
};

@interface OKCollectionFlipPageLayout : UICollectionViewFlowLayout

- (instancetype)initWithLayoutStyle:(OKCollectionFlipPageLayoutStyle)style NS_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) OKCollectionFlipPageLayoutStyle style;

/** 超过规定滚动速度就强制翻页, 默认 0.5 */
@property (nonatomic, assign) CGFloat velocityForceFlipPage;

/** 是否允许单次滑动可以滚动多个 cell item, 默认 YES */
@property (nonatomic, assign) BOOL allowSingleScrollForMultipleItems;

/** allowSingleScrollForMultipleItems 为 YES 时, 规定的滑动速度是多少, 默认 2.5 */
@property (nonatomic, assign) CGFloat velocityOfScrollMultipleItems;

@end


@interface OKCollectionFlipPageLayout (NormalStyle)
/** 翻页的阈值, 当前cell item滚动到某个临界点时就会触发滚动到下一个cell item的动作, 默认 0.5, 即超过当前cell item 1/2 时就会滚动到下一个cell item, 相应的触发 */
@property (nonatomic, assign) CGFloat flipPageThreshold;
@end


@interface OKCollectionFlipPageLayout (ZoomStyle)
/** 显示在中间的cell item相对于初始大小的缩放倍数, 默认 1.0 */
@property (nonatomic, assign) CGFloat maxZoomScale;
/** 除了中间的cell item之外的其他cell item相对于初始大小的缩放倍数, 默认 0.7 */
@property (nonatomic, assign) CGFloat minZoomScale;
@end
