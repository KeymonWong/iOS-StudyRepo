//
//  HKWaterflowView.m
//  瀑布流
//
//  Created by apple on 15/8/8.
//  Copyright (c) 2015年 Keymon. All rights reserved.
//

#import "HKWaterflowView.h"
#import "HKWaterflowViewCell.h"

#define HKWaterflowViewDefaultH 70
#define HKWaterflowViewDefaultColumns 3
#define HKWaterflowViewDefaultMargin 7

@interface HKWaterflowView ()

/**
 *  存放 cell 所有frame 的数据
 */
@property (nonatomic, strong) NSMutableArray *cellFrames;

/**
 *  正在显示的 cell
 */
@property (nonatomic, strong) NSMutableDictionary *displayingCells;

/**
 *  缓存池(用 Set,存放离开屏幕的 cell)
 */
@property (nonatomic, strong) NSMutableSet *reusableCells;


@end



@implementation HKWaterflowView

#pragma mark - 初始化
- (NSMutableArray *)cellFrames
{
    if (_cellFrames == nil) {
        self.cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}

- (NSMutableDictionary *)displayingCells
{
    if (_displayingCells == nil) {
        self.displayingCells = [NSMutableDictionary dictionary];
    }
    return _displayingCells;
}

- (NSMutableSet *)reusableCells
{
    if (_reusableCells == nil) {
        self.reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 将要显示时调用
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}

#pragma mark - 公共接口
/**
 *  cell 的宽度(瀑布流每列的宽度都一样)
 */
- (CGFloat)cellWidth
{
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    // 间距
    CGFloat leftM = [self marginForType:HKWaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:HKWaterflowViewMarginTypeRight];
    CGFloat columnM = [self marginForType:HKWaterflowViewMarginTypeColumn];
    
    // cell 的宽度
    return (self.bounds.size.width - leftM - rightM - (numberOfColumns - 1) * columnM) / numberOfColumns;
}

/**
 *  刷新数据(含补齐的算法)
 *  1.计算每一个 cell 的 frame
 */
- (void)reloadData
{
    // 清空之前所有的数据
    // 移除正在显示的 cell
    [self.displayingCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.displayingCells removeAllObjects];
    [self.cellFrames removeAllObjects];
    [self.reusableCells removeAllObjects];
    
    // cell总数
    NSUInteger numberOfCells = [self.dataSource numberOfCellsInWaterflowView:self];
    // 总列数
    NSUInteger numberOfColumns = [self numberOfColumns];
    
    // 间距
    CGFloat topM = [self marginForType:HKWaterflowViewMarginTypeTop];
    CGFloat bottomM = [self marginForType:HKWaterflowViewMarginTypeBottom];
    CGFloat leftM = [self marginForType:HKWaterflowViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:HKWaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:HKWaterflowViewMarginTypeRow];
    
    // cell 的宽度
    CGFloat cellW = [self cellWidth];
    
    // 用一个 C 语言数组存放所有列的最大 Y 值
    CGFloat maxYOfColumns[numberOfColumns];
    for (int i = 0; i < numberOfColumns; i++) {
        maxYOfColumns[i] = 0.0;
    }
    
    // 计算所有 cell 的 frame
    for (int i = 0; i < numberOfCells; i++) {
        // cell处在第几列(最短的那一列)
        NSUInteger cellColumn = 0;
        // cell 所处那列的最大 Y 值(最短那列的最大 Y 值)
        CGFloat maxYOfCellColumn = maxYOfColumns[cellColumn];
        // 求出最短的一列
        for (int j = 0; j < numberOfColumns; j++) {
            if (maxYOfColumns[j] < maxYOfCellColumn) {
                cellColumn = j;
                maxYOfCellColumn = maxYOfColumns[j];
            }
        }
        
        // 获取代理位置的高度
        CGFloat cellH = [self heightAtIndex:i];
        
        // cell的位置
        CGFloat cellX = leftM + cellColumn * (cellW + columnM);
        CGFloat cellY = 0;
        if (maxYOfCellColumn == 0.0) {  // 首行
            cellY = topM;
        } else {
            cellY = maxYOfCellColumn + rowM;
        }
       
        // 添加 frame 到数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        // 把结构体包装成 value 对象再添加
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        // 更新最短那列的最大 Y 值
        maxYOfColumns[cellColumn] = CGRectGetMaxY(cellFrame);
        
        // 显示 cell(太耗性能,必须使用cell重用机制)
//        HKWaterflowViewCell *cell = [self.dataSource waterflowView:self cellAtIndex:i];
//        cell.frame = cellFrame;
//        [self addSubview:cell];
    }
    
    // 设置 contentSize,以便滚动
    CGFloat contentH = maxYOfColumns[0];
    for (int i = 0; i < numberOfColumns; i++) {
        if (maxYOfColumns[i] > contentH) {
            contentH = maxYOfColumns[i];
        }
    }
    contentH += bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

/**
 *  当 UIScrollView 滚动的时候也会调用这个方法(特殊的地方),也就是说可以用这个方法监听 scrollView 的滚动
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%ld", self.subviews.count); // 打印出来的时候个数多两个,多的是两个滚动条
//    NSLog(@"layoutSubviews");   // 滚动时会一直打印
    
    // 向数据源索要对应位置的 cell
    NSUInteger numberOfCells = self.cellFrames.count;
    for (int i = 0; i < numberOfCells; i++) {
        // 取出 i 位置的 frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        // 优先从字典中取出 i 位置的 cell
        HKWaterflowViewCell *cell = self.displayingCells[@(i)];
        // 判断 i 位置对应的 frame 是否在屏幕上(能否看得见)
        if ([self isInScreen:cellFrame]) {  // 在屏幕上
            if (cell == nil) {
                cell = [self.dataSource waterflowView:self cellAtIndex:i];
                cell.frame = cellFrame;
                [self addSubview:cell];
                
                // 存放到字典
                self.displayingCells[@(i)] = cell;
            }
            
        } else {  // 不在屏幕上
            if (cell) {
                // 把 cell 从 scrollView 和字典中移除
                [cell removeFromSuperview];
                [self.displayingCells removeObjectForKey:@(i)];
                
                // 存放进缓存池
                [self.reusableCells addObject:cell];
            }
        }
    }
}

#pragma mark - cell重用机制
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    // 便于在 block 内部修改外部变量的值
    __block HKWaterflowViewCell *reusableCell = nil;
    
//    // reusableCells 是 set,无序的,随便取
//    cell = [self.reusableCells anyObject];
    
    // 遍历缓存池中的每一个 cell
    [self.reusableCells enumerateObjectsUsingBlock:^(HKWaterflowViewCell *cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    
    // 如果可重用的 cell 存在
    if (reusableCell) { // 必须从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    
    return reusableCell;
}

#pragma mark - 私有方法
/**
 *  判断 cell 是否显示在屏幕上
 */
- (BOOL)isInScreen:(CGRect)frame
{
    return  (self.contentOffset.y < CGRectGetMaxY(frame)) && (self.contentOffset.y + self.bounds.size.height > CGRectGetMinY(frame));
}

- (CGFloat)marginForType:(HKWaterflowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    } else {
        return HKWaterflowViewDefaultMargin;
    }
}

- (NSUInteger)numberOfColumns
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    } else {
        return HKWaterflowViewDefaultColumns;
    }
}

- (CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    } else {
        return HKWaterflowViewDefaultH;
    }
}

#pragma mark - 事件处理
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) return;
    
    // 获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSLog(@"%@", NSStringFromCGPoint(point));
    
    __block NSNumber *selectedIndex = nil;
    [self.displayingCells enumerateKeysAndObjectsUsingBlock:^(id key, HKWaterflowViewCell *cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectedIndex = key;
            *stop = YES;
        }
    }];
    
    // 如果有值,也就是把触摸到间隙的地方去除掉
    if (selectedIndex) {
        [self.delegate waterflowView:self didSelectAtIndex:[selectedIndex unsignedIntegerValue]];
    }
}

@end
