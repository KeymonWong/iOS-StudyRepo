//
//  OKAnchorPinView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/16.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKAnchorPinView.h"

@interface OKAnchorPinView ()
@property (nonatomic, strong) UIImageView *pinHeaderImgV;
@property (nonatomic, strong) UIImageView *pinTailImgV;
@property (nonatomic, strong) UIImageView *pinImgV;
@end

@implementation OKAnchorPinView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
}

@end
