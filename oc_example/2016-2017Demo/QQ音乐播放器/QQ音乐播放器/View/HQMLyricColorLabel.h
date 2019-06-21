//
//  HQMLyricColorLabel.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQMLyricColorLabel : UILabel

/**
 *  歌曲进度
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  播放过的歌词颜色
 */
@property (nonatomic, strong) UIColor *currentLyricColor;

@end
