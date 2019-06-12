//
//  OKCarCell.h
//  demo
//
//  Created by keymon on 2019/6/4.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OKCar;

NS_ASSUME_NONNULL_BEGIN

@interface OKCarCell : UICollectionViewCell
- (void)configureCellModel:(OKCar *)model;
@end

NS_ASSUME_NONNULL_END
