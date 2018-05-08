//
//  CheckTextManager.m
//  yheHomeMaster
//
//  Created by yixiang on 15/11/16.
//  Copyright © 2015年 yixiang. All rights reserved.
//

#import "CheckTextManager.h"

@implementation CheckTextManager

#pragma mark - 检查固定话（小树）
+ (BOOL)checkHomePhoneNumber:(NSString *) Number
{
//    @"^[0]\\d{2}-\\d{8}|^[0]\\d{3}-\\d{7}|^[0]\\d{2}\\d{8}|^[0]\\d{3}\\d{7}"
//    NSString *pattern = @"^[0]\\d{2}-\\d{8}|^[0]\\d{3}-\\d{7}|^[0]\\d{2}\\d{8}|^[0]\\d{3}\\d{7}|^[0]\\d{2}-\\d{9}|^[0]\\d{3}-\\d{8}|^[0]\\d{2}\\d{9}|^[0]\\d{3}\\d{8}";
    
    NSString *pattern = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:Number];
    return isMatch;
}


//- (BOOL)checkNumber:(NSString *)number{
//    
//    //验证输入的固话中不带 "-"符号
//    
//    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$";
//    
//    //验证输入的固话中带 "-"符号
//    
//    //NSString * strNum = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
//    
//    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
//    
//    return [checktest evaluateWithObject:number];
//    
//}


#pragma mark - 6为数字密码
+ (BOOL)checkSixNumber:(NSString *) SixNumber
{
    NSString *pattern = @"^[0-9]{6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:SixNumber];
    return isMatch;
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
//    NSString *pattern = @"^1+[3578]+\\d{9}";
//    NSString *pattern = @"^1+[0123456789]+\\d{9}";
    
//    NSString *pattern = @"^[1][0123456789][0-9]{9}$";
    NSString *pattern = @"^1[3|4|5|7|8]+\\d{9}$";

//    ^1[3|4|5|7|8]\d{9}$
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"[a-zA-Z0-9~`!@#$%^&*()-_=+\{}|:;\"'<>,./]{6,16}";
//    NSString *pattern = @"[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"([0-9]{15}$)|([0-9]{17}([0-9]|X))|([0-9]{17}([0-9]|x))";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)isCorrect:(NSString *)IDNumber
{
    NSMutableArray *IDArray = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    // 系数数组
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    // 余数数组
    NSArray *remainderArray = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2", nil];
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    NSString *str = remainderArray[(sum % 11)];
    NSString *string = [IDNumber substringFromIndex:17];
    if ([str isEqualToString:string]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

#pragma mark - 匹配正浮点数和整数
+ (BOOL)checkFloat : (NSString *) floatStr
{
    NSString *pattern = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:floatStr];
    return isMatch;
}

#pragma mark - 匹配正整数
+ (BOOL)checkunsignedInt: (NSString *) floatStr
{
    NSString *pattern = @"^[0-9]{0,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:floatStr];
    return isMatch;
}

#pragma mark - 匹配qq
+ (BOOL)checkQQ: (NSString *) QQ
{
    NSString *pattern = @"^[0-9]{5,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:QQ];
    return isMatch;
}

#pragma mark - 匹配微信
+ (BOOL)checkWX: (NSString *) WX
{
    NSString *pattern = @"^[a-zA-Z]{1}[-_a-zA-Z0-9]{5,19}+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:WX];
    return isMatch;
}

#pragma mark - 匹配银行卡
+ (BOOL)checkBankcard:(NSString *)idcard
{
    NSString *pattern = @"^[0-9]{15,20}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idcard];
    return isMatch;
}

#pragma mark - 匹配电话
//+ (BOOL)checkAllPhone:(NSString *)phoneNum
//{
//    NSString *pattern = @"^((\\d{11})|(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8}))$";
//    NSLog(@"pattern:%@",pattern);
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:phoneNum];
//    return isMatch;
//}

+ (BOOL)checkAllPhone:(NSString *)phoneNum
{
    NSInteger telNum = phoneNum.length;
    if (telNum >= 7 && telNum <= 11 ) {
        return YES;
    }else
    {
        return NO;
    }
}

#pragma mark - 匹配中文c
+ (BOOL)checkChinese:(NSString *)chinese
{
    NSString *pattern = @"^[\\u2E80-\\uFE4F]+$";
//    NSLog(@"pattern:%@",pattern);
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:chinese];
    return isMatch;
}

#pragma mark - 匹配金钱
+ (BOOL)checkMoney:(NSString *)money
{
    NSString *pattern = @"^(?!0+(?:\\.0+)?$)(?:[1-9]\\d*|0)(?:\\.\\d{1,2})?$";
//    NSLog(@"pattern:%@",pattern);
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:money];
    return isMatch;
}

@end
