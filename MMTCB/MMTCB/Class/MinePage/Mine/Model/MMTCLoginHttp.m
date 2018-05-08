//
//  MMTCLoginHttp.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCLoginHttp.h"

@implementation MMTCLoginHttp


#pragma mark - 登录
+(NetworkTask *)LoginlWithPassword:(NSString *)password
                             Username:(NSString *)username
                                 code:(NSString *)code
                              Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                error:(ErrorBlock)errorBlock{
    
    NSDictionary *dic = @{@"act":@"j_uc_user_banklist",
                          @"username":SAFE_NIL_STRING(username),
                          @"password":SAFE_NIL_STRING(password)};
    

    
    return [NET POSTWithParameters:dic Host:code success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
                NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
                NSString *show_err = [resultObject safeObjectForKey:@"info"];
        if (successBlock) {
                        successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


+(NetworkTask *)MineFeedBackWithImageData:(NSData *)data
                                 Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                   error:(ErrorBlock)errorBlock
{
    return [NET POSTFileWithParameters:nil formData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *show_err = [resultObject safeObjectForKey:@"info"];
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}
//POSTFileWithParameters
@end
