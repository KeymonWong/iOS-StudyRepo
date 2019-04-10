//
//  ViewController.m
//  AutoCellHeight
//
//  Created by keymon on 2019/1/31.
//  Copyright © 2019 ola. All rights reserved.
//

#import "ViewController.h"

#import "AutoChangeHeightCell.h"

#import "AutoHeightCell.h"
#import "InputInfo.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, AutoChangeHeightCellDelegate, AutoHeightCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat newH;
@property (nonatomic, strong) NSIndexPath *willUpdateIndexPath;

@property (nonatomic, strong) NSArray *contents;
@end

@implementation ViewController

#pragma mark - lazy load

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.rowHeight = 50;
        
        
        //  支持自适应 cell
//        _tableView.estimatedRowHeight = 50;
//        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        [_tableView registerClass:[AutoChangeHeightCell class] forCellReuseIdentifier:NSStringFromClass([AutoChangeHeightCell class])];
        
//        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AutoHeightCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AutoHeightCell class])];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    InputInfo *a = [[InputInfo alloc] init];
    a.height = 50;
    InputInfo *b = [[InputInfo alloc] init];
    b.height = 50;
    InputInfo *c = [[InputInfo alloc] init];
    c.height = 50;
    InputInfo *d = [[InputInfo alloc] init];
    d.height = 50;
    InputInfo *e = [[InputInfo alloc] init];
    e.height = 50;
    InputInfo *f = [[InputInfo alloc] init];
    f.height = 50;
    InputInfo *g = [[InputInfo alloc] init];
    g.height = 50;
    
    InputInfo *h = [[InputInfo alloc] init];
    h.height = 50;
    InputInfo *i = [[InputInfo alloc] init];
    i.height = 50;
    InputInfo *j = [[InputInfo alloc] init];
    j.height = 50;
    
    NSArray *tmps = @[a,b,c,d,e,f,g,h,i,j];
    self.contents = tmps;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath == self.willUpdateIndexPath) {
//        return self.newH;
//    }
//    else {
        if (indexPath.row < self.contents.count) {
            InputInfo *tmp = self.contents[indexPath.row];
            return tmp.height;
        }
        return 0;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoChangeHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AutoChangeHeightCell class]) forIndexPath:indexPath];

    cell.delegate = self;
    if (indexPath.row < [self.contents count]) {
        InputInfo *tmp = self.contents[indexPath.row];
//        cell.textView.text = tmp.text;
        cell.info = tmp;
    }

    return cell;
    
//    AutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AutoHeightCell class]) forIndexPath:indexPath];
//    cell.delegate = self;
//    cell.textView.text = self.contents[indexPath.row];
//    return cell;
}

- (void)cell:(AutoChangeHeightCell *)cell updateH:(CGFloat)h withInputInfo:(InputInfo *)info atIndexPath:(NSIndexPath *)indexPath {
    self.newH = h;
    self.willUpdateIndexPath = indexPath;
    
    NSMutableArray *data = [self.contents mutableCopy];
    data[indexPath.row] = info;
    self.contents = [data copy];
}

- (void)cell:(AutoHeightCell *)cell updateText:(NSString *)text {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    NSMutableArray *data = [self.contents mutableCopy];
    data[indexPath.row] = text;
    self.contents = [data copy];
}

@end
