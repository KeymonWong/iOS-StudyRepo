//
//  JsObjcModel.h
//  OC-JS
//
//  Created by 小伴 on 2017/6/30.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "JSObjcProtocol.h"

//此模型用于注入 js 的模型，这样可以通过模型来调用方法
@interface JsObjcModel : NSObject<JSObjcProtocol>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end
