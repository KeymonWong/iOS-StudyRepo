//
//  HQMTimeFormatter.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMTimeFormatter : NSObject

/** 时间间隔 转 字符串 */
+ (NSString *)formatterToStringWithTimeInterval:(NSTimeInterval)ti;

@end
