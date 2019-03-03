//
//  UIView+RoundCorner.m
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import "UIView+RoundCorner.h"

@implementation UIView (RoundCorner)

- (void)kw_addRoundCornersWithRect:(CGRect)rect
                   backgroundColor:(UIColor *)backgroundColor
                       borderColor:(UIColor *)borderColor
                       borderWidth:(CGFloat)borderWidth
                      cornerRadius:(CGFloat)cornerRadius
                  roundCornerTypes:(UIRectCorner)cornerTypes
{
    UIImage *cornerBgImg = [self drawRoundCornerWithRect:rect fillColor:backgroundColor borderColor:borderColor borderWidth:borderWidth cornerRadius:cornerRadius roundCornerTypes:cornerTypes];
    UIImageView *bgImgView = [[UIImageView alloc] initWithImage:cornerBgImg];
    [self insertSubview:bgImgView atIndex:0];
}

#pragma mark - private method，生成一个背景图片

- (UIImage *)drawRoundCornerWithRect:(CGRect)rect
                           fillColor:(UIColor *)fillColor
                         borderColor:(UIColor *)borderColor
                         borderWidth:(CGFloat)borderWidth
                        cornerRadius:(CGFloat)cornerRadius
                    roundCornerTypes:(UIRectCorner)cornerTypes
{
//    CGFloat bottomRightCornerRadius = cornerRadiuses[0].floatValue;
//    CGFloat bottomLeftCornerRadius = cornerRadiuses[1].floatValue;
//    CGFloat topLeftCornerRadius = cornerRadiuses[2].floatValue;
//    CGFloat topRightCornerRadius = cornerRadiuses[3].floatValue;
//    CGFloat semiBorderWidth = borderWidth * 0.5;
    
    CGSize size = rect.size;
    
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    //开始坐标 右边开始
//    CGContextMoveToPoint(ctx, width - semiBorderWidth, bottomRightCornerRadius + semiBorderWidth);
//    //右下角
//    CGContextAddArcToPoint(ctx, width - semiBorderWidth, height - semiBorderWidth, width - bottomRightCornerRadius - semiBorderWidth, height - semiBorderWidth, bottomRightCornerRadius);
//    //左下角
//    CGContextAddArcToPoint(ctx, semiBorderWidth, height - semiBorderWidth, semiBorderWidth, height - bottomLeftCornerRadius - semiBorderWidth, bottomLeftCornerRadius);
//    //左上角
//    CGContextAddArcToPoint(ctx, semiBorderWidth, semiBorderWidth, width - semiBorderWidth, semiBorderWidth, topLeftCornerRadius);
//    //右上角
//    CGContextAddArcToPoint(ctx, width - semiBorderWidth, semiBorderWidth, width - semiBorderWidth, topRightCornerRadius + semiBorderWidth, topRightCornerRadius);
//    
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:cornerTypes cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
//    CGContextSetLineWidth(ctx, borderWidth);
//    CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
    CGContextSetShadow(ctx, CGSizeMake(0, 1), 0.4);

    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
//    CGContextSetShadowWithColor(ctx, CGSizeMake(1, 1), 0.3, [UIColor redColor].CGColor);

    CGContextAddPath(ctx, path.CGPath);
//    CGContextClip(ctx);

//    [self.layer renderInContext:ctx];

//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    [path addClip];
    [path fill];

    //再设置画笔颜色
    path.lineWidth = borderWidth;
    [borderColor set];
    [path stroke];
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}
@end
