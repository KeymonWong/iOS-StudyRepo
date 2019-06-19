//
//  OKPickCarTypeCell.h
//  FlipPage
//
//  Created by keymon on 2019/3/30.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class OKCar;

@interface OKPickCarTypeCell : UICollectionViewCell
- (void)configureCellWithModel:(OKCar *)model;
@end

NS_ASSUME_NONNULL_END
