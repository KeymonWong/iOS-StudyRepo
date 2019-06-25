//
//  RefreshControl.h
//  RefreshControl
//
//  Created by 小伴 on 2017/2/21.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshDefault.h"

@interface RefreshControl : UIView
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) UIEdgeInsets superEdgeInsets;
@property (nonatomic, assign) RefreshState state;
@property (nonatomic, copy) RefreshHandler handler;

- (instancetype)initWithHandler:(RefreshHandler)handler;
- (void)pullRefresh;
- (void)stopRefresh;
- (void)setup;

@end
