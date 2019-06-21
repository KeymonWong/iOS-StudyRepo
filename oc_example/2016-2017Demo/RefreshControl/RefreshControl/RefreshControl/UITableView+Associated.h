//
//  UITableView+Associated.h
//  RefreshControl
//
//  Created by 小伴 on 2017/2/22.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RefreshView;

@interface UITableView (Associated)
@property (nonatomic, strong) RefreshView *refreshView;
@end
