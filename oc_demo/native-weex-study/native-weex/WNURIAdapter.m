//
//  WNURIAdapter.m
//  native-weex
//
//  Created by keymon on 2020/3/17.
//  Copyright © 2020 okay. All rights reserved.
//

#import "WNURIAdapter.h"

@implementation WNURIAdapter

/**
 * 和 html 一样，Weex 以相同的方式处理相对路径。以 /、.、..、// 开头的相对 URI 将相对于 bundle url 解析。
 *
 * 这意味着， 一个以 / 开头的路径将是相对于 JS Bundle 文件的根文件夹。. 则是当前文件夹，.. 是父文件夹。
 *  // 则被解析为与 JS Bundle 相同的 scheme。
 */


@end
