//
//  UIImageView+RoundCorner.m
//  Corner
//
//  Created by keymon on 2017/3/15.
//  Copyright © 2017 KeymonWong. All rights reserved.
//

#import "UIImageView+RoundCorner.h"
#import "UIImage+RoundCorner.h"

@implementation UIImageView (RoundCorner)

- (void)kw_addRoundCornerWithRadius:(CGFloat)radius {
    self.image = [self.image kw_addRoundCornerWithRadius:radius size:self.frame.size];
}

@end
