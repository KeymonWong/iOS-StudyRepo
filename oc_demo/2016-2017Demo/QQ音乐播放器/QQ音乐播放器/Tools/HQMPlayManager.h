//
//  HQMPlayManager.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/27.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HQMPlayManager : NSObject

/**播放的管理者*/
+ (instancetype)sharePlayManager;

/**当前时间*/
@property (nonatomic, assign) NSTimeInterval currentTime;

/**总时间*/
@property (nonatomic, assign) NSTimeInterval durationTime;


/**
 *  播放
 *
 *  @param filename 播放的文件名
 *  @param handler   block
 */
- (void)playMusicWithFilename:(NSString *)filename completionHandler:(void (^)())handler;

/**播放*/
- (void)play;

/**暂停*/
- (void)pause;

@end
