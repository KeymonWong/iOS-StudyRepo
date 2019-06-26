//
//  TestCell.m
//  Corner
//
//  Created by keymon on 2018/8/17.
//  Copyright © 2018 KeymonWong. All rights reserved.
//

#import "TestCell.h"

#import "UIView+RoundCorner.h"
#import "UIImageView+RoundCorner.h"

@interface TestCell ()

@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;

@end

@implementation TestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImgV.image = [UIImage imageNamed:@"xiaobandriver1024"];
    self.imgV2.image = [UIImage imageNamed:@"xiaobandriver1024"];
    self.imgV3.image = [UIImage imageNamed:@"xiaobandriver1024"];
    
//    self.avatarImgV.layer.cornerRadius = 50*0.5;
//    self.avatarImgV.layer.masksToBounds = YES;
//    self.imgV2.layer.cornerRadius = 10.;
//    self.imgV2.layer.masksToBounds = YES;
//    self.imgV3.layer.cornerRadius = 20.;
//    self.imgV3.layer.masksToBounds = YES;
    
    [self.avatarImgV ok_addRoundCornerWithRadius:50*0.5];
    [self.imgV2 ok_addRoundCornerWithRadius:10.];
    [self.imgV3 ok_addRoundCornerWithRadius:20.];
    
    
//    self.bgV.layer.cornerRadius = 10.;
//    self.bgV.layer.masksToBounds = YES;
    
    [self.bgV ok_addRoundCornersWithRect:CGRectMake(0, 0, self.bgV.frame.size.width, 100) backgroundColor:[UIColor whiteColor] borderColor:nil borderWidth:0 cornerRadius:10 roundCornerTypes:UIRectCornerTopLeft|UIRectCornerBottomRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
