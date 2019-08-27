//
//  LoginViewModel.m
//  Behavior
//
//  Created by keymon on 2018/7/6.
//  Copyright © 2018 keymon. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (void)loginAction:(id)sender {
    NSLog(@"hhhh");
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
}

@end
