//
//  UIImage+ColorToImage.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/22.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "UIImage+ColorToImage.h"

@implementation UIImage (ColorToImage)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0., 0., 1., 1.);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
