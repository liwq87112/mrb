//
//  NSString+AddStar.h
//  com
//
//  Created by lwq on 2016/12/8.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AddStar)

//姓名
+(NSString*)nameAddStar:(NSString*)name;
//手机
+(NSString*)mobileAddStar:(NSString*)mobile;
//身份证
+(NSString*)idCardAddStar:(NSString*)idCard;
//银行卡
+(NSString*)bankCardAddStar:(NSString*)bankCard;

@end
