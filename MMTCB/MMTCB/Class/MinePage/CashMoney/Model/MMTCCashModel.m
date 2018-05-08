//
//  MMTCCashModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashModel.h"

@implementation MMTCCashModel

+(NetworkTask *)CachMoneyUserInfoSuccess:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3)};
    
    return [NET GETWithParameters:dic Host:MoneyManage success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachMoneyListDataWithPage:(NSNumber *)page
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"p":SAFE_NIL_STRING(page)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyListData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachMoneyIncomeListWithPage:(NSNumber *)page
                                    Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                      error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"p":SAFE_NIL_STRING(page)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyIncomeList success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachMoneyIncomeDetailOfDate:(NSString *)data
                                       Page:(NSNumber *)page
                                    Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                      error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"p":SAFE_NIL_STRING(page),
                          @"date":SAFE_NIL_STRING(data)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyIncomeDetailOfDate success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachMoneyWithdrawInfoId:(NSString *)infoId
                                   Page:(NSNumber *)page
                                Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"p":SAFE_NIL_STRING(page),
                          @"id":SAFE_NIL_STRING(infoId)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyWithdrawInfo success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachMoneyWithdrawDetailId:(NSString *)infoId
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"id":SAFE_NIL_STRING(infoId)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyWithdrawDetail success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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


+(NetworkTask *)CachMoneyWithdrawStepDetailId:(NSString *)infoId
                                      Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                        error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"id":SAFE_NIL_STRING(infoId)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyWithdrawStep success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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


+(NetworkTask *)CachMoneyGetBankSuccess:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3)
                          };
    
    return [NET GETWithParameters:dic Host:MoneyGetBank success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

+(NetworkTask *)CachShopApplyCashCode:(NSString *)code
                              Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"code":code
                          };
    return [NET POSTWithParameters:dic Host:ShopApplyCash success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
