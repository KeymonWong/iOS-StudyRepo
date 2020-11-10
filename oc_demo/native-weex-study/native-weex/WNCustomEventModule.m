//
//  WNCustomEventModule.m
//  native-weex
//
//  Created by keymon on 2020/3/10.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WNCustomEventModule.h"

@interface WNCustomEventModule ()
@property (nonatomic, copy) WXModuleCallback callback;
@end

@implementation WNCustomEventModule

/*!
 * 为 weex 扩展 iOS 原生能力（扩展的类型为 Module）
 *
 * js 侧调用 native 侧声明的方法：
 *
 * native 层面，weex 初始化的时候先注册自定义的 module，
 * [WXSDKEngine registerModule:@"n-event" withClass:[WNCustomEventModule class]];
 *
 * js 层面，在 js 里使用方法如下：
 * weex.requireModule("n-event").nativeMethod({"key": "value"})
 *
 * 注: n-event 为 module 名字，可以随便起，但是 native 和 js 必须确保一致，logParam 为 native 层面声明的方法
 *
 */

// 把 native 层面的方法暴露给 js，js 调用 native 层面的方法，并在 js 一侧给 native 侧传参
WX_EXPORT_METHOD(@selector(nativeMethod:));
WX_EXPORT_METHOD(@selector(nativeMethod:callback:));

- (void)nativeMethod:(NSDictionary *)inParam
{
    if (inParam.count == 0) {
        return;
    }
    
    NSLog(@"(不带回调时) js 侧传过来的内容：%@", inParam);
}

- (void)nativeMethod:(NSDictionary *)inParam callback:(WXModuleCallback)callback
{
    if (inParam.count == 0) {
        return;
    }
    
    if (callback) {
        callback(@"native 传过来的内容");
    }
    
    NSLog(@"(带回调时) js 侧传过来的内容：%@", inParam);
}

/**
 * Module 进阶
 * 关于 Module 和 Module 方法的执行特性（同步、异步；执行线程），需要了解：

 * 1.weexInstance
 * 在一个 Weex 页面中，默认 WXSDKInstance 的实例持有多个 module 的实例, 而 Module 的实例是是没有对 WXSDKInstance 做持有的，在自定义的 module 中添加
 * @synthesize weexInstance，module 实例可以对持有它本身的 WXSDKInstance 实例做一个弱引用，通过 weexInstance 可以拿到调用该 module 的页面的一些信息。
 *
 * 2.targetExecuteThread
 * Module 方法默认会在 UI 线程（iOS 主线程）中被调用，建议不要在这做太多耗时的任务。如果你的任务不需要在 UI 线程执行或需要在特定线程执行，需要实现
 * WXModuleProtocol 中的 -targetExecuteThread 的方法，并返回你希望方法执行所在的线程。
 *
 * 3.WXModuleKeepAliveCallback
 * Module 支持返回值给 JavaScript 中的回调，回调的类型是 WXModuleKeepAliveCallback。回调的参数可以是 String 或者 Map。该 block 第一个参数为回调给
 * js 的数据，第二参数是一个 BOOL 值，表示该回调执行完成之后是否要被清除。js 每次调用都会产生一个回调，但是对于单独一次调用，是否要在完成该调用之后清除掉回调函数
 * id 就由这个选项控制，如非特殊场景，建议传 NO。
 *
 * 4.WX_EXPORT_METHOD_SYNC
 * 使用 WX_EXPORT_METHOD 暴露到前端的方法都是异步方法(获得结果需要通过回调函数获得)。如果期望获得同步调用结果，可以使用 WX_EXPORT_METHOD_SYNC 声明同步的
 * Module 方法。
 *
 */

@end
