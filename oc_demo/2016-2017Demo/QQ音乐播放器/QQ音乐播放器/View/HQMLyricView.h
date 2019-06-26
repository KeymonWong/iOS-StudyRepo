//
//  HQMLyricView.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HQMLyricView;

@protocol HQMLyricViewDelegate <NSObject>

@optional
- (void)lyricViewDidScroll:(HQMLyricView *)lyricView withProgress:(CGFloat)progress;

@end

@interface HQMLyricView : UIView

@property (nonatomic, weak) id<HQMLyricViewDelegate> delegate;

/** 歌词数组 */
@property (nonatomic, strong) NSArray *lyrics;

/** 歌词行高 */
@property (nonatomic, assign) CGFloat rowHeight;

/** 歌词进度 */
@property (nonatomic, assign) CGFloat progress;

/** 当前歌词下标 */
@property (nonatomic, assign) NSInteger currentLyricIndex;

@end
