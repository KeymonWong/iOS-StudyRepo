//
//  HKSettingItem.h
//  DifferentCellDisplay
//
//  Created by 小伴 on 16/3/30.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKSettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

@end

/** Switch接口 */
@interface HKSettingSwitchItem : HKSettingItem

@end

/** Arrow接口 */
@interface HKSettingArrowItem : HKSettingItem

@end