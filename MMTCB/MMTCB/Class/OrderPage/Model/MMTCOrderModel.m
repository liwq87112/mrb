//
//  MMTCOrderModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/28.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderModel.h"

@implementation MMTCOrderModel


+(NetworkTask *)OrderListType:(NSNumber *)Type
                         Page:(NSNumber *)Page
                           Kw:(NSString *)kw
                         host:(NSString *)host
                      Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                        error:(ErrorBlock)errorBlock{
    NSDictionary *dic = @{@"kw":SAFE_NIL_STRING(kw),
                          @"_f":SAFE_NIL_STRING(@3),
                          @"type":SAFE_NIL_STRING(Type),
                          @"p":SAFE_NIL_STRING(Page)
                          };
    
    return [NET GETWithParameters:dic Host:host success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

@implementation MMTCOrderImageModel 

@end



@implementation MMTCGroupOrderListModel


@end

@implementation MMTCBuyOrderListModel


@end
