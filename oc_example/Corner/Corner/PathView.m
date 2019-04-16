//
//  PathView.m
//  Corner
//
//  Created by keymon on 2018/8/15.
//  Copyright © 2018 KeymonWong. All rights reserved.
//

#import "PathView.h"

#import "UIBezierPath+RoundCorner.h"


@implementation PathView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath ok_bezierPathWithRoundRect:rect borderWidth:0 borderColor:[UIColor redColor] radiusArray:@[@10,@20,@6,@0]];
    
    //先设置填充颜色
    UIColor *fillColor = [UIColor purpleColor];
    [fillColor set];
    [path fill];
    
    [[UIColor redColor] set];
    [path stroke];
}

@end
