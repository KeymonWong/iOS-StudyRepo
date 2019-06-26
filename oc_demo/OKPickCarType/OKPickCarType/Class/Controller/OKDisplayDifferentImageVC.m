//
//  OKDisplayDifferentImageVC.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/12.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKDisplayDifferentImageVC.h"

#import <Masonry.h>

@interface OKDisplayDifferentImageVC ()
@property (nonatomic, weak) UIImageView *imgV1;
@property (nonatomic, weak) UILabel *markL1;

@property (nonatomic, weak) UIImageView *imgV2;
@property (nonatomic, weak) UILabel *markL2;

@property (nonatomic, weak) UIImageView *imgV3;
@property (nonatomic, weak) UILabel *markL3;

@property (nonatomic, weak) UIImageView *imgV4;
@property (nonatomic, weak) UILabel *markL4;

@property (nonatomic, weak) UIImageView *imgV5;
@property (nonatomic, weak) UILabel *markL5;

@property (nonatomic, weak) UIImageView *imgV6;
@property (nonatomic, weak) UILabel *markL6;

@end

@implementation OKDisplayDifferentImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor redColor];
        imgV.clipsToBounds = YES;
        self.imgV1 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL1 = label;
        label;
    })];

    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor purpleColor];
        imgV.clipsToBounds = YES;
        self.imgV2 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL2 = label;
        label;
    })];

    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor greenColor];
        imgV.clipsToBounds = YES;
        self.imgV3 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL3 = label;
        label;
    })];

    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor blueColor];
        imgV.clipsToBounds = YES;
        self.imgV4 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL4 = label;
        label;
    })];

    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor blueColor];
        imgV.clipsToBounds = YES;
        self.imgV5 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL5 = label;
        label;
    })];

    [self.view addSubview:({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.backgroundColor = [UIColor yellowColor];
        imgV.clipsToBounds = YES;
        self.imgV6 = imgV;
        imgV;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        self.markL6 = label;
        label;
    })];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 从网络上加载到的未知图片，宽高只有图片下载下来，才能知道 size
    UIImage *unknown1 = [UIImage imageNamed:@"changtu"];
    UIImage *unknown2 = [UIImage imageNamed:@"gaotu"];
    
    
    [self.markL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(100);
    }];
    self.markL1.text = @"ScaleToFill";
    self.imgV1.contentMode = UIViewContentModeScaleToFill;
    // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
    if (unknown1.size.width > unknown1.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
        [self.imgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL1.mas_right).offset(30);
            make.top.equalTo(self.view).offset(100);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV1.image = unknown1;
    
    [self.markL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.imgV1.mas_bottom).offset(30);
    }];
    self.markL2.text = @"Redraw";
    self.imgV2.contentMode = UIViewContentModeRedraw;
    // 以高为准，根据 UI 原型图，规定最大高，高写死，如果 UI 规定最大高为 60，则 imageView 高度以 60 为准
    if (unknown2.size.width < unknown2.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(60 * (unknown2.size.width / unknown2.size.height), 60);
        [self.imgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL2.mas_right).offset(30);
            make.top.equalTo(self.markL2).offset(0);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV2.image = unknown2;
    
    [self.markL3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.imgV2.mas_bottom).offset(30);
    }];
    self.markL3.text = @"Left";
    // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
    if (unknown1.size.width > unknown1.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
        [self.imgV3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL3.mas_right).offset(30);
            make.top.equalTo(self.markL3).offset(0);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV3.image = unknown1;
    self.imgV3.contentMode = UIViewContentModeLeft;
    
    [self.markL4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.imgV3.mas_bottom).offset(30);
    }];
    self.markL4.text = @"Top";
    self.imgV4.contentMode = UIViewContentModeTop;
    // 以宽为准，根据 UI 原型图，规定最大宽，宽写死，如果 UI 规定最大宽为 100，则 imageView 宽度以 100 为准
    if (unknown1.size.width > unknown1.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(100, 100 / (unknown1.size.width / unknown1.size.height));
        [self.imgV4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL4.mas_right).offset(30);
            make.top.equalTo(self.markL4).offset(0);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV4.image = unknown1;
    
    [self.markL5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.imgV4.mas_bottom).offset(30);
    }];
    self.markL5.text = @"Center";
    self.imgV5.contentMode = UIViewContentModeCenter;
    // 以高为准，根据 UI 原型图，规定最大高，高写死，如果 UI 规定最大高为 60，则 imageView 高度以 60 为准
    if (unknown2.size.width < unknown2.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(60 * (unknown2.size.width / unknown2.size.height), 60);
        [self.imgV5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL5.mas_right).offset(40);
            make.top.equalTo(self.markL5).offset(0);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV5.image = unknown2;
    
    [self.markL6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.imgV5.mas_bottom).offset(30);
    }];
    self.markL6.text = @"Fit";
    self.imgV6.contentMode = UIViewContentModeScaleAspectFit;
    // 以高为准，根据 UI 原型图，规定最大高，高写死，如果 UI 规定最大高为 60，则 imageView 高度以 60 为准
    if (unknown2.size.width < unknown2.size.height) {
        // 根据网络图片宽高比计算 imageView 高度
        CGSize size = CGSizeMake(60 * (unknown2.size.width / unknown2.size.height), 60);
        [self.imgV6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.markL6.mas_right).offset(40);
            make.top.equalTo(self.markL6).offset(0);
            make.size.mas_equalTo(size);
        }];
    }
    self.imgV6.image = unknown2;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
