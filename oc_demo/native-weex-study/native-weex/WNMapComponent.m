//
//  WNMapComponent.m
//  native-weex
//
//  Created by keymon on 2020/3/10.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WNMapComponent.h"

#import <MapKit/MKMapView.h>

//给自定义的 component 提供地图加载完成的事件
static NSString * const kMapDidFinishLoadEventName = @"mapDidFinishLoad";

//给自定义的 component 提供地图的属性
static NSString * const kMapShowTrafficAttr = @"showTraffic";


@interface WNMapComponent ()<MKMapViewDelegate>
{
    BOOL _mapDidFinishLoad;
    BOOL _showTraffic;
}

@end

@implementation WNMapComponent

/**
 * 为 weex 扩展 iOS 原生能力（扩展的类型为 Component）
 *
 * 注：如果这个类里什么代码也不写，它和默认的的 div 组件能力是一致的。
 *
 * 自定义的话需要覆盖 WXComponent 中的生命周期方法
 *
 * native 层面，weex 初始化的时候先注册自定义的 component，
 * [WXSDKEngine registerComponent:@"n-map" withClass:[WNMapComponent class]];
 *
 * js 层面，在 js 里使用方法如下：
 * <template>
 *    <div>
 *       <n-map style="width:200px;height:200px"></n-map>
 *    </div>
 * </template>
 *
 * 注: n-map 为 component 名字，可以随便起，但是 native 和 js 必须确保一致
 *
 */

- (UIView *)loadView
{
    return [[MKMapView alloc] init];
}

- (void)viewDidLoad
{
    //如果当前 view 没有添加 subview 的话，不要设置 view 的 frame，WeexSDK 会根据 style 进行排版后设置。
    MKMapView *mapV = (MKMapView *)self.view;
    mapV.delegate = self;
    
    /* 2.当属性同步给地图控件 */
    mapV.showsTraffic = _showTraffic;
}

#pragma mark - 为该组件添加自定义属性
#pragma mark native 层面

/* 1.覆盖组件初始化方法 initWithRef... 给组件添加一个成员变量记录 showTraffic 属性的值，并在 init 方法中初始化 */

- (instancetype)initWithRef:(NSString *)ref
                       type:(NSString *)type
                     styles:(NSDictionary *)styles
                 attributes:(NSDictionary *)attributes
                     events:(NSArray *)events
               weexInstance:(WXSDKInstance *)weexInstance
{
    self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance];
    if (self) {
        // handle your attributes
        // handle your styles
        
        if (attributes[kMapShowTrafficAttr]) {
            _showTraffic = [WXConvert BOOL:attributes[kMapShowTrafficAttr]];
        }
    }
    return self;
}

/* 3.当属性更新时，同步给地图控件 */

- (void)updateAttributes:(NSDictionary *)attributes
{
    if (attributes[kMapShowTrafficAttr]) {
        _showTraffic = [WXConvert BOOL:attributes[kMapShowTrafficAttr]];
        ((MKMapView *)self.view).showsTraffic = _showTraffic;
    }
}

#pragma mark js 层面

/**
 * js 层面使用方法如下：
 *
 * <template>
 *    <div>
 *        <n-map style="width:200px;height:200px" showTraffic="true"></n-map>
 *    </div>
 * </template>
 *
 */


#pragma mark - 为该组件添加自定义事件
#pragma mark native 层面

/* 1.需要额外添加一个 BOOL 成员 _mapDidFinishLoad 用来记录该事件是否生效 */

- (void)addEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:kMapDidFinishLoadEventName]) {
        _mapDidFinishLoad = YES;
    }
}

- (void)removeEvent:(NSString *)eventName
{
    if ([eventName isEqualToString:kMapDidFinishLoadEventName]) {
        _mapDidFinishLoad = NO;
    }
}

/* 2.给 js 层面发送事件 */

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    if (_mapDidFinishLoad) {
        NSDictionary *params = @{
            @"key": @"value"
        };
        [self fireEvent:kMapDidFinishLoadEventName params:params domChanges:nil];
    }
}

#pragma mark js 层面

/**
 * js 层面使用方法如下：
 *
 * <template>
 *    <div>
         <n-map style="width:200px;height:200px" @mapDidFinishLoad="onMapDidFinishLoad"></n-map>
 *    </div>
 * </template>
 *
 * <script>
 *    export default {
 *        methods: {
 *            onMapDidFinishLoad:function(e) {
 *            console.log("map loaded"+JSON.stringify(e))
 *        }
 *    }
 * }
 * </script>
 *
 */

#pragma mark - 为该组件添加方法

#pragma mark native 层面
//正常写的时候 写到最上面
WX_EXPORT_METHOD(@selector(focusCenter));

- (void)focusCenter
{
    NSLog(@"you have focus center!");
}

#pragma mark js 层面

/**
 * js 层面使用方法如下：
 *
 * <template>
 *   <mycomponent ref='mycomponent'></mycomponent>
 * </template>
 *
 * <script>
 *   module.exports = {
 *     created: function() {
 *       this.$refs.mycomponent.focusCenter();
 *     }
 *   }
 * </script>
 *
 */



@end
