//
//  DrawImage.m
//  oclint_demo_command
//
//  Created by keymon on 2019/5/21.
//  Copyright © 2019 ok. All rights reserved.
//

#import "DrawImage.h"

@implementation DrawImage

- (void)drawInRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetShadowWithColor (context, CGSizeMake(10.0, 10.0), 5, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(10.0, 400.0, 100.0, 100.0));
    CGContextRestoreGState(context);
}

@end
