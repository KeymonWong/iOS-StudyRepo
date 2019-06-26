//
//  OKValuationCardView.m
//  OLA-iOS
//
//  Created by keymon on 2019/3/31.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKValuationCardView.h"

#import "OKCar.h"

#import <Masonry.h>

@interface OKValuationCardView ()
@property (nonatomic, weak) UIView *containerV; ///< 预估价格+抵扣金额 包装的view
@property (nonatomic, weak) UILabel *priceL; ///< 预估价格
@property (nonatomic, weak) UILabel *discountL; ///< 抵扣金额

@property (nonatomic, weak) UIButton *refreshPriceBtn;
@property (nonatomic, weak) UIButton *seeDetailBtn;
@property (nonatomic, weak) UIImageView *switchLoadGIF;
@end

@implementation OKValuationCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    [self addSubview:({
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        v.hidden = YES;
        self.containerV = v;
        v;
    })];
    
    [self.containerV addSubview:({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        self.priceL = label;
        label;
    })];
    
    [self.containerV addSubview:({
        UILabel *l = [[UILabel alloc] init];
        l.textAlignment = NSTextAlignmentCenter;
        self.discountL = l;
        l;
    })];
    
    [self addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"loading"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:@"价格预估中…" forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.hidden = NO;
        self.refreshPriceBtn = btn;
        btn;
    })];
    
    [self addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        NSMutableArray *imgs = [NSMutableArray array];
        for (NSInteger idx = 0; idx < 4; ++idx) {
            UIImage *tmp = [UIImage imageNamed:[NSString stringWithFormat:@"ola_pick_car_type-Load%ld", (long)(idx+1)]];
            if (tmp) {
                [imgs addObject:tmp];
            }
        }
        imgV.animationImages = [imgs copy];
        imgV.animationDuration = 0.8; // 0.8秒循环播放一次
        imgV.animationRepeatCount = 0;
        self.switchLoadGIF = imgV;
        imgV.hidden = YES;
        imgV;
    })];
    
    // 虚拟的按钮
    [self addSubview:({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.hidden = YES;
        self.seeDetailBtn = btn;
        btn;
    })];
    
    [self.seeDetailBtn addTarget:self action:@selector(seeDetailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.refreshPriceBtn addTarget:self action:@selector(refreshPriceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self remakeLayout];
}

- (void)remakeLayout {
    [self.containerV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.priceL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerV).offset(0);
//        make.centerX.equalTo(self.containerV);
        make.height.mas_equalTo(@(19));
        make.left.right.equalTo(self.containerV).offset(0);
    }];
    
    [self.discountL mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.containerV);
        make.left.right.equalTo(self.containerV).offset(0);
        make.bottom.equalTo(self.containerV.mas_bottom).offset(-10);
    }];
    
    [self.switchLoadGIF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.refreshPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.seeDetailBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(@(150));
    }];
}

- (void)configSwitchLoadAnimationWithScrolling:(BOOL)scrolling {
    scrolling ? [self.switchLoadGIF startAnimating] : [self.switchLoadGIF stopAnimating];
    self.containerV.hidden = scrolling;
    self.switchLoadGIF.hidden = !scrolling;
    self.seeDetailBtn.hidden = scrolling;
}

- (void)configureLoadingViewWithModel:(OKCar *)model {
    if (model.isValuationSuccess == 1) { // 估价成功
        self.refreshPriceBtn.hidden = YES;
        self.containerV.hidden = NO;
        self.seeDetailBtn.hidden = NO;
    }
    else if (model.isValuationSuccess == 2) { // 估价中
        self.containerV.hidden = YES;
        self.refreshPriceBtn.hidden = NO;
        self.seeDetailBtn.hidden = YES;
        [self setupRefreshBtnStateWithRefresh:YES];
    }
    else { // 估价失败
        self.containerV.hidden = YES;
        self.refreshPriceBtn.hidden = NO;
        self.seeDetailBtn.hidden = YES;
        [self setupRefreshBtnStateWithRefresh:NO];
    }
}

- (void)configureValuation:(OKCar *)valuation {
    self.priceL.text = valuation.price;
}

- (void)setupRefreshBtnStateWithRefresh:(BOOL)refresh {
    if (refresh) {
        [self.refreshPriceBtn setImage:[UIImage imageNamed:@"loading"] forState:UIControlStateNormal];
        [self.refreshPriceBtn setTitle:@"价格预估中…" forState:UIControlStateNormal];
    } else {
        [self.refreshPriceBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [self.refreshPriceBtn setTitle:@"手动刷新试试" forState:UIControlStateNormal];
    }
}

#pragma mark - action

- (void)refreshPriceBtnClick:(UIButton *)sender {
    //防止重复点击
    sender.userInteractionEnabled = NO;
    [self addRotationAnimation];
    [self performSelector:@selector(changeBtnState:) withObject:sender afterDelay:1.f];
    !self.didRefreshBlock ?: self.didRefreshBlock();
}

- (void)seeDetailBtnClick:(UIButton *)sender {
    //防止重复点击
    sender.userInteractionEnabled = NO;
    [self performSelector:@selector(changeBtnState:) withObject:sender afterDelay:1.f];
    !self.didSeeDetailBlock ?: self.didSeeDetailBlock();
}

- (void)addRotationAnimation {
    CABasicAnimation *rotationAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAni.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    rotationAni.duration = 1;
    rotationAni.cumulative = YES;
    rotationAni.repeatCount = 4;
    [self.refreshPriceBtn.imageView.layer addAnimation:rotationAni forKey:@"rotationAni"];
}

- (void)changeBtnState:(UIButton *)sender {
    sender.userInteractionEnabled = YES;
}

@end
