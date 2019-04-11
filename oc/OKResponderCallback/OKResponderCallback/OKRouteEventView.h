//
//  OKRouteEventView.h
//  OKSnippet
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RouterEventBlock)(void);

@interface OKRouteEventView : UIView
@property(nonatomic, copy) RouterEventBlock routerEventBlock;
@end

NS_ASSUME_NONNULL_END
