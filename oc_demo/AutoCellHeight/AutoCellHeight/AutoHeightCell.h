//
//  AutoHeightCell.h
//  AutoCellHeight
//
//  Created by keymon on 2019/2/1.
//  Copyright © 2019 ola. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoHeightCell;

@protocol AutoHeightCellDelegate <NSObject>

@optional
- (void)cell:(AutoHeightCell *)cell updateText:(NSString *)text;

@end

NS_ASSUME_NONNULL_BEGIN

@interface AutoHeightCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonatomic, weak) id<AutoHeightCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
