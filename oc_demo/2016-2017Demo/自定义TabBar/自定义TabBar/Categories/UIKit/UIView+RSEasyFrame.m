//
//  UIView+RSEasyFrame.m
//  RSEasyLayout
//
//  Created by Rockstar on 12-12-26.
//  Copyright (c) 2012年 Neusoft. All rights reserved.
//

#import "UIView+RSEasyFrame.h"

@implementation UIView (RSEasyFrame)

#pragma mark - Setters

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGSize size = self.size;
    size.width = width;
    self.size = size;
}

- (void)setHeight:(CGFloat)height {
    CGSize size = self.size;
    size.height = height;
    self.size = size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGPoint origin = self.origin;
    origin.x = x;
    self.origin = origin;
}

- (void)setY:(CGFloat)y {
    CGPoint origin = self.origin;
    origin.y = y;
    self.origin = origin;
}

- (void)setTop:(CGFloat)top {
    CGPoint origin = self.origin;
    origin.y = top;
    self.origin = origin;
}

- (void)setLeft:(CGFloat)left {
    CGPoint origin = self.origin;
    origin.x = left;
    self.origin = origin;
}

- (void)setBottom:(CGFloat)bottom {
    CGSize size = self.size;
    size.height = bottom - self.origin.y;
    self.size = size;
}

- (void)setRight:(CGFloat)right {
    CGSize size = self.size;
    size.width = right - self.origin.x;
    self.size = size;
}

#pragma mark - Getters

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.size.width;
}

- (CGFloat)height {
    return self.size.height;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)x {
    return self.origin.x;
}

- (CGFloat)y {
    return self.origin.y;
}

- (CGFloat)top {
    return self.origin.y;
}

- (CGFloat)left {
    return self.origin.x;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGPoint)topLeft {
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}

- (CGPoint)topRight {
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame));
}

- (CGPoint)bottomRight {
    return CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame));
}

- (CGPoint)bottomLeft {
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame));
}

-(void) setCenterY:(CGFloat) y
{
    CGPoint pt = self.center;
    pt.y = y;
    self.center = pt;
}

-(void) setCenterX:(CGFloat) x
{
    CGPoint pt = self.center;
    pt.x = x;
    self.center = pt;
}

-(CGFloat) centerX
{
    return self.center.x;
}

-(CGFloat) centerY
{
    return self.center.y;
}

@end
