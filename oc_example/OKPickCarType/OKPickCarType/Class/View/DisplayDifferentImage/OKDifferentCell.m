//
//  OKDifferentCell.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/12.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKDifferentCell.h"
#import <Masonry.h>

@interface OKDifferentCell ()
@property (nonatomic, weak) UIImageView *imgV;
@property (nonatomic, weak) UILabel *markL;
@end

@implementation OKDifferentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSuviews];
        [self makeLayout];
    }
    return self;
}

- (void)setupSuviews {
    [self.contentView addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        self.imgV = imgV;
        imgV;
    })];
    
    [self.contentView addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL = label;
        label;
    })];
}

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.markL.text = @"ScaleToFill";
        self.imgV.contentMode = UIViewContentModeScaleToFill;
        
        // 从网络上加载到的未知图片，宽高只有图片下载下来，才能知道 size
        UIImage *unknown1 = [UIImage imageNamed:@"changtu"];
        
        // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
        if (unknown1.size.width > unknown1.size.height) {
            // 根据网络图片宽高比计算 imageView 高度
            CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(100);
                make.top.equalTo(self.contentView).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        self.imgV.image = unknown1;
    }
    else if (indexPath.row == 1) {
        self.markL.text = @"Redraw";
        self.imgV.contentMode = UIViewContentModeRedraw;
        
        UIImage *unknown2 = [UIImage imageNamed:@"gaotu"];
        
        // 以高为准，根据 UI 原型图，规定最大高，高写死，如果 UI 规定最大高为 60，则 imageView 高度以 60 为准
        if (unknown2.size.width < unknown2.size.height) {
            // 根据网络图片宽高比计算 imageView 高度
            CGSize size = CGSizeMake(60 * (unknown2.size.width / unknown2.size.height), 60);
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(100);
                make.top.equalTo(self.contentView).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        self.imgV.image = unknown2;
    }
    else if (indexPath.row == 2) {
        self.markL.text = @"Center";
        self.imgV.contentMode = UIViewContentModeCenter;
        
        UIImage *unknown2 = [UIImage imageNamed:@"gaotu"];
        
        // 以高为准，根据 UI 原型图，规定最大高，高写死，如果 UI 规定最大高为 60，则 imageView 高度以 60 为准
        if (unknown2.size.width < unknown2.size.height) {
            // 根据网络图片宽高比计算 imageView 高度
            CGSize size = CGSizeMake(60 * (unknown2.size.width / unknown2.size.height), 60);
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(100);
                make.top.equalTo(self.contentView).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        self.imgV.image = unknown2;
    }
    else if (indexPath.row == 3) {
        self.markL.text = @"Left";
        
        UIImage *unknown1 = [UIImage imageNamed:@"changtu"];
        
        // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
        if (unknown1.size.width > unknown1.size.height) {
            // 根据网络图片宽高比计算 imageView 高度
            CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(100);
                make.top.equalTo(self.contentView).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        self.imgV.image = unknown1;
        self.imgV.contentMode = UIViewContentModeLeft;
    }
    else if (indexPath.row == 4) {
        self.markL.text = @"Top";
        self.imgV.contentMode = UIViewContentModeTop;
        
        UIImage *unknown1 = [UIImage imageNamed:@"changtu"];
        
        // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
        if (unknown1.size.width > unknown1.size.height) {
            // 根据网络图片宽高比计算 imageView 高度
            CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
            [self.imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(100);
                make.top.equalTo(self.contentView).offset(10);
                make.size.mas_equalTo(size);
            }];
        }
        
        self.imgV.image = unknown1;
    }
}

- (void)makeLayout {
    [self.markL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(100);
        make.top.equalTo(self.contentView).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10).priorityLow();
//        make.center.equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
