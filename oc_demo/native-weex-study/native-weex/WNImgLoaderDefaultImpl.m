//
//  WNImgLoaderDefaultImpl.m
//  native-weex
//
//  Created by keymon on 2020/3/13.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WNImgLoaderDefaultImpl.h"

#import <SDWebImage/SDWebImage.h>

@implementation WNImgLoaderDefaultImpl

/**
 * 为 weex 自定义 handler
 *
 * 使用：
 * id<WXImgLoaderProtocol> imageLoader = [WXSDKEngine handlerForProtocol:@protocol(WXImgLoaderProtocol)];
 * [iamgeLoader downloadImageWithURL:imageURl imageFrame:frame userInfo:customParam completed:^(UIImage *image, NSError *error, BOOL finished) { }];
 *
 */
- (id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url
                                          imageFrame:(CGRect)imageFrame
                                            userInfo:(NSDictionary *)options
                                           completed:(void (^)(UIImage * _Nullable, NSError * _Nullable, BOOL))completedBlock
{
    if (url.length == 0) {
        return nil;
    }
    
    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:url]
                                                                                     options:0
                                                                                    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    }
                                                                                   completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, finished);
        }
    }];
}


@end
