//
//  WKViewController.m
//  OC-JS
//
//  Created by 小伴 on 2017/6/29.
//  Copyright © 2017年 黄小梦. All rights reserved.
//

#import "WKViewController.h"

#import <WebKit/WebKit.h>

@interface WKViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    //设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    //默认为0
    config.preferences.minimumFontSize = 10;
    //默认为 YES
    config.preferences.javaScriptEnabled = YES;
    //在 iOS 上默认为 NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    //通过 js 与 web 内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    //注入 js 对象名称 AppModel，当js 通过 AppModel来调用时，
    //我们可以在 wkscriptmessagehandler 代理中接收到
    //当然我们也可以注入多个名称（JS对象），用于区分功能。
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    
    self.webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webview];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"wkweb" withExtension:@"html"];
    [self.webview loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
    //配置代理
    //如果需要处理web导航条上的代理处理，比如链接是否可以跳转或者如何跳转，需要设置代理；
    //如果需要与在JS调用alert、confirm、prompt函数时，通过JS原生来处理，而不是调用JS的
    //alert、confirm、prompt函数，那么需要设置UIDelegate，在得到响应后可以将结果反馈到JS端
    //导航代理
    self.webview.navigationDelegate = self;
    //与 web ui 交互代理
    self.webview.UIDelegate = self;
    
    //添加对 web 的监听
    [self.webview addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 2)];
    self.progressView.progressTintColor = [UIColor greenColor];
    self.progressView.trackTintColor = [UIColor clearColor];
    self.progressView.progress = 0.;
    [self.view addSubview:self.progressView];
}

#pragma mark - 缓存清理（坑），iOS9 之前没有缓存，也无法清理，iOS 9 中出现WKWebsiteDataStoreWKWebView 是基于 WebKit 框架的，它会忽视先前使用的网络存储 NSURLCache, NSHTTPCookieStorage, NSCredentialStorage等，它也有自己的存储空间用来存储cookie和cache，其他的网络类如NSURLConnection 是无法访问到的。 同时WKWebView发起的资源请求也是不经过NSURLProtocol的，导致无法拦截或自定义新请求。体验过 WKWebView 的一定会遇到修改了H5页面，APP打开时却没有即时更新的问题（实在是缓存得太好了），iOS 8的时候只能增加时间戳的方式解决这个问题（调试下使用，生产环境就只能要求前端修改Cache-Controll了）
- (void)clearWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.) {
        NSSet *types = [NSSet setWithArray:@[
                                             WKWebsiteDataTypeDiskCache,
                                             WKWebsiteDataTypeMemoryCache,
                                             //WKWebsiteDataTypeOfflineWebApplicationCache,
                                             //WKWebsiteDataTypeLocalStorage,
                                             //WKWebsiteDataTypeCookies,
                                             //WKWebsiteDataTypeSessionStorage,
                                             //WKWebsiteDataTypeIndexedDBDatabases,
                                             //WKWebsiteDataTypeWebSQLDatabases
                                             ]];
        
        NSDate *dateSince = [NSDate date];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:types modifiedSince:dateSince completionHandler:^{
            NSLog(@"clear web cache");
        }];
        
    } else {
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *cookiesPath = [libraryPath stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesPath error:nil];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    }
    else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webview.title;
    }
    else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress：%f", self.webview.estimatedProgress);
        
        self.progressView.progress = self.webview.estimatedProgress;
    }
    
    //加载完成
    if (!self.webview.loading) {
        //手动调用 js 代码
        //每次页面完成都弹出来，可以在测试都打开
        NSString *js = @"callJsAlert()";
        [self.webview evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response:%@ error:%@", response, error);
            NSLog(@"call js alert by native");
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma mark - WKScriptMessageHandler

//当 js 通过 AppModel 发送数据到 iOS 端时，会在代理中收到
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        //打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        //NSDictionary, and NSNull类型
        NSLog(@"%@", message.body);
    }
}

#pragma mark - WKUIDelegate

//与JS原生的alert、confirm、prompt交互，将弹出来的实际上是我们原生的窗口，而不是JS的。
//在得到数据后，由原生传回到JS：

- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __func__);
}

//js端调用 alert 时，会触发此代理
//js端调用 alert 所传的数据可以通过 message 拿到
//在原生得到结果后，需要回调 js，是通过completionHandler回掉
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __func__);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"alert" message:@"js 调用 alert" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alertC animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

//js 端调用 confirm 时，会触发此函数
//通过 message 可以拿到 js 端所传的数据
//在 iOS 端显示原生的 alert 得到 yes/no 后，通过completionHandler回调给 js 端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"%s", __func__);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"confirm" message:@"js 调用 confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    
    [self presentViewController:alertC animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

//js 调用 prompt 函数时，会触发此代理
//要求输入一段文本
//在原生输入得到文本内容后，通过completionHandler回调给 js
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"textinput" message:@"js 调用 输入框" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alertC.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alertC animated:YES completion:NULL];
}

#pragma mark - WKNavigationDelegate

//如果需要处理web导航操作，比如链接跳转、接收响应、在导航开始、成功、失败等时要做些处理，
//就可以通过实现相关的代理方法

//请求开始前，会先调用此代理方法，与 uiwebview 的
//-webView:shouldStartLoadWithRequest:navigationType: 类似
//在请求先判断能不能跳转(请求）
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && ![hostname containsString:@".baidu.com"]) {
        //对于跨域，需要手动跳转
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        //不允许 web 内跳转
        decisionHandler(WKNavigationActionPolicyCancel);
        
    } else {
        self.progressView.alpha = 1.;
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    NSLog(@"%s", __func__);
    
    
    //关于跨域
    //WebKit框架对跨域进行了安全性检查限制，不允许跨域，比如从一个 HTTP 页对 HTTPS 发起请求是无效的（有一个界面要
    //跳到支付宝页面去支付，死活没反应）。而系统的 Safari ，iOS 10出现的 SFSafariViewController 都是支持跨域
    //的，因此解决办法如下：
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    NSURL *url = navigationAction.request.URL;
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated && [url.scheme isEqualToString:@"https"]) {
        [[UIApplication sharedApplication] openURL:url];
        decisionHandler(policy);
        policy = WKNavigationActionPolicyCancel;
    }
    decisionHandler(policy);
    
    
}

//收到服务端的响应头，根据 response 相关信息，决定是否跳转。decisionHandler 必须调用
//在响应完成时，会回调此方法
//如果设置为不允许响应，web 内容就不会传过来
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __func__);
}

//准备加载页面，等同于uiwebviewdelegate -webview:shouldStartLoadWithRequest:navigationType
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

//接收到服务器请求之后调用（服务器 redirect），不一定调用
//接收到重定向时会回调
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

//页面内容加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __func__);
}

//开始获取到网页内容
//页面内容到达 main frame时
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

//页面加载完成，即是页面载入完成了。等同于uiwebviewdelegat -webviewDidFinishLoad
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __func__);
}

//页面加载失败。等同于uiwebviewdelegat -webview:didFailLoadWithError:
//导航失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __func__);
}

// SSL 认证
//https 验证，如果不要求验证，传默认就行
//如果需要证书验证，与使用 afn 进行 https 验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"%s", __func__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

//9.0才能使用，web 内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __func__);
}

@end
