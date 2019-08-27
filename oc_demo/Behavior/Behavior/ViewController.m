//
//  ViewController.m
//  Behavior
//
//  Created by keymon on 2018/7/6.
//  Copyright © 2018 keymon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *objs = [self valueForKey:@"_topLevelObjectsToKeepAliveFromStoryboard"];
    NSDictionary *dict = [self valueForKey:@"_externalObjectsTableForViewLoading"];
    
    NSLog(@"%@--%@", objs, dict);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
