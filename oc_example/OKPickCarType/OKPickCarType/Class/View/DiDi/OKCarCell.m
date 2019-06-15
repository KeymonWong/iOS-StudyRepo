//
//  OKCarCell.m
//  demo
//
//  Created by keymon on 2019/6/4.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKCarCell.h"

#import <Masonry.h>
#import "OKCar.h"

@interface OKCarCell ()
@property (nonatomic, weak) UIImageView *carImgV;
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *priceL;
@property (nonatomic, weak) UIView *indicatorV;
@property (nonatomic, weak) UIView *cV;
@end

@implementation OKCarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        [self setupViews];
        [self makeLayout];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"ole_icon_carpool"];
        self.carImgV = imgV;
        imgV;
    })];
    
    [self.contentView addSubview:({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"新能源RQ";
        label.font = [UIFont boldSystemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        self.titleL = label;
        label;
    })];
    
    [self.contentView addSubview:({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"50.00 元";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        self.priceL = label;
        label;
    })];
    
    [self.contentView addSubview:({
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor clearColor];
        self.cV = v;
        v;
    })];
    
    [self.cV addSubview:({
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor orangeColor];
        self.indicatorV = v;
        v;
    })];
    
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

- (void)makeLayout {
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    CGSize size = self.carImgV.image.size;
    [self.carImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(20);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(size);
    }];
    
    [self.priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.carImgV.mas_bottom).offset(20);
    }];
    
    [self.cV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(4));
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    [self.indicatorV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.cV);
//        make.width.mas_equalTo(@(0));
        make.left.equalTo(self.cV);
        make.right.equalTo(self.cV);
    }];
}

- (void)configureCellModel:(OKCar *)model {
    self.titleL.text = model.name;
    self.priceL.text = model.price;
    
    // 重置，防止点击切换时，其他 item 受缩放影响
    self.titleL.transform = CGAffineTransformIdentity;
    self.priceL.transform = CGAffineTransformIdentity;
    self.carImgV.transform = CGAffineTransformIdentity;
    self.indicatorV.transform = CGAffineTransformMakeTranslation(-self.frame.size.width, 0);

    self.alpha = 0.4;
    
//    [self.indicatorV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(self.cV);
//        make.width.mas_equalTo(@(0));
//        make.left.equalTo(self.cV);
//    }];
    
    if (model.isItemSelected) {
//        self.alpha = 1;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.titleL.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.priceL.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.carImgV.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.indicatorV.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.alpha = 1;
            
//            [self.indicatorV mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(@(self.frame.size.width));
//            }];
//            [self.cV layoutIfNeeded];
            
//                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            
        }];
    } else {
//        self.alpha = 0.4;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.titleL.transform = CGAffineTransformIdentity;
            self.priceL.transform = CGAffineTransformIdentity;
            self.carImgV.transform = CGAffineTransformIdentity;
            self.indicatorV.transform = CGAffineTransformMakeTranslation(-self.frame.size.width, 0);
            
            self.alpha = 0.4;
            
//            [self.indicatorV mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(@(0));
//            }];
//            [self.cV layoutIfNeeded];
            
//                self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)updateConstraints {
    
    [super updateConstraints];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    NSLog(@"%d", selected);
}

@end
