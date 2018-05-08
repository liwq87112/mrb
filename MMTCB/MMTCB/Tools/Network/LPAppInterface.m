//
//  LPAppInterface.m
//  LePIn
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import "LPAppInterface.h"
#import "NSString+Hash.h"
#import "LPHttpTool.h"

@implementation LPAppInterface


#pragma mark 接口拼接
+ (NSString *)GetURLWithInterfaceAddr:(NSString *)InterfaceAddr
{
    return [NSString stringWithFormat:@"%@%@",ServerCN,InterfaceAddr];
}

//https://app.mmtcapp.com/shopapi/login/login
@end
