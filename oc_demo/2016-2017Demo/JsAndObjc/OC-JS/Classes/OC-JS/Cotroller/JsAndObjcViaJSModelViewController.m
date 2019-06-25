//
//  JsAndObjcViaJSModelViewController.m
//  OC-JS
//
//  Created by 小伴 on 2017/6/30.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import "JsAndObjcViaJSModelViewController.h"

#import "JsObjcModel.h"

@interface JsAndObjcViaJSModelViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) JSContext *jsCtx;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JsAndObjcViaJSModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"JsObjcViaJSModel" withExtension:@"html"];
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //这样就可以获取到JS的context，然后为这个context注入我们的模型对象。
    self.jsCtx = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //通过 model 调用方法，这种方式更好
    JsObjcModel *model = [[JsObjcModel alloc] init];
    self.jsCtx[@"OCModel"] = model;
    model.jsContext = self.jsCtx;
    model.webView = self.webView;
    
    self.jsCtx.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@", exception);
    };
}


@end
