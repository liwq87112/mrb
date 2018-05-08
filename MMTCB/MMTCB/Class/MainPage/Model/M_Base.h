//
//  M_Base.h
//  xskj
//
//  Created by Lqq on 16/5/2.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "YYCache.h"

#pragma mark - 数据模型
@interface M_Base : NSObject
@end

#pragma mark - 接口模型

typedef void(^NoParamsBlock)();
typedef void(^ErrorBlock)(NSError *error);

@interface I_Base : NSObject
@end
