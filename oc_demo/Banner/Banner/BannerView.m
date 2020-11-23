//
//  BannerView.m
//  Banner
//
//  Created by hqm on 2020/11/9.
//

#import "BannerView.h"

static NSString * const kCellId = @"BannerCell";

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BannerView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionV;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) BOOL isFirst;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL isDraging;
@end


@implementation BannerView

- (instancetype)init {
    return [self initWithFrame:(CGRect){{0, 0}, CGSizeZero}];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        /**
         * 实际数据为 red|green|blue
         * 若实现无限轮播 则数据为 blue|red|green|blue|red
         * 多2个 原数据源首尾填充尾首数据 组成新的轮播数据源
         * 新的轮播数据源如下图，最上面为index、最下面width代表每个item宽
         *
         *  |    0    |    1    |    2    |    3    |    4    |
         *  ---------------------------------------------------
         *  |         |         |         |         |         |
         *  |   blue  |   red   |  green  |   blue  |   red   |
         *  |         |         |         |         |         |
         *  ---------------------------------------------------
         *  |  width  |         要展示的数据          |  width  |
         *
         */
        
        self.datas = @[
            [UIColor blueColor],
            [UIColor redColor],
            [UIColor greenColor],
            [UIColor blueColor],
            [UIColor redColor]
        ];
        
        [self makeSubviews];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self beginTimer];
        });
    }
    return self;
}

- (void)makeSubviews {
    self.collectionV.frame = self.bounds;
    [self addSubview:self.collectionV];
    
    if (self.datas.count) {
        self.isFirst = YES;
        [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]
                                 atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                         animated:NO];
    }
}

- (void)handleAutoScroll {
    if (self.datas.count == 0) {
        return;
    }
    
    NSUInteger curRow = (NSUInteger)(self.collectionV.contentOffset.x / self.itemSize.width);
//    if (curRow == self.datas.count - 1) {
//        [self.collectionV scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
//                                            animated:NO];
//        return;
//    }
    
    NSInteger newRow = curRow + 1;
    
//    NSIndexPath *currentIndexPath = [[self.collectionV indexPathsForVisibleItems] lastObject];
    
//    NSInteger newRow  = (currentIndexPath.row + 1) % self.datas.count;
    
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:newRow inSection:0];
    
    [self.collectionV scrollToItemAtIndexPath:newIndexPath
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
    self.isDraging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidScroll：%f", scrollView.contentOffset.x);
    
    if (self.isFirst) {
        self.isFirst = NO;
        return;
    }

    //计算偏移量所对应的页数
    int page = scrollView.contentOffset.x / self.itemSize.width;
    CGFloat ratio = scrollView.contentOffset.x/self.itemSize.width;
    NSLog(@"%d========%f",page,scrollView.contentOffset.x / self.itemSize.width);

    if (page == 0 && scrollView.contentOffset.x <= 0) {
        //此时应滚到最后一页
        //重新设置偏移量
//        scrollView.contentOffset = CGPointMake(self.itemSize.width * self.datas.count, 0);

        //可以用这句代替上一句重新设置偏移量
        //可以将animated改成YES体验一下效果
        [scrollView setContentOffset:CGPointMake(self.itemSize.width * (self.datas.count-2)+30, 0) animated:NO];
    }
    else if (page == 4 && scrollView.contentOffset.x >= 1380 + 30){
        NSLog(@"page=4-----===%f", scrollView.contentOffset.x);
        //此时应滚到第一页
        scrollView.contentOffset = CGPointMake(self.itemSize.width+self.flowLayout.minimumLineSpacing*0.5, 0);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
      //两秒之后重新启动定时器
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(beginTimer) object:nil];
    [self performSelector:@selector(beginTimer) withObject:nil afterDelay:2];
}

- (void)beginTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self handleAutoScroll];
    }];
    self.timer = timer;
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //在datas中，有n+2个对象，因此index取offset.x/width后的整数
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    
//    if (indexPath.row < self.datas.count + 2) {
//        if (indexPath.row == 0) {
//            cell.backgroundColor = self.datas[self.datas.count-1];
//        } else if (indexPath.row == self.datas.count+1) {
//            cell.backgroundColor = self.datas[0];
//        } else {
//            NSInteger index = indexPath.row % self.datas.count;
            cell.backgroundColor = self.datas[indexPath.row];
//        }
//    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat width = collectionView.frame.size.width - layout.sectionInset.left * 2 - layout.minimumLineSpacing;
    self.itemSize = CGSizeMake(width, collectionView.frame.size.height);
    return CGSizeMake(width, collectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
}

- (UICollectionView *)collectionV {
    if (!_collectionV) {
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionV.backgroundColor = [UIColor grayColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.showsHorizontalScrollIndicator = NO;
        _collectionV.showsVerticalScrollIndicator = NO;
//        _collectionV.bounces = NO;
        [_collectionV registerClass:[BannerCell class] forCellWithReuseIdentifier:kCellId];
        
//        UIView *v = [[UIView alloc] init];
//        v.backgroundColor = [UIColor systemPurpleColor];
//        _collectionV.backgroundView = v;
    }
    return  _collectionV;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        _flowLayout.minimumLineSpacing = 10;
    }
    return _flowLayout;
}

@end


@interface BannerCell ()
@property (nonatomic, strong) UIImageView *imageV;
@end

@implementation BannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSubviews];
    }
    return self;
}

- (void)makeSubviews {
    self.imageV.frame = self.bounds;
    [self.contentView addSubview:self.imageV];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageV.image = [UIImage imageNamed:imageName];
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageV;
}


@end
