//
//  OKMapViewController.m
//  OKCustomAnnotationView
//
//  Created by 小伴 on 16/11/17.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//

#import "OKMapViewController.h"

#import <MAMapKit/MAMapKit.h>

#import "OKCustomAnnotation.h"

#import "OKCustomAnnotationView.h"
#import "OKMapBubbleView.h"

#import "OKMapAnchorPinView.h"

#import "OKNextViewController.h"


@interface OKMapViewController ()<MAMapViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSArray *anns;

@property (nonatomic, strong) OKMapAnchorPinView *pinV;

@end

@implementation OKMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"自定义AnnotationView解决数据混乱问题";
    [self.tipLabel sizeToFit];
    self.tipLabel.text = @"问题备注：自定义的每个AnnotationView的模型数据不同，使用重用机制后，快速滑动地图，使得AnnotationView在地图可视范围内、外来回切换时，会出现数据混乱。";

    [self setupSubviews];

    [self setupModels];
    
//    OKMapBubbleView *v = [[OKMapBubbleView alloc] initWithFrame:CGRectMake(100, 300, 200, 46)];
    OKMapAnchorPinView *v = [[OKMapAnchorPinView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 150) * 0.5, (self.view.frame.size.height - 96) * 0.5, 150, 84)];
    [self.view addSubview:v];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [v startAnimation];
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    OKCustomAnnotation *ann = self.anns.firstObject;

    [self.mapView showAnnotations:self.anns animated:YES];
    [self.mapView setCenterCoordinate:ann.coordinate animated:YES];
}

- (void)setupSubviews {
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 164, self.view.bounds.size.width, self.view.bounds.size.height-164)];
    self.mapView.zoomLevel = 16.;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.delegate  = self;
    [self.view addSubview:self.mapView];

    UIButton *resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setBackgroundImage:[UIImage imageNamed:@"xh_dw_ic_az_pr.png"] forState:UIControlStateNormal];
    [resetBtn setFrame:CGRectMake(30, self.view.bounds.size.height-70, resetBtn.currentBackgroundImage.size.width, resetBtn.currentBackgroundImage.size.height)];
    [self.view addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(locateCenterAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)locateCenterAction {
    OKCustomAnnotation *ann = self.anns.firstObject;
    [self.mapView setCenterCoordinate:ann.coordinate animated:YES];
}

- (void)setupModels {
    OKCustomAnnotation *meAnn = [[OKCustomAnnotation alloc] init];
    meAnn.type = CustomAnnotationTypeMe;
    meAnn.number = 5;
    meAnn.imagePath = @"me.jpg";
    meAnn.coordinate = CLLocationCoordinate2DMake(40.036465, 116.310859);

    OKCustomAnnotation *femaleAnn = [[OKCustomAnnotation alloc] init];
    femaleAnn.type = CustomAnnotationTypeFemale;
    femaleAnn.imagePath = @"gou.jpg";
    femaleAnn.coordinate = CLLocationCoordinate2DMake(40.03824, 116.310902);

    OKCustomAnnotation *maleAnn = [[OKCustomAnnotation alloc] init];
    maleAnn.type = CustomAnnotationTypeMale;
    maleAnn.imagePath = @"smile.jpg";
    maleAnn.coordinate = CLLocationCoordinate2DMake(40.036843, 116.308456);

    OKCustomAnnotation *femaletuAnn = [[OKCustomAnnotation alloc] init];
    femaletuAnn.type = CustomAnnotationTypeFemale;
    femaletuAnn.imagePath = @"tu.jpg";
    femaletuAnn.coordinate = CLLocationCoordinate2DMake(40.035036, 116.310194);

    [self.mapView addAnnotations:@[meAnn, femaleAnn, maleAnn, femaletuAnn]];

    self.anns = @[meAnn, femaleAnn, maleAnn, femaletuAnn];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    /* 自定义userLocation对应的annotationView. *///蓝色的小点点去掉方法
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        static NSString *userLocationID = @"userLocation";
        MAAnnotationView *blueCircleAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationID];
        if (!blueCircleAnnotationView) {
            blueCircleAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationID];
        }
        blueCircleAnnotationView.image = [UIImage imageNamed:@""];//蓝色的定位点的图片整个空的

        return blueCircleAnnotationView;

    }
    else if ([annotation isKindOfClass:[OKCustomAnnotation class]]) {
        OKCustomAnnotation *cusAnnotation = (OKCustomAnnotation *)annotation;

        static NSString *cusAnnotationID = @"OKCustomAnnotation";
        OKCustomAnnotationView *cusAnnotationView = (OKCustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:cusAnnotationID];
        if (!cusAnnotationView) {
            cusAnnotationView = [[OKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:cusAnnotationID];
        }

        //很重要的，配置关联的模型数据
        cusAnnotationView.annotation = cusAnnotation;

        return cusAnnotationView;
    }

    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    return nil;
}

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{
    
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    
}

- (IBAction)next:(UIBarButtonItem *)sender {
    OKNextViewController *vc = [[OKNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
