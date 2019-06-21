//
//  UIView+Overlap.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/28.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Overlap)
/** 判断self和anotherView是否重叠 */
- (BOOL)is_intersectsWithAnotherView:(UIView *)anotherView;
@end
