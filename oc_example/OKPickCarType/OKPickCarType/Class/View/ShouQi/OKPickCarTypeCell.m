//
//  OKPickCarTypeCell.m
//  FlipPage
//
//  Created by keymon on 2019/3/30.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKPickCarTypeCell.h"

#import "OKCar.h"

#import <Masonry.h>

@interface OKPickCarTypeCell ()
@property (nonatomic, weak) UILabel *titleL;
@property (nonatomic, weak) UIImageView *carImgV;
@end

@implementation OKPickCarTypeCell

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self makeLayout];
    }
    return self;
}

- (void)setupSubviews {
    [self.contentView addSubview:({
        UILabel *titleL = [[UILabel alloc] init];
        titleL.font = [UIFont boldSystemFontOfSize:14];
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.preferredMaxLayoutWidth = 100;
        titleL.text = @"新能源汽车";
        self.titleL = titleL;
        titleL;
    })];
    
    [self.contentView addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"ole_icon_carpool"];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        imgV.clipsToBounds = YES;
        self.carImgV = imgV;
        imgV;
    })];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    [self makeLayout];
}

- (void)makeLayout {
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.left.equalTo(self.contentView).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@(18));
    }];
    
    CGSize imgSize = CGSizeMake(114, 48); // 获取的图片宽高比 2.4 左右，imageview 承载 image 的宽高
    [self.carImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom).offset(12);
        make.size.mas_equalTo(imgSize);
        make.centerX.equalTo(self.contentView);
    }];
}

- (void)configureCellWithModel:(OKCar *)model {
    self.titleL.text = model.name;
}

@end
