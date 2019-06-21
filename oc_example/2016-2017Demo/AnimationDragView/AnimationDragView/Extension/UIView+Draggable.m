//
//  UIView+Draggable.m
//  AnimationDragView
//
//  Created by huang qimeng on 2017/2/17.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "UIView+Draggable.h"
#import <objc/runtime.h>

@implementation UIView (Draggable)

- (void)makeDraggable {
    NSAssert(self.superview, @"Super view is required when make view draggable!");

    [self makeDraggableInView:self.superview damping:0.5];
}

- (void)makeDraggableInView:(UIView *)view damping:(CGFloat)damping {
    if (!view) {
        return;
    }
    [self removeDraggable];

    self.playGroundView = view;
    self.damping = damping;

    [self createAnimator];
    [self addPanGesture];
}

- (void)removeDraggable {
    [self removeGestureRecognizer:self.panGesture];

    self.panGesture = nil;
    self.playGroundView = nil;
    self.animator = nil;
    self.snapBehavior = nil;
    self.attachmentBehavior = nil;
    self.centerPoint = CGPointZero;
}

- (void)createAnimator {
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.playGroundView];
    [self updateSnapPoint];
}

- (void)updateSnapPoint {
    self.centerPoint = [self convertPoint:CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5) toView:self.playGroundView];
    self.snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.centerPoint];
    self.snapBehavior.damping = self.damping;
}

- (void)addPanGesture {
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:self.panGesture];
}

- (void)panGesture:(UIPanGestureRecognizer *)panGR {
    CGPoint panLoc = [panGR locationInView:self.playGroundView];

    if (panGR.state == UIGestureRecognizerStateBegan) {
        UIOffset offset = UIOffsetMake(panLoc.x-self.centerPoint.x, panLoc.y-self.centerPoint.y);
        [self.animator removeAllBehaviors];
        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self offsetFromCenter:offset attachedToAnchor:panLoc];
        [self.animator addBehavior:self.attachmentBehavior];
    }
    else if (panGR.state == UIGestureRecognizerStateChanged) {
        [self.attachmentBehavior setAnchorPoint:panLoc];
    }
    else if (panGR.state == UIGestureRecognizerStateEnded ||
             panGR.state == UIGestureRecognizerStateFailed ||
             panGR.state == UIGestureRecognizerStateCancelled)
    {
        [self.animator removeAllBehaviors];
        [self.animator addBehavior:self.snapBehavior];
    }
}

#pragma mark - Associated Object
- (void)setPlayGroundView:(id)obj {
    objc_setAssociatedObject(self, @selector(playGroundView), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)playGroundView {
    return objc_getAssociatedObject(self, @selector(playGroundView));
}

- (void)setDamping:(CGFloat)damping {
    objc_setAssociatedObject(self, @selector(damping), @(damping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)damping {
    return [objc_getAssociatedObject(self, @selector(damping)) floatValue];
}

- (void)setPanGesture:(id)obj {
    objc_setAssociatedObject(self, @selector(panGesture), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIPanGestureRecognizer *)panGesture {
    return objc_getAssociatedObject(self, @selector(panGesture));
}

- (void)setAnimator:(id)obj {
    objc_setAssociatedObject(self, @selector(animator), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIDynamicAnimator *)animator {
    return objc_getAssociatedObject(self, @selector(animator));
}

- (void)setSnapBehavior:(id)obj {
    objc_setAssociatedObject(self, @selector(snapBehavior), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UISnapBehavior *)snapBehavior {
    return objc_getAssociatedObject(self, @selector(snapBehavior));
}

- (void)setAttachmentBehavior:(id)obj {
    objc_setAssociatedObject(self, @selector(attachmentBehavior), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIAttachmentBehavior *)attachmentBehavior {
    return objc_getAssociatedObject(self, @selector(attachmentBehavior));
}

- (void)setCenterPoint:(CGPoint)point {
    objc_setAssociatedObject(self, @selector(centerPoint), [NSValue valueWithCGPoint:point], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGPoint)centerPoint {
    return [objc_getAssociatedObject(self, @selector(centerPoint)) CGPointValue];
}

@end
