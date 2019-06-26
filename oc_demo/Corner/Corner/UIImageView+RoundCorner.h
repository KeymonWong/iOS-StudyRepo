//
//  UIImageView+RoundCorner.h
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RoundCorner)

/**
 * @brief 设置 imageView 的圆角,调用此方法之前,必须设置了 image,另外要保证 imageView 的背景色和父视图一致
 *
 * @param radius 半径
 */
- (void)ok_addRoundCornerWithRadius:(CGFloat)radius;

@end
