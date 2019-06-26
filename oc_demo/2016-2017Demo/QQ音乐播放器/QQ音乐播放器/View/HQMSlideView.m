//
//  HQMSlideView.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMSlideView.h"

#import "Masonry.h"
#import "HQMTimeFormatter.h"

NSString *HQMSlideViewNotification = @"HQMSlideViewNotification";

@interface HQMSlideView ()
/** 时间label */
@property (nonatomic, weak) UILabel *timeLabel;
/** 提示label */
@property (nonatomic, weak) UILabel *tipLabel;
/** 播放按钮 */
@property (nonatomic, weak) UIButton *playBtn;
/** 背景 */
@property (nonatomic, weak) UIImageView *bgImgView;
@end

@implementation HQMSlideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }

    return self;
}

- (void)setupUI {
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;

    UILabel *tipLabel = [[UILabel alloc] init];
    [self addSubview:tipLabel];
    self.tipLabel = tipLabel;

    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:playBtn];
    self.playBtn = playBtn;

    UIImageView *bgImgView = [[UIImageView alloc] init];
    [self addSubview:bgImgView];
    self.bgImgView = bgImgView;

    //设置属性
    self.tipLabel.text = @"点击右边按钮从当前播放喔";
    self.tipLabel.textColor = [UIColor whiteColor];

    [self.playBtn setImage:[UIImage imageNamed:@"slide_icon_play"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"slide_icon_play_pressed"] forState:UIControlStateHighlighted];
    [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    self.bgImgView.image = [UIImage imageNamed:@"lyric_tipview_backimg"];

    self.timeLabel.textColor = [UIColor whiteColor];
}

- (void)playBtnAction:(UIButton *)playBtn {
    [[NSNotificationCenter defaultCenter] postNotificationName:HQMSlideViewNotification object:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(8);
    }];

    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];

    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-10);
    }];

    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setTi:(NSTimeInterval)ti {
    _ti = ti;

    self.timeLabel.text = [HQMTimeFormatter formatterToStringWithTimeInterval:_ti];
}

@end
