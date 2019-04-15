//
//  OKCustomAnnotationView.h
//  OKSegment
//
//  Created by 小伴 on 16/11/15.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@class OKCustomAnnotation;

@interface OKCustomAnnotationView : MAAnnotationView

//一定要重写，否则当滑动地图，annotation出现和消失时候会出现数据混乱
- (void)setAnnotation:(id<MAAnnotation>)annotation;

@end
