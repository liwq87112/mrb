//
//  MMTCSearchHistoryModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Realm.h>
#import <Realm/Realm.h>
@interface MMTCSearchHistoryModel : RLMObject

@property (nonatomic, copy) NSString * historyStr;

@end
