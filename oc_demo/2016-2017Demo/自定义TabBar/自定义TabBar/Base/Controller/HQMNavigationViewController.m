//
//  HQMNavigationViewController.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMNavigationViewController.h"

#import "UIImage+ColorToImage.h"

@interface HQMNavigationViewController ()

@end

@implementation HQMNavigationViewController

+ (void)initialize {
    UIBarButtonItem *item = [UIBarButtonItem appearance];

    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(252, 217, 83, 1), NSFontAttributeName : [UIFont systemFontOfSize:13.]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(123, 123, 123, 1), NSFontAttributeName : [UIFont systemFontOfSize:13.]} forState:UIControlStateDisabled];

    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];

//    [bar setBackgroundColor:[UIColor redColor]];
//    [bar setBarTintColor:[UIColor greenColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.viewControllers count] > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back_withtext" highlightedImage:@"navigationbar_back_withtext_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
