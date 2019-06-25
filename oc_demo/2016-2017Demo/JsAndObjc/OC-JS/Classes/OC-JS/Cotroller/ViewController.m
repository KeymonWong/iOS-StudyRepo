//
//  ViewController.m
//  OC-JS
//
//  Created by 小伴 on 2017/6/28.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import "ViewController.h"

#import "JSObjcProtocol.h"

@interface ViewController ()<UIWebViewDelegate, JSObjcProtocol>

@property (nonatomic, strong) JSContext *jsContext;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webview.delegate = self;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"Toyun"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    if ([url rangeOfString:@"toyun://"].location != NSNotFound) {
        //url的协议头是 toyun
        //在webView的代理方法中去拦截自定义的协议Toyun://
        //如果是此协议则据此判断JavaStript想要做的事情，调用原生应用的方法，
        //这些都是提前约定好的，同时阻止此链接的跳转。
        NSLog(@"callJump");
        return NO;
    }
    
    return YES;
}

#pragma mark - JSObjcDelegate

// 注意：JavaStript调用本地方法是在子线程中执行的，这里要根据实际情况考虑线程之间的切换，
// 而在回调JavaScript方法的时候最好是在刚开始调用此方法的线程中去执行那段JavaStript方法的代码，

// 假设此方法在子线程 a 中执行
- (void)callCamera {
    // 这句假设在主线程中执行
    NSLog(@"%s", __func__);
    
    // 下面这2句代码最好还是要在子线程 a 中执行
    //获取到照片之后在回调 js 的方法 picCallback 把图片传进去
    JSValue *picCallback = self.jsContext[@"picCallback"];
    [picCallback callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareStr {
    NSLog(@"%s--%@", __func__, shareStr);
    
    //分享成功回调 js 的方法 shareCallback
    JSValue *shareCallback = self.jsContext[@"shareCallback"];
    [shareCallback callWithArguments:nil];
}

@end
