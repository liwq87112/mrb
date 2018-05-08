//
//  MMTCUserInfo.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMTCUserInfo2;

@interface MMTCUserInfo : NSObject

/** 绑定手机 */
@property (nonatomic, strong) NSNumber *hasbindedphone;
/** 密码设置 */
@property (nonatomic, strong) NSNumber *emptyPwd;

/** 相关信息 */
@property (nonatomic, strong) NSDictionary *data;

@end


@interface MMTCUserInfo2 : NSObject

/** 身份验证状态 */
@property (nonatomic, strong) NSNumber *auth_status;
/** 图片 */
@property (nonatomic, copy) NSString *avatar;
/** 水平 */
@property (nonatomic, strong) NSNumber *level;
/** 昵称 */
@property (nonatomic, copy) NSString *nickname;

@end
