//
//  MMTCHomeModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCHomeModel.h"

@implementation MMTCHomeModel

+(NetworkTask *)HomeListP:(NSNumber *)p
                       kw:(NSString *)kw
                     host:(NSString *)host
                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                    error:(ErrorBlock)errorBlock{

    NSDictionary *dic = @{@"p":SAFE_NIL_STRING(p),
                          @"_f":@"3",
                          @"kw":SAFE_NIL_STRING(kw)
                          };

    return [NET GETWithParameters:dic Host:host success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger response_code = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *data = [resultObject safeObjectForKey:@"data"];
        NSString *show_err = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(response_code,show_err,data);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}




@end
