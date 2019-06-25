//
//  HKSettingCell.h
//  DifferentCellDisplay
//
//  Created by 小伴 on 16/3/30.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKSettingItem;

@interface HKSettingCell : UITableViewCell

/** 对外暴露 */
@property (nonatomic, strong) HKSettingItem *item;

/** 创建 cell 的类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
