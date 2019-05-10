//
//  OKAnchorPinAnnotationView.m
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/9.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import "OKAnchorPinAnnotationView.h"

@implementation OKAnchorPinAnnotationView

- (instancetype)init {
    return [self initWithAnnotation:self.annotation reuseIdentifier:self.reuseIdentifier];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithAnnotation:self.annotation reuseIdentifier:self.reuseIdentifier];
}

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
}

@end
