//
//  WeexEngine.m
//  native-weex
//
//  Created by keymon on 2020/3/10.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WeexEngine.h"
#import <WeexSDK/WeexSDK.h>
#import "WNImgLoaderDefaultImpl.h"

//为 Weex 扩展的 iOS 能力的 module 或 component 类名
static NSString * const kWNCustomEventModule = @"WNCustomEventModule";
static NSString * const kWNMapComponent = @"WNMapComponent";

//module 或 component 的名称，必须确保 native 和 js 两侧名字一致
static NSString * const kNEventModule = @"n-event";
static NSString * const kNEventComponent = @"n-event";

@interface WeexEngine ()

@end

@implementation WeexEngine

+ (void)initEngine
{
    //app 配置
    [WXAppConfiguration setAppName:@"native-weex"];
    [WXAppConfiguration setAppVersion:@"0.1"];
    
    //初始化 WeexSDK
    [WXSDKEngine initSDKEnvironment];
    
    //注册自定义的 module、component、handler，可选
    [WXSDKEngine registerModule:kNEventModule withClass:NSClassFromString(kWNCustomEventModule)];
    [WXSDKEngine registerComponent:kNEventComponent withClass:NSClassFromString(kWNMapComponent)];
    [WXSDKEngine registerHandler:[WNImgLoaderDefaultImpl new] withProtocol:@protocol(WXImgLoaderProtocol)];

    //设置日志级别，可选
    [WXLog setLogLevel:WXLogLevelDebug];
}

@end
