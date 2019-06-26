//
//  HQMRootViewController.m
//  objc-KVO
//
//  Created by 小伴 on 16/6/29.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMRootViewController.h"

//#import "HQMNextViewController.h"

#import "HQMPerson.h"

@interface HQMRootViewController ()
@property (nonatomic, strong) HQMPerson *person;
@end

@implementation HQMRootViewController

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建的是局部变量，出了当前viewDidLoad方法就会被释放
    HQMPerson *person = [[HQMPerson alloc] init];

    //崩
//    [person addObserver:self
//             forKeyPath:@"name"
//                options:NSKeyValueObservingOptionNew
//                context:nil];

    //不崩
    // retain 一下，保证不会被释放
    self.person = person;
    NSLog(@"\n//断点1");
    NSLog(@"");

    [self.person addObserver:self
                  forKeyPath:@"name"
                     options:NSKeyValueObservingOptionNew
                     context:@"一样不"];
    NSLog(@"\n//断点2");
    NSLog(@"");

    NSLog(@"\n重写 setter 方法");
    self.person.name = @"小萌萌";
    NSLog(@"");

    [self.person removeObserver:self
                     forKeyPath:@"name"
                        context:@"不一样"];//不一样
    NSLog(@"\n//断点3");
    NSLog(@"");

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
//        NSLog(@"%s", __func__);
    }
}

//- (IBAction)pushToNextVC:(UIButton *)sender {
//    HQMNextViewController *nextVC = [[HQMNextViewController alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
