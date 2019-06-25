//
//  HQMLyricColorLabel.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMLyricColorLabel.h"

@implementation HQMLyricColorLabel

- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    //重绘，会调用 drawRect:，异步执行
    [self setNeedsDisplay];
}

#warning drawRect:不能直接手动调用，是系统自动调用的
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    //设置颜色
    [self.currentLyricColor set];

    //设置随着进度，增加长度
    rect.size.width *= self.progress;

    //图形混合模式,使用渲染模式填充
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
}

#pragma mark - 懒加载歌词颜色
- (UIColor *)currentLyricColor {
    if (!_currentLyricColor) {
        _currentLyricColor = [UIColor greenColor];
    }

    return _currentLyricColor;
}

@end
