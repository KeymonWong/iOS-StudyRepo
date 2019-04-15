//
//  OKCustomAnnotation.h
//  OKCustomAnnotationView
//
//  Created by 小伴 on 16/11/17.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

typedef NS_ENUM(NSUInteger, CustomAnnotationType){
    CustomAnnotationTypeMe = 1,
    CustomAnnotationTypeFemale,
    CustomAnnotationTypeMale,
};

@interface OKCustomAnnotation : MAPointAnnotation
@property (nonatomic, assign) CustomAnnotationType type;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, copy) NSString *imagePath;
@end
