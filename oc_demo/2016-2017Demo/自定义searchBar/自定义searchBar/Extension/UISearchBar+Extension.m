//
//  UISearchBar+Extension.m
//  自定义searchBar
//
//  Created by 小伴 on 16/10/20.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "UISearchBar+Extension.h"
#import <objc/runtime.h>

#define kIOSVersion [[UIDevice currentDevice].systemVersion floatValue]

static const void *cancel_title_key = &cancel_title_key;
static const void *text_color_key = &text_color_key;
static const void *text_font_key = &text_font_key;

@implementation UISearchBar (Extension)

#pragma mark - setter & getter

- (void)setCancelTitle:(NSString *)cancelTitle {
    if (kIOSVersion >= 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:cancelTitle];
    } else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:cancelTitle];
    }

    objc_setAssociatedObject(self, cancel_title_key, cancelTitle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)cancelTitle {
    return [objc_getAssociatedObject(self, cancel_title_key) string];
}

- (void)setTextFont:(UIFont *)textFont {
    if (kIOSVersion >= 9.0) {
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setFont:textFont];
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:textFont];
    }

    objc_setAssociatedObject(self, text_font_key, textFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)textFont {
    return objc_getAssociatedObject(self, text_font_key);
}

- (void)setTextColor:(UIColor *)textColor {
    if (kIOSVersion >= 9.0) {
        [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTextColor:textColor];
    } else {
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:textColor];
    }

    objc_setAssociatedObject(self, text_color_key, textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)textColor {
    return objc_getAssociatedObject(self, text_color_key);
}

@end
