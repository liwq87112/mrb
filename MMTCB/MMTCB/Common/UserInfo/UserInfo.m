//
//  UserInfo.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *sharedInstance = nil;

@implementation UserInfo

+ (UserInfo *)sharedInstance
{
    if (!sharedInstance) {
        sharedInstance = [[UserInfo alloc] init];
    }
    return sharedInstance;
}

#pragma mark - 销毁
+ (void)clean
{
    sharedInstance = nil;
}

#pragma mark - 保持信息
- (void)save
{
//    [[NSUserDefaults standardUserDefaults] setObject:RI.token forKey:@"token"];
//    [[NSUserDefaults standardUserDefaults] setObject:RI.user_name forKey:@"user_name"];
    //    [[NSUserDefaults standardUserDefaults] setObject:RI.encrptyAndDecrptyKey forKey:kEncryptOrDecryptKey];
    
}

- (void)deleteSave
{
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_name"];
//    //    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kEncryptOrDecryptKey];
//
//    RI.userInfo = nil;
//
//    //清除接口缓存
//    YYCache *cache = [YYCache cacheWithName:@"cacheDB"];
//    [cache removeAllObjects];
}


@end
