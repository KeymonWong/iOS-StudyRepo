//
//  HQMLoginViewController.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMLoginViewController.h"

@interface HQMLoginViewController ()

@end

@implementation HQMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    HQMNavigationViewController *baseNav = [[HQMNavigationViewController alloc] initWithRootViewController:self];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(dismiss) image:@"navigationbar_close" highlightedImage:@"navigationbar_close_highlighted"];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
