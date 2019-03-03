//
//  UIImage+RoundCorner.h
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundCorner)

/**
 * @brief 设置 image 图片的圆角
 *
 * @param radius 任意半径大小
 * @param size size
 * @return 返回圆角图片
 */
- (UIImage *)kw_addRoundCornerWithRadius:(CGFloat)radius size:(CGSize)size;

@end
