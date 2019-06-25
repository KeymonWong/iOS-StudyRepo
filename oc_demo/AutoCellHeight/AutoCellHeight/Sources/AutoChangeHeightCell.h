//
//  AutoChangeHeightCell.h
//  AutoCellHeight
//
//  Created by keymon on 2019/1/31.
//  Copyright © 2019 ola. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InputInfo.h"

@class AutoChangeHeightCell;

@protocol AutoChangeHeightCellDelegate <NSObject>

@optional

- (void)cell:(AutoChangeHeightCell *_Nullable)cell updateH:(CGFloat)h withInputInfo:(InputInfo *_Nonnull)info atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AutoChangeHeightCell : UITableViewCell
@property (nonatomic, weak) id<AutoChangeHeightCellDelegate> delegate;

@property (nonatomic, strong) InputInfo *info;
//@property (nonatomic, strong) NSString *content;

//@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

NS_ASSUME_NONNULL_END
