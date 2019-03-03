//
//  UIBezierPath+RoundCorner.h
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIBezierPath (RoundCorner)

/**
 * @brief 创建一条支持四个角的圆角半径不相同的路径:
 *        若仅仅调用 [path fill] 则 borderWidth 必需设置为0；
 *        若仅仅调用 [path stroke] 生成边框的路径,则 borderWidth 不能设置为0；
 *        若同时调用 [path fill];[path stroke],则 borderWidth 可以设置为任意值。
 *
 * @param rect 路径的rect
 * @param borderWidth 边框大小,如果不需要描边（例如path是用于fill而不是用于stroke）,则填0
 * @param borderColor 边框颜色
 * @param radiusArray 4个圆角半径数组,长度必须为4,顺序分别为[左上角、左下角、右下角、右上角]
 * @return 四个角的圆角半径不相同的路径
 */
+ (UIBezierPath *)ok_bezierPathWithRoundRect:(CGRect)rect
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(UIColor *)borderColor
                                 radiusArray:(NSArray<NSNumber *> *)radiusArray;
@end
