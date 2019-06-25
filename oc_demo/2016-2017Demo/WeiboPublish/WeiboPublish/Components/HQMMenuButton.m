//
//  HQMMenuButton.m
//  WeiboPublish
//
//  Created by 小伴 on 2017/3/10.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "HQMMenuButton.h"

@implementation HQMMenuButton

/*
 初始化弹出按钮的样式
 */
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:13.];
    }
    return self;
}

/*
 自定义按钮图片与文字的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];

    //UIImageView
    CGFloat imgX = 0.;
    CGFloat imgY = 0.;
    CGFloat imgW = self.bounds.size.width;
    CGFloat imgH = self.bounds.size.height * 0.8;
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);

    //UILabel
    CGFloat labelY = imgH+0.5;
    CGFloat labelH = self.bounds.size.height - labelY;
    self.titleLabel.frame = CGRectMake(imgX, labelY, imgW, labelH);
}

@end
