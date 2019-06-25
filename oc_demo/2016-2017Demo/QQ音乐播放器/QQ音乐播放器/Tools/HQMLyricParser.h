//
//  HQMLyricParser.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/27.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMLyricParser : NSObject

/**
 *  歌词解析
 *
 *  @param filename 歌词文件名
 *
 *  @return 包含(歌词的时间 && 歌词的文本)的模型数组
 *  譬如：[03:02.00][01:05.00]这晚夜没有吻别
 */
+ (NSArray *)parseLyricForFilename:(NSString *)filename;

@end
