//
//  UIBezierPath+RoundCorner.m
//  qmui
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import "UIBezierPath+RoundCorner.h"

@implementation UIBezierPath (RoundCorner)

+ (UIBezierPath *)kw_bezierPathWithRoundRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor radiusArray:(NSArray<NSNumber *> *)radiusArray {
    CGFloat topLeftCornerRadius = radiusArray[0].floatValue;
    CGFloat bottomLeftCornerRadius = radiusArray[1].floatValue;
    CGFloat bottomRightCornerRadius = radiusArray[2].floatValue;
    CGFloat topRightCornerRadius = radiusArray[3].floatValue;
    CGFloat lineCenter = borderWidth / 2.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //有边框需求
    path.lineWidth = borderWidth;
    
    [path moveToPoint:CGPointMake(topLeftCornerRadius, lineCenter)];
    [path addArcWithCenter:CGPointMake(topLeftCornerRadius, topLeftCornerRadius) radius:topLeftCornerRadius - lineCenter startAngle:M_PI * 1.5 endAngle:M_PI clockwise:NO];
    [path addLineToPoint:CGPointMake(lineCenter, CGRectGetHeight(rect) - bottomLeftCornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomLeftCornerRadius, CGRectGetHeight(rect) - bottomLeftCornerRadius) radius:bottomLeftCornerRadius - lineCenter startAngle:M_PI endAngle:M_PI * 0.5 clockwise:NO];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - bottomRightCornerRadius, CGRectGetHeight(rect) - lineCenter)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(rect) - bottomRightCornerRadius, CGRectGetHeight(rect) - bottomRightCornerRadius) radius:bottomRightCornerRadius - lineCenter startAngle:M_PI * 0.5 endAngle:0.0 clockwise:NO];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(rect) - lineCenter, topRightCornerRadius)];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(rect) - topRightCornerRadius, topRightCornerRadius) radius:topRightCornerRadius - lineCenter startAngle:0.0 endAngle:M_PI * 1.5 clockwise:NO];
    [path closePath];
    
    return path;
}

@end
