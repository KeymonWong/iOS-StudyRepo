//
//  FundSelectView.m
//  京东金融金额选择
//
//  Created by 小伴 on 2017/4/28.
//  Copyright © 2017年 huangqimeng. All rights reserved.
//

#import "FundSelectView.h"

#define gScreenWidth [UIScreen mainScreen].bounds.size.width
#define gScreenHeight [UIScreen mainScreen].bounds.size.height

#define kMaxAmount 200000
#define kPadding 10 ///< 最小刻度之间的宽度
#define kMinScale 1000 ///< 最小刻度

@interface FundSelectView ()<UIScrollViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *fundScv;
@property (nonatomic, strong) UITextField *fundTextField;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, assign) CGFloat scrollWidth;
@property (nonatomic, assign) NSUInteger minAmount;
@end

@implementation FundSelectView

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollWidth = gScreenWidth;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.fundScv];
        [self addSubview:self.tipLabel];
        [self addSubview:self.fundTextField];
        [self addSubview:self.markLabel];
        [self addSubview:self.bottomLine];

//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)setAmount:(NSString *)amount {
    _minAmount = [amount integerValue];
    self.fundTextField.text = [NSString stringWithFormat:@"%zd", _minAmount];
    [self createIndicatorWithAmount:amount];
}

- (void)createIndicatorWithAmount:(NSString *)amount {
    for (NSInteger i = [amount integerValue], j = 0; i <= kMaxAmount; i += 1000, j++) {
        _scrollWidth += kPadding;
        [self drawSegmentWithAmount:i idx:j];
    }
    self.fundScv.contentSize = CGSizeMake(_scrollWidth-kPadding, self.frame.size.height);
}

- (void)drawSegmentWithAmount:(NSInteger)amount idx:(NSInteger)idx {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(gScreenWidth * 0.5 + 10 * idx, self.frame.size.height - 5)];

    if (amount % (kMinScale * 10) == 0 || amount == _minAmount) {
        [path addLineToPoint:CGPointMake(gScreenWidth * 0.5 + 10 * idx, self.frame.size.height - 10 - 5 - 10)];

        CGRect frame = CGRectMake(gScreenWidth * 0.5 + 10 * idx - 50 * 0.5, self.frame.size.height - 20 - 10 - 5 - 5, 50, 10);
        UILabel *numLabel = [[UILabel alloc] initWithFrame:frame];
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor lightGrayColor];
        numLabel.text = [NSString stringWithFormat:@"%zd", amount];
        [self.fundScv addSubview:numLabel];
    } else {
        [path addLineToPoint:CGPointMake(gScreenWidth * 0.5 + 10 * idx, self.frame.size.height - 10 - 5)];
    }

    CAShapeLayer *line = [[CAShapeLayer alloc] init];
//    line.frame = CGRectMake(0, 0, 20, 20);
//    line.position = self.view.center;
    line.lineWidth = 1;
    line.strokeColor = [UIColor lightGrayColor].CGColor;
    line.path = path.CGPath;

    [self.fundScv.layer addSublayer:line];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat num = scrollView.contentOffset.x;
    NSUInteger amount = (num / 10) * kMinScale + _minAmount;
    self.fundTextField.text = [NSString stringWithFormat:@"%zd", amount];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.fundScv setContentOffset:CGPointMake(([textField.text floatValue]-_minAmount)/kMinScale*10, 0) animated:YES];
    self.fundTextField.text = textField.text;
}

// 根据输入的数字变化
/*
- (void)textDidChanged:(NSNotification *)info {
    UITextField *textField = info.object;
    NSString *text = textField.text;
    if (textField.isEditing) {
        self.fundScv.contentOffset = CGPointMake(([text floatValue]-_minAmount)/kMinScale*10, 0);
        self.fundTextField.text = text;
    }
}
*/

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((gScreenWidth - 120) * 0.5, 10, 120, 20)];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor orangeColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"劳资要存钱!!!(￥)";
    }
    return _tipLabel;
}

- (UITextField *)fundTextField {
    if (!_fundTextField) {
        _fundTextField = [[UITextField alloc] initWithFrame:CGRectMake((gScreenWidth - 100) * 0.5, CGRectGetMaxY(_tipLabel.frame) + 5, 100, 20)];
        _fundTextField.font = [UIFont systemFontOfSize:16];
        _fundTextField.textAlignment = NSTextAlignmentCenter;
        _fundTextField.textColor = [UIColor orangeColor];
        _fundTextField.delegate = self;
    }
    return _fundTextField;
}

- (UILabel *)markLabel {
    if (!_markLabel) {
        _markLabel = [[UILabel alloc] initWithFrame:CGRectMake((gScreenWidth - 1) * 0.5, CGRectGetMaxY(_fundTextField.frame) + 5, 1, self.frame.size.height - CGRectGetMaxY(_fundTextField.frame) - 5 - 5)];
        _markLabel.backgroundColor = [UIColor orangeColor];
    }
    return _markLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 5, gScreenWidth, 1)];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

- (UIScrollView *)fundScv {
    if (!_fundScv) {
        _fundScv = [[UIScrollView alloc] initWithFrame:self.bounds];
        _fundScv.showsHorizontalScrollIndicator = NO;
        _fundScv.bounces = NO;
        _fundScv.delegate = self;
    }
    return _fundScv;
}

@end
