//
//  HKSettingItem.m
//  DifferentCellDisplay
//
//  Created by 小伴 on 16/3/30.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HKSettingItem.h"

@implementation HKSettingItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title {
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }

    return self;
}

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title {
    return [[self alloc] initWithIcon:icon title:title];
}

@end


@implementation HKSettingSwitchItem

@end


@implementation HKSettingArrowItem

@end
