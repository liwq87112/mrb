//
//  LPAppInterface.h
//  LePIn
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 xiaoairen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/************************************************/

//#define ServerCN @"https://app.mmtcapp.com/shopapi"
#define ServerCN @"https://app.mmtcapp.com"
#define MMTCIMAGE @"https://app.mmtcapp.com/"



@interface LPAppInterface : NSObject

/**
 *请求具体的接口 addr 接口地址
 */
+ (NSString *)GetURLWithInterfaceAddr:(NSString *)InterfaceAddr;

@end
