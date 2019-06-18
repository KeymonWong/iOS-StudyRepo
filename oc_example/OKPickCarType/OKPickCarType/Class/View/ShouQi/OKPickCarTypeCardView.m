//
//  OKPickCarTypeCardView.m
//  OLA-iOS
//
//  Created by keymon on 2019/3/30.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKPickCarTypeCardView.h"
#import "OKPickCarTypeCell.h"
#import "OKCollectionFlipPageLayout.h"
#import "OKCar.h"

@interface OKPickCarTypeCardView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) OKCollectionFlipPageLayout *flipPageLayout;
@property (nonatomic, assign) NSInteger currentIdx;
@end

@implementation OKPickCarTypeCardView

#pragma mark - life circle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.collectionV];
    
    //每一个 section 与周边的间距
    self.flipPageLayout.sectionInset = UIEdgeInsetsMake(0, 100, 0, 100);
    //水平滚动时，为同一个section内部item之间的水平方向间隙
    self.flipPageLayout.minimumLineSpacing = 25;
    //水平滚动时，为同一个section内部item之间的竖直方向间隙
    self.flipPageLayout.minimumInteritemSpacing = 0;
}

- (void)setModels:(NSArray *)models {
    _models = models;
    self.currentIdx = 0;
    
    self.collectionV.contentOffset = CGPointZero;
    
    [self.collectionV reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!CGSizeEqualToSize(self.collectionV.frame.size, self.bounds.size)) {
        self.collectionV.frame = self.bounds;
        
        /** 在collectionView 布局发生改变时 下述好像无效果 */
        //每一个 section 与周边的间距
        self.flipPageLayout.sectionInset = UIEdgeInsetsMake(0, 100, 0, 100);
        //水平滚动时，为同一个section内部item之间的水平方向间隙
        self.flipPageLayout.minimumLineSpacing = 25;
        //水平滚动时，为同一个section内部item之间的竖直方向间隙
        self.flipPageLayout.minimumInteritemSpacing = 0;
        [self.flipPageLayout invalidateLayout];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKPickCarTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([OKPickCarTypeCell class]) forIndexPath:indexPath];
    
    [cell configureCellWithModel:self.models[indexPath.item]];
//    [cell setNeedsLayout];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickCarTypeCardView:didSelectItem:)]) {
        [self.delegate pickCarTypeCardView:self didSelectItem:self.models[indexPath.item]];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 当前cell item下标等于当前记录的下标时，让该cell item可选择，否则不可点击
    if (indexPath.item == self.currentIdx) {
        return YES;
    }
    return NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets contentInsets = collectionView.contentInset;
    
    CGSize size = CGSizeMake(collectionView.frame.size.width - self.flipPageLayout.sectionInset.left - self.flipPageLayout.sectionInset.right - contentInsets.left - contentInsets.right, collectionView.frame.size.height - self.flipPageLayout.sectionInset.top - self.flipPageLayout.sectionInset.bottom - contentInsets.top - contentInsets.bottom);
    
    return size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.x);
    // 有数据情况下
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickCarTypeCardView:isScrolling:)]) {
        [self.delegate pickCarTypeCardView:self isScrolling:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:self.collectionV];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    self.currentIdx = [self getCurrentCellIndex];
    
    NSLog(@"%ld===%ld", (long)self.currentIdx, (long)[self getCurrentCellIndex]);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickCarTypeCardView:isScrolling:)]) {
        [self.delegate pickCarTypeCardView:self isScrolling:NO];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickCarTypeCardView:didEndScrollToIndex:withModel:)]) {
        [self.delegate pickCarTypeCardView:self
                       didEndScrollToIndex:self.currentIdx
                                 withModel:self.models[self.currentIdx]];
    }
}

- (NSInteger)getCurrentCellIndex {
    if (self.collectionV.frame.size.width == 0 || self.collectionV.frame.size.height == 0) {
        return 0;
    }
    
    double index = 0;
    
    UIEdgeInsets contentInsets = self.collectionV.contentInset;
    
    CGFloat itemW = CGRectGetWidth(self.collectionV.bounds) - self.flipPageLayout.sectionInset.left - self.flipPageLayout.sectionInset.right - contentInsets.left - contentInsets.right;
    CGFloat itemH = CGRectGetHeight(self.collectionV.bounds) - self.flipPageLayout.sectionInset.top - self.flipPageLayout.sectionInset.bottom - contentInsets.top - contentInsets.bottom;
    
    if (self.flipPageLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
//        index = (self.collectionV.contentOffset.x + itemW * 0.5) / itemW;
        index = self.collectionV.contentOffset.x / (itemW + self.flipPageLayout.minimumLineSpacing);
    } else {
//        index = (self.collectionV.contentOffset.y + itemH * 0.5) / itemH;
        index = self.collectionV.contentOffset.y / (itemH + self.flipPageLayout.minimumLineSpacing);
    }
    
    return round(index);
}

- (void)makeCellScrollToIndex:(NSInteger)index {
    self.currentIdx = index;
    
    [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickCarTypeCardView:isScrolling:)]) {
        [self.delegate pickCarTypeCardView:self isScrolling:NO];
    }
}

#pragma mark - lazy load

- (UICollectionView *)collectionV {
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flipPageLayout];
        _collectionV.backgroundColor = [UIColor whiteColor];
        _collectionV.showsVerticalScrollIndicator = NO;
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        [_collectionV registerClass:[OKPickCarTypeCell class] forCellWithReuseIdentifier:NSStringFromClass([OKPickCarTypeCell class])];
    }
    return _collectionV;
}

- (OKCollectionFlipPageLayout *)flipPageLayout {
    if (!_flipPageLayout) {
        _flipPageLayout = [[OKCollectionFlipPageLayout alloc] initWithLayoutStyle:OKCollectionFlipPageLayoutStyleZoom];
    }
    return _flipPageLayout;
}

@end
