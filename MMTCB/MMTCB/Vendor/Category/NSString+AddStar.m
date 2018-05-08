//
//  NSString+AddStar.m
//  com
//
//  Created by lwq on 2016/12/8.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import "NSString+AddStar.h"

@implementation NSString (AddStar)

//姓名
+(NSString*)nameAddStar:(NSString*)name
{
    if (name.length == 0) {
        return @"";
    }
    
    //最后一个字
     NSMutableString *rtemp = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < name.length-1; i++) {
        [rtemp appendString:@"*"];
    }
    
    
    NSMutableString *temp = [[NSMutableString alloc]initWithString:name];
    if (temp.length > 0) {
        [temp replaceCharactersInRange:NSMakeRange(0, name.length-1) withString:rtemp];
    }
    return  temp;
}



//手机 前3 后4
+(NSString*)mobileAddStar:(NSString*)mobile
{
    if (mobile.length == 0) {
        return @"";
    }
    
    //最后一个字
    NSMutableString *rtemp = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < mobile.length-7; i++) {
        [rtemp appendString:@"*"];
    }
    
    
    NSMutableString *temp = [[NSMutableString alloc]initWithString:mobile];
    if (temp.length > 0) {
        [temp replaceCharactersInRange:NSMakeRange(3, mobile.length-7) withString:rtemp];
    }
    return  temp;
}




////身份证 前4 后4
+(NSString*)idCardAddStar:(NSString*)idCard
{
    if (idCard.length == 0) {
        return @"";
    }
    
    //最后一个字
    NSMutableString *rtemp = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < idCard.length-8; i++) {
        [rtemp appendString:@"*"];
    }
    
    
    NSMutableString *temp = [[NSMutableString alloc]initWithString:idCard];
    if (temp.length > 0) {
        [temp replaceCharactersInRange:NSMakeRange(4, idCard.length-8) withString:rtemp];
    }
    return  temp;
    
}

////银行卡 前4 后4
+(NSString*)bankCardAddStar:(NSString*)bankCard
{
    if (bankCard.length == 0) {
        return @"";
    }
    
    //最后一个字
    NSMutableString *rtemp = [[NSMutableString alloc]init];
    for (NSInteger i = 0; i < bankCard.length-8; i++) {
        [rtemp appendString:@"*"];
    }
    
    
    NSMutableString *temp = [[NSMutableString alloc]initWithString:bankCard];
    if (temp.length > 0) {
        [temp replaceCharactersInRange:NSMakeRange(4, bankCard.length-8) withString:rtemp];
    }
    return  temp;
}

@end
