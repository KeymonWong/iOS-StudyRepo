//
//  AutoChangeHeightCell.m
//  AutoCellHeight
//
//  Created by keymon on 2019/1/31.
//  Copyright © 2019 ola. All rights reserved.
//

#import "AutoChangeHeightCell.h"

@interface AutoChangeHeightCell ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *placeholderL;
@property (nonatomic, strong) UILabel *titleL;
@end

@implementation AutoChangeHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubview];
    }
    return self;
}

- (void)setupSubview {
    [self.contentView addSubview:self.textView];
    [self.contentView addSubview:self.titleL];
    [self.textView addSubview:self.placeholderL];
    
    self.textView.frame = CGRectMake(100, 0, self.contentView.bounds.size.width-100, 50.);
    self.placeholderL.frame = CGRectMake(self.textView.frame.size.width-60, 5, 60, 20);
    self.titleL.frame = CGRectMake(10, 10, 80, 20);
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)setInfo:(InputInfo *)info {
    _info = info;
    self.textView.text = info.text;
}

- (void)textViewDidChange:(UITextView *)textView {
    (textView.text.length > 0) ? (self.placeholderL.hidden = YES) : (self.placeholderL.hidden = NO);
    
    NSLog(@"%@", textView.text);
    
    CGFloat width = CGRectGetWidth(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    
//    CGFloat oldWidth = CGRectGetWidth(textView.frame);
//
//    [textView sizeToFit];
//
//    CGRect newFrame = textView.frame;
//    CGSize newSize = textView.frame.size;
//    newFrame.size = CGSizeMake(fmax(oldWidth, newSize.width), newSize.height);
//    textView.frame = newFrame;
    
    
    NSIndexPath *currentIndexPath = [[self tableView] indexPathForCell:self];
    
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
    
    //更新textView的frame
    newFrame.size = CGSizeMake(fmax(width, newSize.width), newH);
    textView.frame = newFrame;
    
    self.info.height = newH;
    self.info.text = textView.text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:updateH:withInputInfo:atIndexPath:)]) {
        [self.delegate cell:self updateH:newH withInputInfo:self.info atIndexPath:currentIndexPath];
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

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.returnKeyType = UIReturnKeyDone;
        _textView.textAlignment = NSTextAlignmentRight;
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
        _textView.clipsToBounds = YES;
        _textView.layer.masksToBounds = YES;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.font = [UIFont systemFontOfSize:18];
//        _textView.clearsOnInsertion = YES;
    }
    return _textView;
}

- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.font = [UIFont systemFontOfSize:18.];
        _titleL.textColor = [UIColor orangeColor];
        _titleL.textAlignment = NSTextAlignmentLeft;
        _titleL.text = @"动态行高";
        [_titleL sizeToFit];
    }
    return _titleL;
}

- (UILabel *)placeholderL {
    if (!_placeholderL) {
        _placeholderL = [[UILabel alloc] init];
        _placeholderL.font = [UIFont systemFontOfSize:14.];
        _placeholderL.textColor = [UIColor grayColor];
        _placeholderL.textAlignment = NSTextAlignmentRight;
        _placeholderL.text = @"请输入";
        [_placeholderL sizeToFit];
    }
    return _placeholderL;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
