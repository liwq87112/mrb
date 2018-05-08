//
//  MMTCPswModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCPswModel.h"

@implementation MMTCPswModel


+(NetworkTask *)MineShopGetBindedPhoneSuccess:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                        error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3)
                          };
    
    return [NET GETWithParameters:dic Host:ShopGetBindedPhone success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        id data;
        if ([[resultObject safeObjectForKey:@"info"] isKindOfClass:[NSArray class]]) {
            data = resultObject;
        }else{
            data = [resultObject safeObjectForKey:@"info"];}
        
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        //        NSLog(@"json = %@",resultObject);
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+(NetworkTask *)MineShopCheckCodeAndBinedphoneWithPhone:(NSString *)phone
                                           Code:(NSString *)code
                                        Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                          error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"code":code,
                          @"telephone":phone
                          };
    return [NET POSTWithParameters:dic Host:ShopCheckCodeAndBinedphone success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        id data;
        if ([[resultObject safeObjectForKey:@"info"] isKindOfClass:[NSArray class]]) {
            data = resultObject;
        }else{
            data = [resultObject safeObjectForKey:@"info"];}
        
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+(NetworkTask *)MineGetCheckCodeWithPhone:(NSString *)phone
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"telephone":phone
                          };
    return [NET POSTWithParameters:dic Host:GetCheckCode success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        id data;
        if ([[resultObject safeObjectForKey:@"info"] isKindOfClass:[NSArray class]]) {
            data = resultObject;
        }else{
            data = [resultObject safeObjectForKey:@"info"];}
        
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+(NetworkTask *)MineShopFeedbackContent:(NSString *)content
                                  Email:(NSString *)email
                               Img_srcs:(NSString *)img_srcs
                                Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"content":content,
                          @"contact":email,
                          @"img_srcs":img_srcs,
                          };
    return [NET POSTWithParameters:dic Host:ShopFeedback success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        id data;
        if ([[resultObject safeObjectForKey:@"info"] isKindOfClass:[NSArray class]]) {
            data = resultObject;
        }else{
            data = [resultObject safeObjectForKey:@"info"];}
        
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

/** 效验验证码 */
+(NetworkTask *)MineShopCheckCode:(NSString *)code
                          Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                            error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"code":code
                          };
    return [NET POSTWithParameters:dic Host:ShopCheckCode success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        id data;
        if ([[resultObject safeObjectForKey:@"info"] isKindOfClass:[NSArray class]]) {
            data = resultObject;
        }else{
            data = [resultObject safeObjectForKey:@"info"];}
        
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


@end
