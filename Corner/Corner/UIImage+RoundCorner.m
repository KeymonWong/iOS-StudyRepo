//
//  UIImage+RoundCorner.m
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import "UIImage+RoundCorner.h"

@implementation UIImage (RoundCorner)

#pragma mark - 圆角图片绘制

- (UIImage *)ok_addRoundCornerWithRadius:(CGFloat)radius size:(CGSize)size {
    CGRect rect = CGRectMake(2, 2, size.width-4, size.height-4);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    
    UIColor *borderColor = [UIColor blackColor];
    [borderColor setStroke];
    
//    [path addClip];
//    [self drawAtPoint:CGPointZero];
    
    path.lineWidth = 2.;
    [path strokeWithBlendMode:kCGBlendModeScreen alpha:0.3];
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
//    CGContextSetLineWidth(ctx, 1.);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    UIImage *neuImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return neuImage;
}

@end
