//
//  KWRingProgressBar.h
//  RingProgressBar_UIBezierPath
//
//  Created by keymon on 2018/7/25.
//  Copyright © 2018 xiaoban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWRingProgressBar : UIView

/**
 设置图片
 @param url 图片url
*/
- (void)setImageURL:(NSString *)url;

/**
 更新圆环进度
 @param value 进度值
 */
- (void)updateProgressWithValue:(NSUInteger)value;

@end
