//
//  OKViewController.m
//  OKPickCarType
//
//  Created by keymon on 2019/6/5.
//  Copyright © 2019 ok. All rights reserved.
//

#import "OKViewController.h"
#import "OKPriceDescViewController.h"

#import "OKValuationView.h"

@interface OKViewController ()
@property (nonatomic, weak) OKValuationView *valuationV;
@end

@implementation OKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        OKValuationView *v = [[OKValuationView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 140)];
        self.valuationV = v;
        v;
    })];
    
    
    [self.valuationV setDidPickItem:^(OKCar * _Nonnull car) {
        OKPriceDescViewController *vc = [[OKPriceDescViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


@end
