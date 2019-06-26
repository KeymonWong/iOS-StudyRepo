//
//  HQMPlayManager.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/27.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMPlayManager.h"

#import <AVFoundation/AVFoundation.h>

@interface HQMPlayManager ()<AVAudioPlayerDelegate>

/**播放音乐的对象*/
@property (nonatomic, strong) AVAudioPlayer *player;

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) void (^handler)();

@end

@implementation HQMPlayManager

//@synthesize currentTime = _currentTime;

+ (instancetype)sharePlayManager {
    static HQMPlayManager *_playManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _playManager = [[HQMPlayManager alloc] init];
    });

    return _playManager;
}

- (void)playMusicWithFilename:(NSString *)filename completionHandler:(void (^)())handler {
    if (![self.filename isEqualToString:filename]) {
        self.filename = filename;

        //1.获取歌曲路径
        NSURL *musicUrl = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];

        //2.创建播放对象
        NSError *error = nil;
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:&error];
        if (error) {
            NSLog(@"%@", error);
            return;
        }

        //保存block
        self.handler = handler;

        self.player.delegate = self;

        //准备播放
        [self.player prepareToPlay];
    }

    [self play];
}

- (void)play {
    //播放
    [self.player play];
}

- (void)pause {
    [self.player pause];
}

- (NSTimeInterval)currentTime {
    return self.player.currentTime;
//    return _currentTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    self.player.currentTime = currentTime;
//    _currentTime = self.player.currentTime;
}

- (NSTimeInterval)durationTime {
    return self.player.duration;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    self.handler();
}

@end
