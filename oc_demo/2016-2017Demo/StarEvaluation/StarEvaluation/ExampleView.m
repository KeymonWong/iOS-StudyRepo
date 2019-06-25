
//
//  ExampleView.m
//  StarEvaluation
//
//  Created by 小伴 on 2017/2/17.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "ExampleView.h"

#import "StarEvaluationView.h"

@interface ExampleView ()
@property (nonatomic, weak) StarEvaluationView *starView1;
@property (nonatomic, weak) StarEvaluationView *starView2;
@end

@implementation ExampleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    UILabel *fiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
    [fiveLabel setFont:[UIFont systemFontOfSize:16]];
    [fiveLabel setTextColor:[UIColor redColor]];
    [fiveLabel setTextAlignment:NSTextAlignmentLeft];
    [fiveLabel setText:@"五星好评"];
    [self addSubview:fiveLabel];

    StarEvaluationView *starView1 = [[StarEvaluationView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(fiveLabel.frame)+20+20, 170, 30) normalImageName:nil highlightedImageName:nil];
    StarEvaluationView *starView2 = [[StarEvaluationView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(starView1.frame)+30+20, 170, 30) normalImageName:nil highlightedImageName:nil];
    [self addSubview:starView1];
    [self addSubview:starView2];

    self.starView1 = starView1;
    self.starView2 = starView2;

    [self handleAction];
}

- (void)handleAction {
    [self.starView1 setStarEvaluationBlock:^(StarEvaluationView *currentView, NSInteger starIndex) {
        //do delegate method
    }];
    
    [self.starView2 setStarEvaluationBlock:^(StarEvaluationView *currentView, NSInteger starIndex) {
        //do delegate method
    }];
}

@end
