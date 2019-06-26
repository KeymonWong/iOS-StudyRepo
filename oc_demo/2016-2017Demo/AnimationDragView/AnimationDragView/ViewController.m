//
//  ViewController.m
//  AnimationDragView
//
//  Created by 小伴 on 2017/2/17.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "ViewController.h"

#import "UIView+Draggable.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.avatarImgView.userInteractionEnabled = YES;
    self.tipLabel.userInteractionEnabled = YES;

    self.avatarImgView.layer.cornerRadius = 100*0.5;
    self.avatarImgView.layer.masksToBounds = YES;
//    self.avatarImgView.image = [UIImage imageNamed:@"me"];

    [self.avatarImgView makeDraggable];
    [self.tipLabel makeDraggable];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    [self.avatarImgView updateSnapPoint];
}


@end
