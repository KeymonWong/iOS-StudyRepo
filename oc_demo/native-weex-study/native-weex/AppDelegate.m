//
//  AppDelegate.m
//  native-weex
//
//  Created by keymon on 2020/3/9.
//  Copyright © 2020 okay. All rights reserved.
//

#import "AppDelegate.h"

#import "WeexEngine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WeexEngine initEngine];
    
    return YES;
}


@end
