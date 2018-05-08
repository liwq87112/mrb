//
//  MMTCUserMoneyModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/28.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCUserMoneyModel.h"

@implementation MMTCUserMoneyModel

+(NetworkTask *)HomeUserMoneyP:(NSNumber *)p
                           Psw:(NSString *)psw
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock{
    NSDictionary *dic = @{@"pwd":SAFE_NIL_STRING(psw),
                          @"_f":SAFE_NIL_STRING(p)};
    
    return [NET POSTWithParameters:dic Host:verificationSee success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *data = [resultObject safeObjectForKey:@"data"];
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        NSLog(@"json = %@",resultObject);
        if (successBlock) {
            successBlock(response_code,show_err,data);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+(NetworkTask *)HomeverificationConfirmID:(NSNumber *)orderId
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                                    error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"id":SAFE_NIL_STRING(orderId),
                          @"_f":SAFE_NIL_STRING(@3)};
    
    return [NET POSTWithParameters:dic Host:verificationConfirm success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
//        NSString *data = [resultObject safeObjectForKey:@"data"];
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        NSLog(@"json = %@",resultObject);
        if (successBlock) {
            successBlock(response_code,show_err,resultObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

+(NetworkTask *)HomeverificationConfirmIDInfo:(NSNumber *)orderId
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                                    error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"id":SAFE_NIL_STRING(orderId),
                          @"_f":SAFE_NIL_STRING(@3)};
    
    return [NET POSTWithParameters:dic Host:verificationOrderInfo success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        //        NSString *data = [resultObject safeObjectForKey:@"data"];
        NSString *show_err;
        if ([resultObject[@"status"] isEqual:@202]) {
            show_err = [resultObject safeObjectForKey:@"info"];
        }else{
            show_err = [resultObject safeObjectForKey:@"msg"];}
        NSLog(@"json = %@",resultObject);
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
