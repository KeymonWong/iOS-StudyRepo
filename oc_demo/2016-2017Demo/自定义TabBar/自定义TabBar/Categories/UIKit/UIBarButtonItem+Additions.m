//
//  UIBarButtonItem+Additions.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/25.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"

@implementation UIBarButtonItem (Additions)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage {
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    itemBtn.size = itemBtn.currentBackgroundImage.size;
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    return item;
}
@end
