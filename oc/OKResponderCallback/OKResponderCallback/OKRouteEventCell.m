//
//  OKRouteEventCell.m
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKRouteEventCell.h"

#import "UIResponder+Router.h"

#import "OKEventName.h"

@interface OKRouteEventCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@property(nonatomic, strong) NSIndexPath *currentIndexPath;
@property(nonatomic, copy) NSDictionary *currentDict;
@end

@implementation OKRouteEventCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithData:(NSDictionary *)data indexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    self.currentDict = data;
    self.titleL.text = data[@"title"];
}

- (IBAction)handleRouteEvent:(UIButton *)sender {
    // 方式1：采用block回调的方式交互
    [self callbackViaBlock];
    
    // 方式2：采用基于响应链的方式交互
    [self callbackViaResponder];
}

- (void)callbackViaBlock {
    !self.routeBlock ?: self.routeBlock();
}

// 触发事件时
- (void)callbackViaResponder {
    UIViewController *vc = [self viewController];
    NSDictionary *userInfo = @{
                               @"indexPath" : self.currentIndexPath,
                               @"currentVC" : vc
                               };
    
    [self routerEventWithName:self.currentDict[@"eventName"] userInfo:userInfo];
}

// 这个可以写到 UIView 的分类里面
- (UIViewController *)viewController {
    for (UIView *next = [self superview]; next; next = [next superview]) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
