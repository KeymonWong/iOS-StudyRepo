//
//  ViewController.m
//  native-weex
//
//  Created by keymon on 2020/3/26.
//  Copyright © 2020 okay. All rights reserved.
//

#import "ViewController.h"
#import "WeexViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)goWeexPage:(UIButton *)sender {
    WeexViewController *vc = [[WeexViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
