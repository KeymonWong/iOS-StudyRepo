//
//  ViewController.m
//  crashTest
//
//  Created by keymon on 2018/7/4.
//  Copyright © 2018 keymon. All rights reserved.
//

#import "ViewController.h"

int testParamGoThrough(int a1, int a2, int a3, int a4, int a5, int a6,
                       int a7, int a8, int a9, int a10, int a11)
{
    return a1 + a2 + a11;
}

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//Settings.bundle：为 App 在 系统“设置” 里面的设置，参考：https://blog.csdn.net/yang_chengfeng/article/details/52962385


//参数传递，打开 Debug -> Debug Workflow -> Always Show Disassembly，才能显示汇编代码
//须用真机打断点调试
/* ARM64指令集的寄存器
 * r0-r7 寄存器负责传参数
 * 超过8个的参数，通过栈传参
 * 参考：https://blog.cnbluebox.com/blog/2017/07/24/arm64-start/
 *      http://www.cocoachina.com/ios/20170802/20102.html
 */
- (IBAction)testParamGoThrough:(UIButton *)sender {
    testParamGoThrough(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
}

@end
