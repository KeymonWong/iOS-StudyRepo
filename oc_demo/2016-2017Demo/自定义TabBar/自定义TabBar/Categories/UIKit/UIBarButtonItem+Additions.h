//
//  UIBarButtonItem+Additions.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/25.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Additions)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;
@end
