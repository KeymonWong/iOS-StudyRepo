//
//  JSObjcProtocol.h
//  OC-JS
//
//  Created by 小伴 on 2017/6/28.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcProtocol <JSExport>

- (void)callCamera;
- (void)share:(NSString *)shareStr;


#pragma mark - JsObjcModel

//js 调用此方法来调用 oc 的系统相册方法
- (void)callSystemCamera;

//在 js 中调用时，函数名应该为 showAlertMsg(arg1, arg2);
//这里是2个参数
- (void)showAlert:(NSString *)title msg:(NSString *)msg;

//通过 json 传过来
- (void)callWithParams:(NSDictionary *)params;

//js 调用 oc，然后在 oc 中通过调用 js 方法来传值给 js
- (void)jsCallObjcAndObjcCallJsWithParams:(NSDictionary *)params;

@end
