//
//  CheckTextManager.h
//  yheHomeMaster
//
//  Created by yixiang on 15/11/16.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckTextManager : NSObject

#pragma mark - 检查固定话（小树）
+ (BOOL)checkHomePhoneNumber:(NSString *) Number;

#pragma mark - 6为数字密码
+ (BOOL)checkSixNumber:(NSString *) SixNumber;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;

#pragma 正则匹配用户密码6-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

#pragma mark - 匹配正浮点数
+ (BOOL)checkFloat : (NSString *) floatStr;

+ (BOOL)checkunsignedInt: (NSString *) floatStr;

#pragma mark - 匹配qq
+ (BOOL)checkQQ: (NSString *) QQ;

#pragma mark - 匹配微信
+ (BOOL)checkWX: (NSString *) WX;

#pragma mark - 匹配银行卡
+ (BOOL)checkBankcard:(NSString *)idcard;

#pragma mark - 匹配电话
+ (BOOL)checkAllPhone:(NSString *)phoneNum;

#pragma mark - 匹配中文c
+ (BOOL)checkChinese:(NSString *)chinese;

#pragma mark - 匹配金钱 
+ (BOOL)checkMoney:(NSString *)money;

+ (BOOL)isCorrect:(NSString *)IDNumber;

@end
