//
//  RefreshControl.m
//  RefreshControl
//
//  Created by 小伴 on 2017/2/21.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "RefreshControl.h"

@implementation RefreshControl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, -TITLE_HEIGHT, gScreenWidth, TITLE_HEIGHT);
        [self setup];
    }
    return self;
}

- (void)setup {
    //do something, subclass can override...
}

- (instancetype)initWithHandler:(RefreshHandler)handler {
    self = [self init];
    if (self) {
        self.handler = handler;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self forKeyPath:@"contentOffset" context:NULL];

    if (newSuperview) {
        self.tableView = (UITableView *)newSuperview;
        self.superEdgeInsets = self.tableView.contentInset;

        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)pullRefresh {
    self.state = RefreshStateLoading;
}

- (void)stopRefresh {
    self.state = RefreshStateNormal;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.state == RefreshStateLoading) {
        return;
    }

    CGPoint point = [[change objectForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGFloat newOffsetThreshold = -TITLE_HEIGHT-self.tableView.contentInset.top;

    if (!self.tableView.isDragging && self.state == RefreshStateTrigger) {
        self.state = RefreshStateLoading;
    }
    else if (self.tableView.isDragging && point.y < newOffsetThreshold) {
        self.state = RefreshStateTrigger;
    }
    else if (point.y >= newOffsetThreshold) {
        self.state = RefreshStateNormal;
    }
}

@end
