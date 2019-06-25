//
//  HQMLyric.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMLyric : NSObject
/** 时间间隔 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**歌词文本*/
@property (nonatomic, copy) NSString *lrcContent;

@end
