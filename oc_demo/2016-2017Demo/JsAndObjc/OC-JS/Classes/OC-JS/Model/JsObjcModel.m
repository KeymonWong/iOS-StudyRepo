//
//  JsObjcModel.m
//  OC-JS
//
//  Created by 小伴 on 2017/6/30.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import "JsObjcModel.h"

@implementation JsObjcModel

- (void)callWithParams:(NSDictionary *)params {
    NSLog(@"js调用了 oc 的方法，参数为：%@", params);
}

- (void)callSystemCamera {
    NSLog(@"js调用 OC 的方法，吊起系统相册");
    
    //js 调用 oc 后，又通过 oc 调用 js，但是这个没用传参数
    JSValue *jsFunc = self.jsContext[@"jsFunc"];
    [jsFunc callWithArguments:nil];
}

- (void)jsCallObjcAndObjcCallJsWithParams:(NSDictionary *)params {
    NSLog(@"%s，参数为：%@", __func__, params);
    
    //调用 js 方法
    JSValue *jsParamFunc = self.jsContext[@"jsParamFunc"];
    [jsParamFunc callWithArguments:@[@{
                                         @"age" : @10,
                                         @"name" : @"lili",
                                         @"height" : @170
                                         }]];
}

- (void)showAlert:(NSString *)title msg:(NSString *)msg {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    });
}

@end
