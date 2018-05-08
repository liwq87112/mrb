//
//  Const.m
//  xskj
//
//  Created by 黎芹 on 16/4/26.
//  Copyright © 2016年 lq. All rights reserved.
//




#import "Const.h"

@implementation Const

+ (Const *)sharedConst
{
    static Const *sharedConstInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedConstInstance = [[self alloc] init];
        
        //正式发布
#ifdef zhengShiFaBu
        [sharedConstInstance selectAPIWithOption:@"www"];
#else
        //测试发布
        //读文件
        NSString *api = [[NSUserDefaults standardUserDefaults] objectForKey:@"api"];
        //存在用上次的
        if (api) {
            [sharedConstInstance selectAPIWithOption:api];
        }else
        {
            //不存在用vtest
            [[NSUserDefaults standardUserDefaults] setObject:@"mapi" forKey:@"api"];
            [sharedConstInstance selectAPIWithOption:@"mapi"];
        }
        
#endif
        
        
    });
    
    return sharedConstInstance;
}

-(void)selectAPIWithOption:(NSString*)Option
{
    if ([Option isEqualToString:@"vtest"]) {
        
        _myKHOST = @"https://vtest.xiaoshushidai.com";
        
    }else if ([Option isEqualToString:@"www"])
    {
        _myKHOST = @"https://mapi.xiaoshushidai.com";
        //        _myKHOST = @"https://www.xiaoshushidai.com";
        
    }else
    {
        //自定义
        if ([Option hasPrefix:@"http://"] || [Option hasPrefix:@"https://"]) {
            
            _myKHOST = [NSString stringWithFormat:@"%@.xiaoshushidai.com",Option];
            
        }else
        {
//            _myKHOST = @"https://www.xiaoshushidai.com";
//            [SVProgressHUD showInfoWithStatus:@"自定义测试环境有误，当前环境www"];
        }
    }
}


@end






/** 美美Token  */
NSString * const PH_TokenHead = @"Token";

/**    颜色   **/
//NSString *const viewBackgroundColor = @"#EAEEEF";
NSString *const viewBackgroundColor = @"#F4F4F4";

/** navColor */
NSString *const MMTCNavColor = @"#2B2E3D";

NSString *const mainColor = @"#FF8029";

NSString *const titleColor = @"#B2B2B2";

NSString *const PlaColor = @"#B9B9B9";

NSString *const mainFont = @"#333333";

NSString *Cookie = nil;;

/**    数据   **/
CGFloat const NavMaxY = 64;
CGFloat const titleViewH = 35;
CGFloat const TabbarH = 49;




