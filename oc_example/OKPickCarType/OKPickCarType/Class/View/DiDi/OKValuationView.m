//
//  OKValuationView.m
//  demo
//
//  Created by keymon on 2019/6/4.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKValuationView.h"

#import <Masonry.h>

#import "OKCarCell.h"
#import "OKCar.h"

static NSString * const kCellId = @"OKCarCell";

@interface OKValuationView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, weak) UIImageView *loadImgV;

@end

@implementation OKValuationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        self.loadImgV = imgV;
        imgV;
    })];
    
    [self.loadImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self addSubview:self.collectionView];
    self.collectionView.hidden = YES;
    
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i = 1; i <= 4; ++i) {
        UIImage *tmp = [UIImage imageNamed:[NSString stringWithFormat:@"ola_pick_car_type-Load%d", i]];
        if (tmp) {
            [imgs addObject:tmp];
        }
    }
    self.loadImgV.animationImages = [imgs copy];
    self.loadImgV.animationDuration = 1;
    self.loadImgV.animationRepeatCount = 0;
    
    [self.loadImgV startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadImgV stopAnimating];
        self.loadImgV.hidden = YES;
        self.collectionView.hidden = NO;
    });
    
    
    OKCar *tmp0 = [[OKCar alloc] init];
    tmp0.name = @"新能源 RQ";
    tmp0.price = @"约 30.10 元";
    tmp0.itemSelected = YES;
    
    OKCar *tmp1 = [[OKCar alloc] init];
    tmp1.name = @"优享";
    tmp1.price = @"约 40.50 元";
    
    OKCar *tmp2 = [[OKCar alloc] init];
    tmp2.name = @"拼车";
    tmp2.price = @"约 20.25 元";
    
    OKCar *tmp3 = [[OKCar alloc] init];
    tmp3.name = @"哈哈哈";
    tmp3.price = @"约 10.25 元";
    
    self.datas = @[tmp0, tmp1, tmp2, tmp3];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.datas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKCarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if (indexPath.item < self.datas.count) {
        OKCar *car = self.datas[indexPath.item];
        [cell configureCellModel:car];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    OKCar *tmp = self.datas[indexPath.item];
    OKCarCell *cell = (OKCarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (tmp.isItemSelected) {
        // 可以做其他跳转的
        !self.didPickCar ?: self.didPickCar(tmp);
    } else {
        tmp.itemSelected = YES;
        for (OKCar *c in self.datas) {
            if (c != tmp) {
                c.itemSelected = NO;
            }
        }
        
        [collectionView reloadData];
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize size = CGSizeMake(140, 140);
    
    CGSize size = CGSizeMake(collectionView.frame.size.width / 3, 140);
    
    return size;
}

//- (BOOL)collectionView:(UICollectionView *)collectionView canFocusItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 140) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[OKCarCell class] forCellWithReuseIdentifier:kCellId];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 6, 0, 6);
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

@end
