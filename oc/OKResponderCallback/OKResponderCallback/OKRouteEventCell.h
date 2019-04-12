//
//  OKRouteEventCell.h
//  OKResponderCallback
//
//  Created by keymon on 2019/4/11.
//  Copyright © 2019 ok. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RouterBlock)(void);

@interface OKRouteEventCell : UITableViewCell
@property(nonatomic, copy) RouterBlock routeBlock;

- (void)configureCellWithData:(NSDictionary *)data indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
