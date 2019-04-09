//
//  ViewController.m
//  PerfectSingleton
//
//  Created by keymon on 2019/2/26.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"

#import "OKSingleton.h"
#import "OKSingletonB.h"
#import "OKSingletonC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //温柔派
    OKSingleton *a1 = [[OKSingleton alloc] init];
    OKSingleton *a2 = [OKSingleton new];
    OKSingleton *a3 = [OKSingleton sharedInstance];
    [a3 copy];
    [a3 mutableCopy];
    
    OKSingletonC *c1 = [OKSingletonC sharedInstance];
    
    //冷酷派，注释掉温柔派的代码，断点调试 查看 下面对象的内存地址
    OKSingletonB *b1 = [[OKSingletonB alloc] init];
    OKSingletonB *b2 = [OKSingletonB new];
    OKSingletonB *b3 = [OKSingletonB sharedInstance];
    OKSingletonB *b4 = [b3 copy];
    OKSingletonB *b5 = [b3 mutableCopy];
    
}


@end
