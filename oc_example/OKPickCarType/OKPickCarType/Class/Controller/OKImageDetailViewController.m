//
//  OKImageDetailViewController.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/15.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKImageDetailViewController.h"

@interface OKImageDetailViewController ()
@property (nonatomic, weak) UIImageView *imgV;
@end

@implementation OKImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = self.mode;
    
    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor blackColor];
//        imgV.clipsToBounds = YES;
        self.imgV = imgV;
        imgV;
    })];
    
    /**
     注意以上几个常量，凡是没有带Scale的，当图片尺寸超过imageView尺寸时，只有部分显示在imageView中。
     UIViewContentModeScaleToFill属性会导致图片变形。充满imageView的bounds
     UIViewContentModeScaleAspectFit会保证图片比例不变，而且全部显示在imageView中，这意味着imageView会有部分空白。
     UIViewContentModeScaleAspectFill也会证图片比例不变，但是会填充满整个imageView的，可能只有部分图片显示出来。
     
     下面 红色框 为 imageView 的 bounds 边界，
     红色框里面即 imageView 显示出来的图片是用户看到的，需要设置imgV.clipsToBounds = YES;
     注释掉 imgV.clipsToBounds = YES;，只是为了让你看到不同的 contentMode 模式下当 image 尺寸超过 imageView 尺寸时对 image 的影响
     */
    UIViewContentMode imageContentMode = UIViewContentModeScaleToFill;
    if ([self.mode isEqualToString:@"UIViewContentModeScaleToFill"]) {
        imageContentMode = UIViewContentModeScaleToFill;
    } else if ([self.mode isEqualToString:@"UIViewContentModeScaleAspectFit"]) {
        imageContentMode = UIViewContentModeScaleAspectFit;
    } else if ([self.mode isEqualToString:@"UIViewContentModeScaleAspectFill"]) {
        imageContentMode = UIViewContentModeScaleAspectFill;
    } else if ([self.mode isEqualToString:@"UIViewContentModeCenter"]) {
        imageContentMode = UIViewContentModeCenter;
    } else if ([self.mode isEqualToString:@"UIViewContentModeTop"]) {
        imageContentMode = UIViewContentModeTop;
    } else if ([self.mode isEqualToString:@"UIViewContentModeBottom"]) {
        imageContentMode = UIViewContentModeBottom;
    } else if ([self.mode isEqualToString:@"UIViewContentModeLeft"]) {
        imageContentMode = UIViewContentModeLeft;
    } else if ([self.mode isEqualToString:@"UIViewContentModeRight"]) {
        imageContentMode = UIViewContentModeRight;
    } else if ([self.mode isEqualToString:@"UIViewContentModeTopLeft"]) {
        imageContentMode = UIViewContentModeTopLeft;
    } else if ([self.mode isEqualToString:@"UIViewContentModeTopRight"]) {
        imageContentMode = UIViewContentModeTopRight;
    } else if ([self.mode isEqualToString:@"UIViewContentModeBottomLeft"]) {
        imageContentMode = UIViewContentModeBottomLeft;
    } else if ([self.mode isEqualToString:@"UIViewContentModeBottomRight"]) {
        imageContentMode = UIViewContentModeBottomRight;
    }
    self.imgV.contentMode = imageContentMode;
    self.imgV.frame = CGRectMake(100, 100, 200, 200);
    self.imgV.layer.borderWidth = 2;
    self.imgV.layer.borderColor = [UIColor redColor].CGColor;
    
    // 从网络上加载到的未知图片，宽高只有图片下载下来，才能知道 size
    // image 尺寸超过 imageView 尺寸，不管宽高
    UIImage *unknown1 = [UIImage imageNamed:@"changtu"];
    self.imgV.image = unknown1;
    
    // image 尺寸不超过 imageView 尺寸，不管宽高
//    UIImage *unknown2 = [UIImage imageNamed:@"ole_icon_carpool"];
//    self.imgV.image = unknown2;
    
//    UIImage *unknown3 = [UIImage imageNamed:@"gaotu"];
//    self.imgV.image = unknown3;
    
}

@end
