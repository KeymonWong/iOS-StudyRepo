//
//  OKValuationView.h
//  demo
//
//  Created by keymon on 2019/6/4.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OKCar;

NS_ASSUME_NONNULL_BEGIN

@interface OKValuationView : UIView
@property (nonatomic, copy) void (^didPickItem)(OKCar *car);
@end

NS_ASSUME_NONNULL_END
