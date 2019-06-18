//
//  OKCollectionFlipPageLayout.m
//  FlipPage
//
//  Created by keymon on 2019/3/12.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKCollectionFlipPageLayout.h"

@interface OKCollectionFlipPageLayout ()
{
    CGFloat _maxZoomScale;
    CGFloat _minZoomScale;
    CGFloat _flipPageThreshold;
    CGSize _finalCellItemSize;
}
@end

@implementation OKCollectionFlipPageLayout

- (instancetype)init {
    return [self initWithLayoutStyle:OKCollectionFlipPageLayoutStyleNormal];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self init];
}

- (instancetype)initWithLayoutStyle:(OKCollectionFlipPageLayoutStyle)style {
    if (self = [super init]) {
        _style = style;
        self.velocityForceFlipPage = 0.5;
        self.allowSingleScrollForMultipleItems = YES;
        self.velocityOfScrollMultipleItems = 2.5;
        
        self.flipPageThreshold = 1.0 / 2.0;
        self.maxZoomScale = 1.0;
        self.minZoomScale = 0.7;
        
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/**
 * 用来做布局的初始化操作（不建议在init方法中进行布局的初始化操作）
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    CGSize itemSize = self.itemSize;
    id<UICollectionViewDelegateFlowLayout> layoutDelegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    if ([layoutDelegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        itemSize = [layoutDelegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    }
    _finalCellItemSize = itemSize;
}

/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会按顺序重新调用下面的方法：
 * 1. prepareLayout
 * 2. layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (self.style == OKCollectionFlipPageLayoutStyleZoom) {
        return YES;
    }
    //新size和旧size不一样，就会触发重新查询布局信息
    return !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);
}

/**
 * 这个方法的返回值是一个数组（数组里面存放着rect范围内所有元素的布局属性）
 * 这个方法的返回值决定了rect范围内所有元素的排布（frame）
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    if (self.style == OKCollectionFlipPageLayoutStyleNormal) {
        return [super layoutAttributesForElementsInRect:rect];
    }
    
    NSArray<UICollectionViewLayoutAttributes *> *layoutResultAttrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    //当前滚动位置的可视区域的水平中间位置，即collectionView水平中间位置
    CGFloat midX = CGRectGetMidX(self.collectionView.bounds);
    //计算collectionView最中心点的x值
//    CGFloat midX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGSize itemSize = _finalCellItemSize;
    
    if (self.style == OKCollectionFlipPageLayoutStyleZoom) {
        CGFloat offsetForMinZoomItem = itemSize.width + self.minimumInteritemSpacing;
        CGFloat offsetForMaxZoomItem = 0.0;

        /**
         * UICollectionViewLayoutAttributes *attrs;
         * 1. 一个cell对应一个UICollectionViewLayoutAttributes对象
         * 2. UICollectionViewLayoutAttributes对象决定了cell的frame
         */
        //遍历所有cell item的属性，在原有布局属性的基础上，进行微调
        for (UICollectionViewLayoutAttributes *tmp in layoutResultAttrs) {
            CGFloat scale = 0.0;
            //当滑动时计算，collectionView的水平中间位置距离每个cell item自己的水平中间位置的距离
            //cell的中心点 x 和 collectionView最中心点的x值的间距
            CGFloat distance = ABS(midX - tmp.center.x);
            if (distance >= offsetForMinZoomItem) {
                scale = self.minZoomScale;
            } else if (distance == offsetForMaxZoomItem) {
                scale = self.maxZoomScale;
            } else {
                scale = self.minZoomScale + (offsetForMinZoomItem - distance) * (self.maxZoomScale - self.minZoomScale) / (offsetForMinZoomItem - offsetForMaxZoomItem);
            }
            //cell item 的背景alpha
            tmp.alpha = (scale == 1.0) ? scale : fabs(scale - 0.1);
//            tmp.transform = CGAffineTransformMakeScale(scale, scale);
            //缩放不会改变frame大小
            tmp.transform3D = CATransform3DMakeScale(scale, scale, 1);
            tmp.zIndex = 1;
        }
        
        return layoutResultAttrs;
    }
    
    return layoutResultAttrs;
}

/**
 * 返回值决定了collectionView停止滚动时最终的偏移量（contentOffset）
 * proposedContentOffset：collectionView停止滚动时最终的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat cellSpacing = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal ? _finalCellItemSize.width : _finalCellItemSize.height) + self.minimumLineSpacing;
    CGSize contentSize = self.collectionViewContentSize;
    CGSize frameSize = self.collectionView.bounds.size;
    UIEdgeInsets contentInsets = self.collectionView.contentInset;
    if (@available(iOS 11.0, *)) {
        contentInsets = self.collectionView.adjustedContentInset;
    }
    
    BOOL scrollingToRight = proposedContentOffset.x < self.collectionView.contentOffset.x;
    BOOL scrollingToBottom = proposedContentOffset.y < self.collectionView.contentOffset.y;
    BOOL forceFlipPage = NO;
    
    CGPoint translation = [self.collectionView.panGestureRecognizer translationInView:self.collectionView];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        /**
         * allowSingleScrollForMultipleItems    velocityOfScrollMultipleItems
         *                  YES                        velocity.x <= 2.5 (支持滚动多个cell，但是速度不足以滚动多个)
         *                  YES                        velocity.x > 2.5 (支持滚动多个cell，速度足以滚动多个)
         *                  NO                         velocity.x <= 2.5 (无效)
         *                  NO                         velocity.x > 2.5 (无效)
         */
        // 当 allowSingleScrollForMultipleItems 为 NO 时，不管滚动速度velocity.x是多少，都是一次只能滚动一个cell item
        // 当 allowSingleScrollForMultipleItems 为 YES 时，只有 velocity.x 小于等于 2.5，才认为是一次只能滚动一个cell item
        if (!self.allowSingleScrollForMultipleItems || ABS(velocity.x) <= ABS(self.velocityOfScrollMultipleItems)) {
            // 一次性滚多次的本质是系统根据速度算出来的 proposedContentOffset 可能比当前 contentOffset 大很多，
            // 所以这里既然限制了一次只能滚一页，那就直接取瞬时 contentOffset 即可。
            proposedContentOffset = self.collectionView.contentOffset;
            
            // 只支持滚动一页 或者 支持滚动多页但是速度不够滚动多页，当滚动速度超过某一个值 就强制翻页
            if (ABS(velocity.x) > self.velocityForceFlipPage) {
                forceFlipPage = YES;
            }
        }
        
        // 滚动到最左/最右边时
        if (proposedContentOffset.x < -contentInsets.left || proposedContentOffset.x >= contentSize.width + contentInsets.right - frameSize.width) {
            if (@available (iOS 10.0, *)) {
                
            } else {
                // iOS 10 及以上的版本，直接返回当前的 contentOffset，系统会自动帮你调整到边界状态，而 iOS 9 及以下的版本需要自己计算
                proposedContentOffset.x = MIN(MAX(proposedContentOffset.x, -contentInsets.left), contentSize.width + contentInsets.right - frameSize.width);
            }
            return proposedContentOffset;
        }
        
        CGFloat progress = (contentInsets.left + proposedContentOffset.x + _finalCellItemSize.width / 2) / cellSpacing;
        NSInteger currentIndex = (NSInteger)progress;
        NSInteger targetIndex = currentIndex;
        
        // 加上下面这两个额外的 if 判断是为了避免那种“从0滚到1的左边 1/3，松手后反而会滚回0”的 bug
        if (translation.x < 0 && (ABS(translation.x) > _finalCellItemSize.width / 2 + self.minimumLineSpacing)) {
        } else if (translation.x > 0 && ABS(translation.x > _finalCellItemSize.width / 2)) {
        } else {
            CGFloat remain = progress - currentIndex;
            CGFloat offset = remain * cellSpacing;
            BOOL shouldNext = (forceFlipPage && !scrollingToRight) ? YES : (offset / _finalCellItemSize.width >= self.flipPageThreshold);
            BOOL shouldPrev = (forceFlipPage && scrollingToRight) ? YES  : (offset / _finalCellItemSize.width <= 1 - self.flipPageThreshold);
            targetIndex = currentIndex + (shouldNext ? 1 : (shouldPrev ? -1 : 0));
        }
        proposedContentOffset.x = -contentInsets.left + targetIndex * cellSpacing;
    }
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        /**
         * allowSingleScrollForMultipleItems    velocityOfScrollMultipleItems
         *                  YES                        velocity.y <= 2.5 (支持滚动多个cell，但是速度不足以滚动多个)
         *                  YES                        velocity.y > 2.5 (支持滚动多个cell，速度足以滚动多个)
         *                  NO                         velocity.y <= 2.5 (无效)
         *                  NO                         velocity.y > 2.5 (无效)
         */
        // 当 allowSingleScrollForMultipleItems 为 NO 时，不管滚动速度velocity.y是多少，都是一次只能滚动一个cell item
        // 当 allowSingleScrollForMultipleItems 为 YES 时，只有 velocity.y 小于等于 2.5，才认为是一次只能滚动一个cell item
        if (!self.allowSingleScrollForMultipleItems || ABS(velocity.y) <= ABS(self.velocityOfScrollMultipleItems)) {
            // 一次性滚多次的本质是系统根据速度算出来的 proposedContentOffset 可能比当前 contentOffset 大很多，
            // 所以这里既然限制了一次只能滚一页，那就直接取瞬时 contentOffset 即可。
            proposedContentOffset = self.collectionView.contentOffset;
            
            // 只支持滚动一页 或者 支持滚动多页但是速度不够滚动多页，当滚动速度超过某一个值 就强制翻页
            if (ABS(velocity.y) > ABS(self.velocityForceFlipPage)) {
                forceFlipPage = YES;
            }
        }
        
        // 滚动到最左/最右边时
        if (proposedContentOffset.y < -contentInsets.top || proposedContentOffset.y >= contentSize.height + contentInsets.top - frameSize.height) {
            if (@available (iOS 10.0, *)) {
                
            } else {
                // iOS 10 及以上的版本，直接返回当前的 contentOffset，系统会自动帮你调整到边界状态，而 iOS 9 及以下的版本需要自己计算
                proposedContentOffset.y = MIN(MAX(proposedContentOffset.y, -contentInsets.top), contentSize.height + contentInsets.top - frameSize.height);
            }
            return proposedContentOffset;
        }
        
        CGFloat progress = (contentInsets.top + proposedContentOffset.y + _finalCellItemSize.height / 2) / cellSpacing;
        NSInteger currentIndex = (NSInteger)progress;
        NSInteger targetIndex = currentIndex;
        
        // 加上下面这两个额外的 if 判断是为了避免那种“从0滚到1的左边 1/3，松手后反而会滚回0”的 bug
        if (translation.y < 0 && (ABS(translation.y) > _finalCellItemSize.height / 2 + self.minimumLineSpacing)) {
        } else if (translation.y > 0 && ABS(translation.y > _finalCellItemSize.height / 2)) {
        } else {
            CGFloat remain = progress - currentIndex;
            CGFloat offset = remain * cellSpacing;
            BOOL shouldNext = (forceFlipPage && !scrollingToBottom) ? YES : (offset / _finalCellItemSize.height >= self.flipPageThreshold);
            BOOL shouldPrev = (forceFlipPage && scrollingToBottom) ? YES  : (offset / _finalCellItemSize.height <= 1 - self.flipPageThreshold);
            targetIndex = currentIndex + (shouldNext ? 1 : (shouldPrev ? -1 : 0));
        }
        proposedContentOffset.y = -contentInsets.top + targetIndex * cellSpacing;
    }
    
    
    return proposedContentOffset;
}

@end


@implementation OKCollectionFlipPageLayout (NormalStyle)

- (void)setFlipPageThreshold:(CGFloat)flipPageThreshold {
    _flipPageThreshold = flipPageThreshold;
}

- (CGFloat)flipPageThreshold {
    return _flipPageThreshold;
}

@end


@implementation OKCollectionFlipPageLayout (ZoomStyle)

- (void)setMaxZoomScale:(CGFloat)maxZoomScale {
    _maxZoomScale = maxZoomScale;
}

- (CGFloat)maxZoomScale {
    return _maxZoomScale;
}

- (void)setMinZoomScale:(CGFloat)minZoomScale {
    _minZoomScale = minZoomScale;
}

- (CGFloat)minZoomScale {
    return _minZoomScale;
}

@end
