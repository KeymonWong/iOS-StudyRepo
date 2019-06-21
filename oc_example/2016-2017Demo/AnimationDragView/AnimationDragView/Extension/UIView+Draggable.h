//
//  UIView+Draggable.h
//  AnimationDragView
//
//  Created by huang qimeng on 2017/2/17.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Draggable)

- (void)makeDraggable;
/**
 Make view draggable

 @param view Reference view, usually is super view.
 @param damping Value 0.0->1.0, 0.0 is the least oscillation, default is 0.4.
 */
- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping;

/**
 Disable view draggable
 */
- (void)removeDraggable;

/**
 If you call `-makeDraggable` or `-makeDraggableInView:damping:` method in the initialize method 
 such as `-initWithFrame:` or `-viewDidLoad`, the view may not be layout correctly at that time.
 So you should update snap point in `-layoutSubviews` or `-viewDidLayoutSubviews`.
 
 By the way, you can call make draggable method in `-layoutSubviews` or
 `-viewDidLayoutSubviews` directly instead of update snap point.
 */
- (void)updateSnapPoint;

@end
