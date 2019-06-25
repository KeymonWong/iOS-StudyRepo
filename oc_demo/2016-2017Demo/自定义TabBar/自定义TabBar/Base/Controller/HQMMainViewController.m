//
//  HQMMainViewController.m
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "HQMMainViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "HQMTabBar.h"

#import "HQMNavigationViewController.h"
#import "HQMHomeViewController.h"
#import "HQMFishpondViewController.h"
#import "HQMPublishViewController.h"
#import "HQMMessageViewController.h"
#import "HQMMineViewController.h"

#import "HQMRegisterViewController.h"
#import "HQMLoginViewController.h"


@interface HQMMainViewController () <UITabBarControllerDelegate, HQMTabBarDelegate>
@property (nonatomic, strong) NSMutableArray *imgViews;
@end

@implementation HQMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupChildViewControllers];

    [self setupTabBar];

    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *subChild in child.subviews) {
                if ([subChild isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    UIImageView *imgView = (UIImageView *)subChild;
                    [self.imgViews addObject:imgView];
                }
            }
        }
    }
}

static NSInteger const kHomeVCTAG = 100000;
static NSInteger const kFishpondVCTAG = 100001;
static NSInteger const kMsgVCTAG = 100002;
static NSInteger const kMineVCTAG = 100003;

- (void)setupChildViewControllers {
    HQMHomeViewController *homeVC = [[HQMHomeViewController alloc] init];
    homeVC.tabBarItem.tag = kHomeVCTAG;
    HQMFishpondViewController *fishpondVC = [[HQMFishpondViewController alloc] init];
    fishpondVC.tabBarItem.tag = kFishpondVCTAG;
    HQMMessageViewController *msgVC = [[HQMMessageViewController alloc] init];
    msgVC.tabBarItem.tag = kMsgVCTAG;
    HQMMineViewController *mineVC = [[HQMMineViewController alloc] init];
    mineVC.tabBarItem.tag = kMineVCTAG;

    [self addChildVC:homeVC
               title:@"闲鱼"
               image:@"home_normal"
       selectedImage:@"home_highlight"];
    [self addChildVC:fishpondVC
               title:@"鱼塘"
               image:@"fishpond_normal"
       selectedImage:@"fishpond_highlight"];
    [self addChildVC:msgVC
               title:@"消息"
               image:@"message_normal"
       selectedImage:@"message_highlight"];
    [self addChildVC:mineVC
               title:@"我的"
               image:@"account_normal"
       selectedImage:@"account_highlight"];
}

- (void)addChildVC:(UIViewController *)childVC
             title:(NSString *)title
             image:(NSString *)image
     selectedImage:(NSString *)selectedImage
{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    //禁止渲染
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //设置文字样式
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGBA(252, 217, 83, 1)} forState:UIControlStateSelected];

    HQMNavigationViewController *nav = [[HQMNavigationViewController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)setupTabBar {
    HQMTabBar *tabBar = [[HQMTabBar alloc] init];
    tabBar.delegate0 = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    //判断用户是否登录
    if (![UserDefaults boolForKey:kIsLogin]) {
        if (viewController.tabBarItem.tag == kMsgVCTAG) {
            HQMLoginViewController *loginVC = [[HQMLoginViewController alloc] init];
            HQMNavigationViewController *loginNav = [[HQMNavigationViewController alloc] initWithRootViewController:loginVC];
            [self presentViewController:loginNav animated:YES completion:NULL];
            return NO;
        }
    }
    return YES;
}

- (void)tabBarDidClickPublishBtn:(HQMTabBar *)tabBar {
//    HQMRegisterViewController *regVC = [[HQMRegisterViewController alloc] init];
//    [self.navigationController pushViewController:regVC animated:YES];
    [self playAudio];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    DLog(@"%@---%@", item, tabBar.selectedItem);
    [self playAudio];
    [self didSelectItemAtIndex:item.tag - kHomeVCTAG];
}

- (void)playAudio {
    NSString *resourceBundle = [[NSBundle mainBundle] pathForResource:@"Audio" ofType:@".bundle"];
    NSString *path = [[NSBundle bundleWithPath:resourceBundle] pathForResource:@"composer_open.wav" ofType:nil inDirectory:nil];
    if (path) {
        NSURL *url = [NSURL fileURLWithPath:path];

        SystemSoundID soundID = 0;
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
        if (err != kAudioServicesNoError) {
            DLog(@"Could not load %@,error code:%d",url,err);
        }
        //把需要销毁的音效文件的ID传递给它既可销毁
        //AudioServicesDisposeSystemSoundID(soundID);
        AudioServicesPlaySystemSound(soundID);
    }


//    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Audio" ofType:@".bundle"];
//    NSString *path = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"message_audio_over_tone.wav" ofType:nil inDirectory:nil];
//    //第二种方式加载bundle中的资源
////    NSString *path = [bundlePath stringByAppendingPathComponent:@"message_audio_over_tone.wav"];
//    NSURL *url = [NSURL URLWithString:path];
//
//    SystemSoundID soundID = 0;
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
//    AudioServicesPlaySystemSound(soundID);
}

- (void)didSelectItemAtIndex:(NSInteger)index {
    CAKeyframeAnimation *keyframeAni = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyframeAni.values = @[@1.0, @1.3, @0.95, @1.3, @1.1, @1.25, @1.0];
    keyframeAni.duration = 0.5;
    keyframeAni.calculationMode = kCAAnimationCubic;
    [[self.imgViews[index] layer] addAnimation:keyframeAni forKey:@"bounceAnimation"];
}

- (NSMutableArray *)imgViews {
    if (!_imgViews) {
        _imgViews = [[NSMutableArray alloc] init];
    }
    return _imgViews;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
