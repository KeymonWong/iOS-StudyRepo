//
//  HQMMusic.h
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HQMMusicType) {
    kHQMMusicTypeLocal = 0, //本地
    kHQMMusicTypeRemote     //远端
};

@interface HQMMusic : NSObject

/**图片*/
@property (nonatomic, copy) NSString *image;

/**歌词*/
@property (nonatomic, copy) NSString *lrc;

/**歌曲的播放文件名*/
@property (nonatomic, copy) NSString *mp3;

/**名字*/
@property (nonatomic, copy) NSString *name;

/**歌手*/
@property (nonatomic, copy) NSString *singer;

/**专辑名*/
@property (nonatomic, copy) NSString *album;

/**歌曲类型*/
@property (nonatomic, assign) HQMMusicType type;

@end
