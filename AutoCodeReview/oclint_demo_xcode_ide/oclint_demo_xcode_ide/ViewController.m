//
//  ViewController.m
//  oclint_demo_xcode_ide
//
//  Created by keymon on 2019/5/19.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)getValueForKey:(NSString *)key {
    NSData *valueData = [self getValueData];
    if (valueData != nil) {
        NSString *value = [[NSString alloc] initWithData:valueData encoding:NSUTF8StringEncoding];
        return value;
    } else {
        return nil;
    }
}

- (NSData *)getValueData {
    return [@"这是哈哈哈或" dataUsingEncoding:NSUTF8StringEncoding];
}

@end
