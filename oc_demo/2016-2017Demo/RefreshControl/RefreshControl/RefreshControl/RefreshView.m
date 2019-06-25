//
//  RefreshView.m
//  RefreshControl
//
//  Created by 小伴 on 2017/2/21.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import "RefreshView.h"
#import <ImageIO/ImageIO.h>

@interface RefreshView ()
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *refreshImgView;
@property (nonatomic, strong) NSMutableArray *gifImgs;
@end

@implementation RefreshView

- (void)setup {
    _refreshImgView = [[UIImageView alloc] init];
    _refreshImgView.image = [UIImage imageNamed:@"background.png"];
    _refreshImgView.frame = CGRectMake(0, 0, gScreenWidth, self.bounds.size.height - 25);
    [self addSubview:_refreshImgView];

    _stateLabel = [[UILabel alloc] init];
    _stateLabel.frame = CGRectMake(0, self.bounds.size.height-20, gScreenWidth, 15);
    [_stateLabel setFont:[UIFont systemFontOfSize:12.]];
    [_stateLabel setTextColor:[UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1]];
    [_stateLabel setTextAlignment:NSTextAlignmentCenter];
    [_stateLabel setText:NORMAL_TITLE];
    [self addSubview:_stateLabel];

    self.gifImgs = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"frontpage_refresh@2x" ofType:@"gif"];
//    NSString *path = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"frontpage_refresh" ofType:@"gif" inDirectory:@"RefreshControl"];
    self.gifImgs = [self praseToImagesFromGIFData:[NSData dataWithContentsOfFile:path]];

    NSAssert(self.gifImgs.count != 0, @"gif can be nil");

    if (self.gifImgs) {
        _refreshImgView.image = self.gifImgs[0];
        _refreshImgView.animationDuration = 0.85;
        _refreshImgView.animationRepeatCount = INTMAX_MAX;
        _refreshImgView.animationImages = self.gifImgs;
    }
}

- (void)setState:(RefreshState)state {
    [super setState:state];

    switch (state) {
        case RefreshStateNormal: {
            _stateLabel.text = NORMAL_TITLE;

            if (_refreshImgView.isAnimating) {
                [_refreshImgView stopAnimating];
            }

            int index = (-self.tableView.contentOffset.y)/13;
            if (index < 0) {
                index = 0;
            } else if (index > self.gifImgs.count - 1) {
                index = (int)self.gifImgs.count - 1;
            }

            _refreshImgView.image = self.gifImgs[index];
            [self tableViewContentInsets:self.superEdgeInsets];

        } break;
        case RefreshStateTrigger: {
            _stateLabel.text = TRIGGER_TITLE;

            if (!_refreshImgView.isAnimating) {
                [_refreshImgView startAnimating];
            }
        } break;
        case RefreshStateLoading: {
            _stateLabel.text = LOADING_TITLE;
            [self tableViewContentInsets:UIEdgeInsetsMake(TITLE_HEIGHT+self.tableView.contentInset.top, 0, 0, 0)];
            self.handler();
        } break;
    }
}

- (void)tableViewContentInsets:(UIEdgeInsets)edgeInsets {
    [UIView animateWithDuration:0.35 animations:^{
        [self.tableView setContentInset:edgeInsets];
    }];
}

///gif 转数组
- (NSMutableArray *)praseToImagesFromGIFData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.;
    if (src) {
        size_t count = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:count];

        for (size_t i = 0; i < count; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    return frames;
}

@end
