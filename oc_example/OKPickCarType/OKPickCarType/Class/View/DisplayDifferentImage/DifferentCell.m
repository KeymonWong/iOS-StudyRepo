//
//  DifferentCell.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/12.
//  Copyright © 2019 ok. All rights reserved.
//

#import "DifferentCell.h"
#import <Masonry.h>

@interface DifferentCell ()
@property (nonatomic, weak) UIImageView *imgV;
@end

@implementation DifferentCell

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
}

- (void)configureCellWithIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)makeLayout {
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
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
