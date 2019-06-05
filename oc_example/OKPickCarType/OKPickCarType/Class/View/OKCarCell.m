//
//  OKCarCell.m
//  demo
//
//  Created by keymon on 2019/6/4.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKCarCell.h"

#import "Masonry.h"
#import "OKCar.h"

@interface OKCarCell ()
@property (nonatomic, weak) UIImageView *carImgV;
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UILabel *priceL;
@end

@implementation OKCarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor purpleColor];
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
}

- (void)configureCellModel:(OKCar *)model {
    self.titleL.text = model.name;
    self.priceL.text = model.price;
    
    // 重置，防止点击切换时，其他 item 受缩放影响
    self.titleL.transform = CGAffineTransformIdentity;
    self.priceL.transform = CGAffineTransformIdentity;
    self.carImgV.transform = CGAffineTransformIdentity;
    
    if (model.isItemSelected) {
        self.alpha = 1;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.titleL.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.priceL.transform = CGAffineTransformMakeScale(1.2, 1.2);
            self.carImgV.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
//                self.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {

        }];
    } else {
        self.alpha = 0.3;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.titleL.transform = CGAffineTransformIdentity;
            self.priceL.transform = CGAffineTransformIdentity;
            self.carImgV.transform = CGAffineTransformIdentity;
            
//                self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {

        }];
    }
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
//    if (selected) {
//        self.alpha = 1;
//    } else {
//        self.alpha = 0.3;
//    }
}

@end
