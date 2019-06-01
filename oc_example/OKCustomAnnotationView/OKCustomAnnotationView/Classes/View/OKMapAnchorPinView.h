//
//  OKMapAnchorPinView.h
//  OKCustomAnnotationView
//
//  Created by keymon on 2019/5/16.
//  Copyright © 2019 huangqimeng. All rights reserved.
//
//  地图中心锚点

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OKMapAnchorPinView : UIView

/**
 * 移动地图过程
 */
- (void)movingMap;

/**
 * 结束移动地图
 */
- (void)endMoveMap;

- (void)startAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
