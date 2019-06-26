//
//  HQMViewController.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMViewController.h"

#import "Masonry.h"
#import "MJExtension.h"

#import "HQMMusic.h"
#import "HQMLyric.h"
#import "HQMPlayManager.h"
#import "HQMLyricParser.h"
#import "HQMLyricColorLabel.h"
#import "HQMLyricView.h"

#import "HQMSlideView.h"
#import "HQMTimeFormatter.h"

#import <MediaPlayer/MediaPlayer.h>

@interface HQMViewController ()<HQMLyricViewDelegate>
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

/** 播放面板 */
@property (weak, nonatomic) IBOutlet UIView *playPanelView;
/** 播放按钮 */
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
/** 上一首 */
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
/** 下一首 */
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
/** 当前播放时间 */
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
/** 滑块 */
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
/** 总时间 */
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

/** 中间的view(要消失的) */
@property (weak, nonatomic) IBOutlet UIView *infoView;
/** 歌手图片 */
@property (weak, nonatomic) IBOutlet UIImageView *singerImgView;
/** 歌手名字 */
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
/** 歌词 */
@property (weak, nonatomic) IBOutlet HQMLyricColorLabel *lyricLabel;
/** 专辑 */
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
/** 歌词面板 */
@property (weak, nonatomic) IBOutlet HQMLyricView *lyricView;

/**歌曲模型数组*/
@property (nonatomic, strong) NSArray *musics;

/**当前歌曲的索引*/
@property (nonatomic, assign) NSInteger currentMusicIndex;

/**定时器*/
@property (nonatomic, strong) NSTimer *timer;

/**歌词模型数组*/
@property (nonatomic, strong) NSArray *lyrics;

@end

@implementation HQMViewController

- (void)dealloc {
    [self turnOffTimer];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:HQMSlideViewNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *normalThumbImg = [UIImage imageNamed:@"slider"];
    UIImage *highlightThumbImg = [UIImage imageNamed:@"slider"];

    [self.timeSlider setThumbImage:normalThumbImg forState:UIControlStateNormal];
    [self.timeSlider setThumbImage:highlightThumbImg forState:UIControlStateHighlighted];

    // 给背景添加毛玻璃效果
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.barStyle = UIBarStyleBlack;
    [self.bgImgView addSubview:toolbar];

    [toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    //配置 UI 界面
    [self configSubviews];

    self.lyricView.delegate = self;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slideViewNotification:) name:HQMSlideViewNotification object:nil];
}

- (void)configSubviews {

    HQMMusic *music = self.musics[self.currentMusicIndex];
    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];

    //图片
    UIImage *img = [UIImage imageNamed:music.image];

    //背景图片
    self.bgImgView.image = img;

    //歌曲总时间
    self.durationLabel.text = [HQMTimeFormatter formatterToStringWithTimeInterval:manager.durationTime];

    //歌手图片
    self.singerImgView.image = img;

    //歌手名字
    self.singerLabel.text = music.singer;

    //专辑名称
    self.albumLabel.text = music.album;

    //歌曲名字
    self.title = music.name;

    // 播放歌曲
    self.playBtn.selected = NO;
    [self turnOffTimer];
    [self playBtnClick:nil];

    //解析歌词数组
    self.lyrics = [HQMLyricParser parseLyricForFilename:music.lrc];

    //歌词面板赋值
    self.lyricView.lyrics = self.lyrics;

//    ResultViewController *primaryView = [[ResultViewController alloc] initWithNibName:@"ResultView" bundle:nil];

//    UIImageView *profileView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lamazhengzhuan"]];
//
//    [coinView setPrimaryView:primaryView.view];
//    [coinView setSecondaryView:profileView];
//    [coinView setSpinTime:1.0];
}

#pragma mark - 通知
- (void)slideViewNotification:(NSNotification *)notification {
    HQMSlideView *slideView = notification.object;

    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];
    manager.currentTime = slideView.ti;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    //裁圆
    self.singerImgView.layer.cornerRadius = self.singerImgView.bounds.size.height/2;
    self.singerImgView.layer.masksToBounds = YES;
}

#pragma mark - HQMLyricViewDelegate
- (void)lyricViewDidScroll:(HQMLyricView *)lyricView withProgress:(CGFloat)progress {
    self.infoView.alpha = 1 - progress;
}

- (IBAction)playBtnClick:(UIButton *)playBtn {
    //获取播放器单利
    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];
    //获取歌曲模型
    HQMMusic *music = self.musics[self.currentMusicIndex];

    if (self.playBtn.selected) {//正在播放
        [manager pause];
        [self turnOffTimer];

    } else {
        __weak typeof(self) weakSelf = self;
        [manager playMusicWithFilename:music.mp3 completionHandler:^{
            [weakSelf nextBtnClick:nil];
        }];

        [self turnOnTimer];
    }

    self.playBtn.selected = !self.playBtn.selected;
}

- (IBAction)preBtnClick:(UIButton *)preBtn {
    //判断歌曲索引的边界值
    if (self.currentMusicIndex == 0) {
        self.currentMusicIndex = self.musics.count - 1;
    } else {
        self.currentMusicIndex--;
    }

    //更新 UI
    [self configSubviews];
}

- (IBAction)nextBtnClick:(UIButton *)nextBtn {
    // 判断self.currentMusicIndex的边界值
    if (self.currentMusicIndex == self.musics.count - 1) {
        self.currentMusicIndex = 0;
    } else {
        self.currentMusicIndex++;
    }

    //更新 UI
    [self configSubviews];
}

- (IBAction)timeSliderValueChanged:(UISlider *)sender {
    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];
    manager.currentTime = self.timeSlider.value * manager.durationTime;
}

#pragma mark - 打开定时器
- (void)turnOnTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateWithTimer) userInfo:nil repeats:YES];
}

#pragma mark - 关闭定时器
- (void)turnOffTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 随定时器更新的方法
- (void)updateWithTimer {
    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];

    //更新歌词
    [self updateLyric];

    // 滑块
    self.timeSlider.value = manager.currentTime / manager.durationTime;
    //图片旋转
    self.singerImgView.transform = CGAffineTransformRotate(self.singerImgView.transform, M_PI_2 / 360.);

    //当前时间
    self.currentTimeLabel.text = [HQMTimeFormatter formatterToStringWithTimeInterval:manager.currentTime];


    //进入后台模式
    [self enterBackgroundMode];
}

#pragma mark - 更新歌词
- (void)updateLyric {
    //获取播放器
    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];

    //遍历歌词文件
    for (int i = 0; i < self.lyrics.count; i++) {
        //拿出当前行
        HQMLyric *currentLyric = self.lyrics[i];
        //拿出下一行
        HQMLyric *nextLyric = nil;

        //判断是否越界
        if (i == self.lyrics.count - 1) {
            nextLyric = self.lyrics[i];
        } else {
            nextLyric = self.lyrics[i + 1];
        }

        //拿到当前播放的行
        if (manager.currentTime >= currentLyric.timeInterval && manager.currentTime < nextLyric.timeInterval) {
            //给歌词文本赋值
            self.lyricLabel.text = currentLyric.lrcContent;

            //给歌词 label 的进度赋值
            //歌词进度
            CGFloat progress = (manager.currentTime - currentLyric.timeInterval) / (nextLyric.timeInterval - currentLyric.timeInterval);
            self.lyricLabel.progress = progress;
            self.lyricView.currentLyricIndex = i;
            self.lyricView.progress = progress;
        }
    }
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    /*
     UIEventSubtypeRemoteControlPlay                 = 100,  播放
     UIEventSubtypeRemoteControlPause                = 101,  暂停
     UIEventSubtypeRemoteControlStop                 = 102,  停止
     UIEventSubtypeRemoteControlTogglePlayPause      = 103,  从播放到暂停
     UIEventSubtypeRemoteControlNextTrack            = 104,  下一曲
     UIEventSubtypeRemoteControlPreviousTrack        = 105,  上一曲
     UIEventSubtypeRemoteControlBeginSeekingBackward = 106,  开始快退
     UIEventSubtypeRemoteControlEndSeekingBackward   = 107,  结束快退
     UIEventSubtypeRemoteControlBeginSeekingForward  = 108,  开始快进
     UIEventSubtypeRemoteControlEndSeekingForward            结束快进
     */
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        case UIEventSubtypeRemoteControlPause:
            [self playBtnClick:nil];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self nextBtnClick:nil];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self preBtnClick:nil];
            break;
        default:
            break;
    }
}

#pragma mark - 进入后台模式
- (void)enterBackgroundMode {
    MPNowPlayingInfoCenter *nowPlayingInfoCenter = [MPNowPlayingInfoCenter defaultCenter];

    HQMMusic *music = self.musics[self.currentMusicIndex];

    HQMPlayManager *manager = [HQMPlayManager sharePlayManager];

    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];

    /*
     // MPMediaItemPropertyAlbumTitle
     // MPMediaItemPropertyAlbumTrackCount
     // MPMediaItemPropertyAlbumTrackNumber
     // MPMediaItemPropertyArtist
     // MPMediaItemPropertyArtwork
     // MPMediaItemPropertyComposer
     // MPMediaItemPropertyDiscCount
     // MPMediaItemPropertyDiscNumber
     // MPMediaItemPropertyGenre
     // MPMediaItemPropertyPersistentID
     // MPMediaItemPropertyPlaybackDuration
     // MPMediaItemPropertyTitle
     */

    dict[MPMediaItemPropertyAlbumTitle] = music.album;
    dict[MPMediaItemPropertyArtist] = music.singer;
    dict[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:music.image]];
    dict[MPMediaItemPropertyPlaybackDuration] = @(manager.durationTime);
    dict[MPMediaItemPropertyTitle] = music.name;
    dict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = @(manager.currentTime);

    nowPlayingInfoCenter.nowPlayingInfo = dict;
}

#pragma mark - 懒加载
- (NSArray *)musics {
    if (!_musics) {
        _musics = [HQMMusic objectArrayWithFilename:@"mlist.plist"];
    }

    return _musics;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
