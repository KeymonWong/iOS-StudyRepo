//
//  ViewController.m
//  Banner
//
//  Created by hqm on 2020/11/9.
//

#import "ViewController.h"

#import "BannerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BannerView *bv = [[BannerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300)];
    [self.view addSubview:bv];
}


@end
