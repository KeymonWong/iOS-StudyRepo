//
//  StarEvaluationView.m
//  StarEvaluation
//
//  Created by 小伴 on 2017/2/16.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "StarEvaluationView.h"

#define kStarCount 5
#define kStarPadding 5
#define kStarBtnDefaultTag 110

@interface StarEvaluationView ()

@end

@implementation StarEvaluationView

- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalName highlightedImageName:(NSString *)highlightedName {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        if (normalName) {
            self.normalImage = [UIImage imageNamed:normalName];
        } else {
            self.normalImage = [UIImage imageNamed:@"五星评价_灰"];
        }
        if (highlightedName) {
            self.highlightedImage = [UIImage imageNamed:highlightedName];
        } else {
            self.highlightedImage = [UIImage imageNamed:@"五星评价_黄"];
        }

        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    for (NSInteger i = 0; i < kStarCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenHighlighted = NO;
        [btn setBackgroundImage:self.normalImage forState:UIControlStateNormal];
        [btn setBackgroundImage:self.highlightedImage forState:UIControlStateSelected];
        [btn setFrame:CGRectMake(i*(btn.currentBackgroundImage.size.width+kStarPadding), 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height)];
        btn.tag = i+kStarBtnDefaultTag;
        //上左下右 星星居中
        [btn setImageEdgeInsets:UIEdgeInsetsMake((self.bounds.size.height - btn.currentBackgroundImage.size.width)/2, 0, (self.bounds.size.height - btn.currentBackgroundImage.size.width)/2, 0)];
        [btn addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)starBtnClick:(UIButton *)sender {
    for (NSInteger i = 0; i < kStarCount; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+kStarBtnDefaultTag];
        if (i < sender.tag-kStarBtnDefaultTag) {
            btn.selected = YES;
        } else if (i == sender.tag-kStarBtnDefaultTag) {
            btn.selected = !btn.selected;
        } else {
            btn.selected = NO;
        }
    }

    if (self.starEvaluationBlock) {
        self.starEvaluationBlock(self, sender.tag);
    }
}

@end
