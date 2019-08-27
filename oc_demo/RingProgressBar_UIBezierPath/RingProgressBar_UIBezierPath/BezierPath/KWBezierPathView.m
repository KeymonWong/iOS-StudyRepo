//
//  KWBezierPathView.m
//  RingProgressBar_UIBezierPath
//
//  Created by keymon on 2018/8/9.
//  Copyright © 2018 xiaoban. All rights reserved.
//

#import "KWBezierPathView.h"

@implementation KWBezierPathView

- (void)drawRect:(CGRect)rect {
//    [self drawTrianglePath];
//    [self drawRectPath];
//    [self drawCirclePath];
//    [self drawOvalPath];
    [self drawRoundedCornerPath];
//    [self drawArcPath];
//    [self drawSecondBezierPath];
//    [self drawThirdBezierPath];
}

#pragma mark - 画三角形
- (void)drawTrianglePath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(60, 60)];
    [path addLineToPoint:CGPointMake(self.frame.size.width-60*2, 60)];
    [path addLineToPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height-60)];
    
    //最后的闭合线可以通过调用 closePath 方法自动生成，也可以调用 -addLineToPoint: 添加
//    [path addLineToPoint:CGPointMake(60, 60)];
    
    [path closePath];
    
    //设线宽
    path.lineWidth = 1.5;
    
    //先设置填充颜色
    UIColor *fillColor = [UIColor redColor];
    [fillColor set];
    [path fill];
    
    //再设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    //根据我们的设置的各个点连线
    [path stroke];
}

#pragma mark - 画矩形
- (void)drawRectPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, self.frame.size.width-20*2, self.frame.size.height-20*2)];
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    //先设置填充颜色
    UIColor *fillColor = [UIColor yellowColor];
    [fillColor set];
    [path fill];
    
    //再设置画笔颜色
    UIColor *strokeColor = [UIColor cyanColor];
    [strokeColor set];
    
    [path stroke];
}

#pragma mark - 画圆
- (void)drawCirclePath {
    //传的 rect 是正方形，画出来的就是圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    
    //先设置填充颜色
    UIColor *fillColor = [UIColor purpleColor];
    [fillColor set];
    [path fill];
    
    //再设置画笔颜色
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    
    [path stroke];
}

#pragma mark - 画椭圆
- (void)drawOvalPath {
    //传的 rect 不是正方形，画出来的就是椭圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 120, 120, 80)];
    
    //先设置填充颜色
    UIColor *fillColor = [UIColor orangeColor];
    [fillColor set];
    [path fill];
    
    //在设置画笔颜色
    UIColor *strokeColor = [UIColor grayColor];
    [strokeColor set];
    
    [path stroke];
}

#pragma mark - 画圆角
- (void)drawRoundedCornerPath {
    //如果要画只有一个角是圆角的,很容易地给UIView扩展添加圆角的方法
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 80, 80) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    //如果要画所有角都是圆角的
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(300, 300, 80, 80) cornerRadius:20];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
//    UIColor *strokeColor = [UIColor purpleColor];
//    [strokeColor set];
    
    [path stroke];
}

#define kDegreesToRadians(degrees) ((pi * degrees)/180)

#pragma mark - 画弧
- (void)drawArcPath {
    const CGFloat pi = 3.14159265359;
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:100 startAngle:0 endAngle:kDegreesToRadians(135.) clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 4.;
    
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    [path stroke];
}

#pragma mark - 画二次贝塞尔曲线
- (void)drawSecondBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //首先设置一个起始点
    [path moveToPoint:CGPointMake(50, self.frame.size.height-100)];
    
    //添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(self.frame.size.width-20, self.frame.size.height-100)
                 controlPoint:CGPointMake(self.frame.size.width/2, 0)];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
}

#pragma mark - 画三次贝塞尔曲线，画三次贝塞尔曲线的关键方法，以三个点画一段曲线，一般和-moveToPoint:配合使用，贝塞尔曲线必定通过首尾两个点，称为端点；中间两个点虽然未必要通过，但却起到牵制曲线形状路径的作用，称作控制点。
- (void)drawThirdBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //设置起始端点
    [path moveToPoint:CGPointMake(30, 160)];
    
    [path addCurveToPoint:CGPointMake(300, 150)
            controlPoint1:CGPointMake(160, 0)
            controlPoint2:CGPointMake(160, 250)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 6.;
    
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    
    [path stroke];
}

@end
