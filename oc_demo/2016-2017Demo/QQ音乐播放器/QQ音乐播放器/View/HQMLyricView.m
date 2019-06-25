//
//  HQMLyricView.m
//  QQ音乐播放器
//
//  Created by 小伴 on 16/4/26.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMLyricView.h"

#import "HQMLyric.h"
#import "HQMLyricColorLabel.h"
//#import "HQMTimeFormatter.h"
#import "HQMSlideView.h"

#import "Masonry.h"

@interface HQMLyricView ()<UIScrollViewDelegate>

/**横向的*/
@property (nonatomic, strong) UIScrollView *hScrollView;
/**竖向的*/
@property (nonatomic, strong) UIScrollView *vScrollView;

@property (nonatomic, weak) HQMSlideView *slideView;

@end

@implementation HQMLyricView

#warning 在.m文件中同时实现getter和setter时候需要@synthesize age = _age.
@synthesize currentLyricIndex = _currentLyricIndex;

#pragma mark - 通过 storyboard 创建时，加载
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }

    return self;
}

#pragma mark - 通过纯代码创建时，加载
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }

    return self;
}

#pragma mark - 初始化
- (void)setup {
    //水平方向的
    UIScrollView *hScv = [[UIScrollView alloc] init];
    [self addSubview:hScv];
    self.hScrollView = hScv;
//    self.hScrollView.backgroundColor = [UIColor redColor];

    //垂直方向的
    UIScrollView *vScv = [[UIScrollView alloc] init];
    [self.hScrollView addSubview:vScv];
    self.vScrollView = vScv;
//    self.vScrollView.backgroundColor = [UIColor blueColor];

    //设置属性
    self.vScrollView.backgroundColor = [UIColor clearColor];
    self.vScrollView.showsVerticalScrollIndicator = NO;
    self.vScrollView.delegate = self;

    self.hScrollView.showsHorizontalScrollIndicator = NO;
    self.hScrollView.pagingEnabled = YES;
    self.hScrollView.delegate = self;

    //滑动时的提示
    HQMSlideView *slideView = [[HQMSlideView alloc] init];
    self.slideView = slideView;
    slideView.hidden = YES;//默认隐藏
    [self addSubview:slideView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.hScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    [self.vScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.frame.size.width);
        make.height.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
    }];

    self.hScrollView.contentSize = CGSizeMake(self.bounds.size.width*2, 0);

    CGFloat top = self.bounds.size.height * 0.5;
    CGFloat bottom = top;
    self.vScrollView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);

    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - 水平方向的scrollView的contentOffset发生改变的时候调用该方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.hScrollView) {
        // 代理发送通知给控制器,告诉需要设置alpha的值
        CGFloat offsetX = self.hScrollView.contentOffset.x;
        CGFloat progress = offsetX / self.bounds.size.width;

        if (self.delegate && [self.delegate respondsToSelector:@selector(lyricViewDidScroll:withProgress:)]) {
            [self.delegate lyricViewDidScroll:self withProgress:progress];
        }
    }
    
    if (scrollView == self.vScrollView) {
        [self vScrollViewDidScroll];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.vScrollView) {
        //只要一拖动 slideView 就显示
        self.slideView.hidden = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.vScrollView.isDragging) {
            self.slideView.hidden = YES;
        }
    });
}

- (void)vScrollViewDidScroll {
    //获取中间位置的索引值
    CGFloat offsetY = self.vScrollView.contentOffset.y + self.vScrollView.contentInset.top;
    NSInteger centerIndex = offsetY / self.rowHeight;

    //判断一下边界
    if (centerIndex > self.lyrics.count - 1) {
        centerIndex = self.lyrics.count - 1;
    }
    else if (centerIndex < 0) {
        centerIndex = 0;
    }

    HQMLyric *lyric = self.lyrics[centerIndex];
    self.slideView.ti = lyric.timeInterval;
}

#pragma mark - lyrics 的 setter
- (void)setLyrics:(NSArray *)lyrics {
    _lyrics = lyrics;
    // 歌词为空处理
    if (_lyrics.count == 0) {
        return;
    }

    [self.vScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0; i < _lyrics.count; i++) {
        HQMLyric *lyric = _lyrics[i];
        HQMLyricColorLabel *colorLabel = [[HQMLyricColorLabel alloc] init];

        colorLabel.text = lyric.lrcContent;
        colorLabel.textColor = [UIColor whiteColor];

        [self.vScrollView addSubview:colorLabel];

        [colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self);
            make.top.mas_equalTo(self.rowHeight * i);
            make.height.mas_equalTo(self.rowHeight);
        }];
    }

    self.vScrollView.contentSize = CGSizeMake(0, self.rowHeight * _lyrics.count);
}

#pragma mark - rowHeight 的 getter
- (CGFloat)rowHeight {
    if (_rowHeight == 0) {
        _rowHeight = 35;
    }

    return _rowHeight;
}

#pragma mark - progress 的 setter
- (void)setProgress:(CGFloat)progress {
    _progress = progress;

    HQMLyricColorLabel *colorLabel = self.vScrollView.subviews[self.currentLyricIndex];
    colorLabel.progress = progress;
}

#pragma mark - currentLyricIndex 的 setter 和 getter
- (void)setCurrentLyricIndex:(NSInteger)currentLyricIndex {
    //赋值之前的歌词颜色
    HQMLyricColorLabel *preColorLabel = self.vScrollView.subviews[self.currentLyricIndex];
    preColorLabel.font = [UIFont systemFontOfSize:15.];
    preColorLabel.progress = 0;

    //字体不一样的关键
    _currentLyricIndex = currentLyricIndex;

    //赋值之后的歌词颜色
    HQMLyricColorLabel *curColorLabel = self.vScrollView.subviews[self.currentLyricIndex];
    curColorLabel.font = [UIFont systemFontOfSize:25.];
//    curColorLabel.progress = self.progress;

    if (!self.slideView.hidden) {
        return;
    }
    CGFloat offsetY = self.rowHeight * _currentLyricIndex - self.vScrollView.contentInset.top;
    [UIView animateWithDuration:0.7 animations:^{
        self.vScrollView.contentOffset = CGPointMake(0, offsetY);
    }];
}

- (NSInteger)currentLyricIndex {
    if (_currentLyricIndex < 0) {
        _currentLyricIndex = 0;
    }
    else if (_currentLyricIndex > self.lyrics.count - 1) {
        _currentLyricIndex = self.lyrics.count;
    }

    return _currentLyricIndex;
}

@end
