//
//  UIView+RSEasyFrame.h
//  RSEasyLayout
//
//  Created by Rockstar on 12-12-26.
//  Copyright (c) 2012年 Neusoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RSEasyFrame)

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property CGFloat centerX;
@property CGFloat centerY;

- (CGPoint)topLeft;
- (CGPoint)topRight;
- (CGPoint)bottomRight;
- (CGPoint)bottomLeft;

@end
