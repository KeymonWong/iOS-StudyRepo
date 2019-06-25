//
//  HQMTimeFormatter.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMTimeFormatter.h"

@implementation HQMTimeFormatter

/** 时间间隔 转 字符串 */
+ (NSString *)formatterToStringWithTimeInterval:(NSTimeInterval)ti {
    int minute = ti / 60;
    int second = (int)ti % 60;

    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d", minute, second];

    return timeStr;
}

@end
