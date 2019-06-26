//
//  AutoHeightCell.m
//  AutoCellHeight
//
//  Created by keymon on 2019/2/1.
//  Copyright © 2019 ola. All rights reserved.
//

#import "AutoHeightCell.h"

@interface AutoHeightCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

@implementation AutoHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    CGFloat width = CGRectGetWidth(textView.frame);
////    CGSize newSize = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
////    CGRect newFrame = textView.frame;
////
//    CGRect bounds = textView.bounds;
//    
//    // 计算 text view 的高度
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//    bounds.size = newSize;
    
//    textView.bounds = bounds;
    
//    NSIndexPath *currentIndexPath = [[self tableView] indexPathForCell:self];
//

    CGSize newSize = [textView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
    
//    CGFloat height = newSize.height;
//    if (height < 50) {
//        self.height.constant = 50;
//    }else{
//        self.height.constant = height;
//    }
    
    CGFloat newH = 50;
    CGFloat textViewH = newSize.height;

    if (textViewH > 50 && textViewH < 80) {
        textView.scrollEnabled = NO;
        newH = textViewH;
    }
    if (textViewH <= 50) {
        textView.scrollEnabled = NO;
        newH = 50;
    }
    if (textViewH > 80) {
        textView.scrollEnabled = YES;
        newH = 80;
    }
    
    self.height.constant = newH;
    
    
//    //更新textView的frame
//    newFrame.size = CGSizeMake(fmax(width, newSize.width), newH);
//    textView.frame = newFrame;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:updateText:)]) {
        [self.delegate cell:self updateText:textView.text];
    }
    
    //tableView重新计算高度
    [[self tableView] beginUpdates];
    [[self tableView] endUpdates];
}

- (UITableView *)tableView {
    UIView *tmp = self.superview;
    while (tmp && ![tmp isKindOfClass:[UITableView class]]) {
        tmp = tmp.superview;
    }
    return (UITableView *)tmp;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
