//
//  HQMSearchBar.m
//  自定义searchBar
//
//  Created by 小伴 on 16/10/20.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMSearchBar.h"
#import "UISearchBar+Extension.h"

@implementation HQMSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //1.改变默认搜索文字
    self.placeholder = @"请输入黄小萌";
    //2.默认取消文字和颜色
    self.showsCancelButton = YES;
    self.barTintColor = [UIColor blueColor];
    //3.设置搜索框
    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor greenColor]];
        searchField.layer.cornerRadius = 5.;
        searchField.layer.masksToBounds = YES;

        //光标颜色
        [searchField setTintColor:[UIColor redColor]];
    }

    //4.背景区域
    self.backgroundImage = [[UIImage alloc] init];

    //5.设置输入文本大小及颜色
    self.textColor = [UIColor blueColor];
    self.textFont = [UIFont systemFontOfSize:14.];

    self.cancelTitle = @"点我";
}

@end
