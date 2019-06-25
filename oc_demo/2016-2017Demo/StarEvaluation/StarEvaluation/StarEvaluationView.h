//
//  StarEvaluationView.h
//  StarEvaluation
//
//  Created by 小伴 on 2017/2/16.
//  Copyright © 2017年 小伴. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarEvaluationView;

typedef void(^StarEvaluationViewBlock)(StarEvaluationView *currentView, NSInteger starIndex);

@interface StarEvaluationView : UIView

/**点击星星后的回调，返回当前星星所在视图和当前点击的星星的下标*/
@property (nonatomic, copy) StarEvaluationViewBlock starEvaluationBlock;

/**普通状态的星星*/
@property (nonatomic, strong) UIImage *normalImage;
/**高亮状态的星星*/
@property (nonatomic, strong) UIImage *highlightedImage;


/**
 PS:如果不设置新的图片，normalName和highlightedName记得传nil，不能传@""
 */
- (instancetype)initWithFrame:(CGRect)frame normalImageName:(NSString *)normalName highlightedImageName:(NSString *)highlightedName;

@end
