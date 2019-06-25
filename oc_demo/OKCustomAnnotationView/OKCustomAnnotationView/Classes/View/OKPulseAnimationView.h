//
//  OKPulseAnimationView.h
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/30.
//  Copyright © 2019 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OKPulseType) {
    OKPulseTypeCircle = 1, ///< 圆形 脉冲
    OKPulseTypeOval ///< 椭圆形 脉冲
};

@interface OKPulseAnimationView : UIView

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame pulseType:(OKPulseType)type NS_DESIGNATED_INITIALIZER;

- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
