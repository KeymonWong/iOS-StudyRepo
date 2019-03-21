//
//  ViewController.m
//  ParentEnd
//
//  Created by keymon on 2019/3/21.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"
#import <LoginLib/LoginLib.h>




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    [vc run];
}


@end
