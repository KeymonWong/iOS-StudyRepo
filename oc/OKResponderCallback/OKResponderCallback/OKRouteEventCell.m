//
//  OKRouteEventCell.m
//  OKSnippet
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKRouteEventCell.h"

#import "UIResponder+Router.h"

@implementation OKRouteEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)handleRouteEvent:(UIButton *)sender {
    [self callbackViaBlock];
    
    [self callbackViaResponder];
}

- (void)callbackViaBlock {
    !self.routeBlock ?: self.routeBlock();
}

// 触发事件时
- (void)callbackViaResponder {
    [self routerEventWithName:@"router" userInfo:@{@"key" : @"success"}];
}

@end
