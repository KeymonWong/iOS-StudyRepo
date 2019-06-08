//
//  ViewController.m
//  oclint_demo_command
//
//  Created by keymon on 2019/5/20.
//  Copyright © 2019 ok. All rights reserved.
//

#import "ViewController.h"

#import "DrawImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    DrawImage *img = [[DrawImage alloc] init];
    [imgV setImage:img];
    [self.view addSubview:imgV];
}

- (NSString *)getValueForKey:(NSString *)key {
    NSData *valueData = [self getValueData];
    if (valueData != nil) {
        NSString *value = [[NSString alloc] initWithData:valueData encoding:NSUTF8StringEncoding];
        return value;
    } else {
        return nil;
    }
}

- (NSData *)getValueData {
    return [@"这是哈哈哈或" dataUsingEncoding:NSUTF8StringEncoding];
}

- (UIImage *)createImageWithColor:(UIColor *)color {
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetShadowWithColor (context, CGSizeMake(10.0, 10.0), 5, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(10.0, 400.0, 100.0, 100.0));
    CGContextRestoreGState(context);

    
//    const CGFloat components[] = {1.0, 0.0, 0.0, 0.6};
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGColorRef color1 = CGColorCreate(colorSpace, components);
//    CGContextSetShadowWithColor(context, CGSizeMake(10.0, 10.0), 5, color1);
//    CGContextFillRect(context, CGRectMake(210.0, 100.0, 100.0, 100.0));
//    CGColorRelease (color1);
//    CGColorSpaceRelease (colorSpace);
//    CGContextRestoreGState(context);
//
////    CGContextSetShadowWithColor(context, CGSizeMake(0, -2), 20, [UIColor redColor].CGColor);
////    CGContextSetFillColorWithColor(context, [color CGColor]);
////    CGContextFillRect(context, rect);
//
//    CGSize          myShadowOffset = CGSizeMake (-15,  20);
//    CGFloat          myColorValues[] = {1, 0, 0, 1};
//    CGColorRef      myColor;
//    CGColorSpaceRef myColorSpace;
//    float wd = 200;
//    float ht = 100;
//
//    CGContextSaveGState(context);
//
//    CGContextSetShadow (context, myShadowOffset, 5);
//
//    // Your drawing code here
//    CGContextSetRGBFillColor (context, 0, 1, 0, 1);
//    CGContextFillRect (context, CGRectMake(wd/3 + 75, ht/2 , wd/4, ht/4));
//
//    myColorSpace = CGColorSpaceCreateDeviceRGB ();
//    myColor = CGColorCreate (myColorSpace,myColorValues);
//    CGContextSetShadowWithColor (context, myShadowOffset, 5, myColor);
//
//    // Your drawing code here
//    CGContextSetRGBFillColor (context, 0, 0, 1, 1);
//    CGContextFillRect (context, CGRectMake(wd/3-75,ht/2-100,wd/4,ht/4));
//
//    CGColorRelease (myColor);
//    CGColorSpaceRelease (myColorSpace);
//
//    CGContextRestoreGState(context);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
