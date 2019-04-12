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
    [self callbackViaBlock];
    
    [self callbackViaResponder];
}

- (void)callbackViaBlock {
    !self.routeBlock ?: self.routeBlock();
}

// 触发事件时
- (void)callbackViaResponder {
    [self routerEventWithName:self.currentDict[@"eventName"] userInfo:@{@"indexPath" : self.currentIndexPath}];
}

@end
