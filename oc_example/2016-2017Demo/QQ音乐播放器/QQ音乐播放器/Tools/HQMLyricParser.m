//
//  HQMLyricParser.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/27.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMLyricParser.h"

#import "HQMLyric.h"

#define kSortDescriptorKey @"time"

@implementation HQMLyricParser

+ (NSArray *)parseLyricForFilename:(NSString *)filename {
    //1.获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];

    //2.转换成字符串
    NSError *error = nil;
    NSString *lrcStr = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:&error];

    NSLog(@"%@", lrcStr);

    //3.截取成一行一行的小字符串
    NSArray *lines = [lrcStr componentsSeparatedByString:@"\n"];

    // 4.便利数组
    //  [03:02.00][01:05.00]这晚夜没有吻别

    // 5.1标准 [01:05.00]  首位的 [] 需要 \\ 来转义  范式,标准,榜样,标尺
    NSString *pattern = @"\\[[0-9][0-9]:[0-9][0-9].[0-9][0-9]\\]";
    // @"\\[\\d{2}:\\d{2}.\\d{2}\\]"

    //5.正则
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];

    //保存模型的数组
    NSMutableArray *models = [NSMutableArray array];


    for (NSString *line in lines) {
        //6.与 line 匹配
        NSArray *matches = [regularExpression matchesInString:line options:0 range:NSMakeRange(0, line.length)];
        //7.拿出最后一个
        NSTextCheckingResult *lastMatch = [matches lastObject];
        //8.截取文本部分
        NSString *content = [line substringFromIndex:lastMatch.range.location + lastMatch.range.length];

        NSLog(@"%@", content);

        //9.遍历时间部分数组
        for (NSTextCheckingResult *result in matches) {
            NSString *timeStr = [line substringWithRange:result.range];
            NSLog(@"%@", timeStr);

            //10.时间格式化对象
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            fmt.dateFormat = @"[mm:ss.SS]";
            NSDate *timeDate = [fmt dateFromString:timeStr];
            NSDate *zeroDate = [fmt dateFromString:@"[00:00.00]"];

            //11.歌词时间间隔
            NSTimeInterval timeInterval = [timeDate timeIntervalSinceDate:zeroDate];

            //12.创建模型赋值
            HQMLyric *lyric = [[HQMLyric alloc] init];
            lyric.timeInterval = timeInterval;
            lyric.lrcContent = content;

            //14.保存
            [models addObject:lyric];
        }
    }

    //15.歌词排序，根据歌词的 时间（timeInterval歌词的模型中的属性）
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"timeInterval" ascending:YES];

    return [models sortedArrayUsingDescriptors:@[sortDesc]];
}

@end
