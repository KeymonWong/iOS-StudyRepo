//
//  AppDelegate.m
//  MutipleScheme
//
//  Created by keymon on 2019/11/6.
//  Copyright © 2019 okay. All rights reserved.
//

#import "AppDelegate.h"

///当前日期字符串
#define DATE_STRING \
({NSDateFormatter *fmt = [[NSDateFormatter alloc] init];\
[fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
[fmt stringFromDate:[NSDate date]];})

///------ 替换NSLog使用，debug模式下可以打印很多方法名、行信息(方便查找)，release下不会打印 ------
#if DEBUG
    //-- 区分设备和模拟器,
    //解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
    #if TARGET_OS_IPHONE
        /*iPhone Device*/
        #define DLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
    #else
        /*iPhone Simulator*/
        #define DLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
    #endif
#else
    #define DLog(...)
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
#if APP_ENV == 1
    DLog(@"开发环境");
#elif APP_ENV == 2
    DLog(@"测试环境");
#elif APP_ENV == 3
    DLog(@"UAT环境");
#elif APP_ENV == 4
    //基于 project 中 Release 创建的配置，打的包不会打印控制台日志信息
    //上面的1、2、3基于 project 中Debug创建的配置，会打印控制台日志信息
    DLog(@"Pro环境");
#else
    DLog(@"正式环境");
#endif
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
