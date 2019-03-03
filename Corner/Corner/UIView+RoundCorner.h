//
//  UIView+RoundCorner.h
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

/**
 * @brief 给 view 添加圆角,若view为子view,则该子view的背景颜色要和父视图一致
 *
 * @param rect 路径的rect
 * @param backgroundColor view的背景颜色，即填充颜色
 * @param borderColor 边框颜色，如果不需要边框（例如path是用于fill而不是用于stroke），则borderWidth填0
 * @param borderWidth 边框宽度，如果不需要边框（例如path是用于fill而不是用于stroke），则borderWidth填0
 * @param cornerRadius 圆角半径
 * @param cornerTypes UIRectCorner枚举类型的圆角type
 */
- (void)ok_addRoundCornersWithRect:(CGRect)rect
                   backgroundColor:(UIColor *)backgroundColor
                       borderColor:(UIColor *)borderColor
                       borderWidth:(CGFloat)borderWidth
                      cornerRadius:(CGFloat)cornerRadius
                  roundCornerTypes:(UIRectCorner)cornerTypes;

@end
