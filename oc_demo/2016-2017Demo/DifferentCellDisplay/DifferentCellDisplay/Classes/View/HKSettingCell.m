//
//  HKSettingCell.m
//  DifferentCellDisplay
//
//  Created by 小伴 on 16/3/30.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HKSettingCell.h"

#import "HKSettingItem.h"

@interface HKSettingCell ()

@property (nonatomic, strong) UIImageView *myImgView;
@property (nonatomic, strong) UISwitch    *mySwitch;

@end

@implementation HKSettingCell

- (UIImageView *)myImgView {
    if (!_myImgView) {
        self.myImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-arrow1"]];

    }
    return _myImgView;
}

- (UISwitch *)mySwitch {
    if (!_mySwitch) {
        self.mySwitch = [[UISwitch alloc] init];
        [_mySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

- (void)valueChanged:(UISwitch *)sender {

}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"HKSettingCell";
    HKSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HKSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    return cell;
}

- (void)setItem:(HKSettingItem *)item {
    _item = item;

    self.textLabel.text = item.title;
    if (_item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }

    //设置辅助视图
    //通过子类model判断
    if ([item isKindOfClass:[HKSettingSwitchItem class]]) {
        self.accessoryView = self.mySwitch;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if ([item isKindOfClass:[HKSettingArrowItem class]]) {
        self.accessoryView = self.myImgView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
