//
//  HQMSlideView.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//通知
extern NSString *HQMSlideViewNotification;

@interface HQMSlideView : UIView

/** 接收一个时间用于展示 */
@property (nonatomic, assign) NSTimeInterval ti;

@end
