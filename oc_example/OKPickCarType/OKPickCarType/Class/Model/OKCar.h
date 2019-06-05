//
//  OKCar.h
//  demo
//
//  Created by keymon on 2019/3/28.
//  Copyright © 2019 ok. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OKCar : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign, getter=isItemSelected) BOOL itemSelected;
@end

