//
//  M_load.m
//  xskj
//
//  Created by Lqq on 16/5/5.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "M_load.h"

@implementation LoadItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"adv_list" :[LoadImageItem class]};
}
@end


@implementation LoadImageItem

@end


@implementation I_Load
//+(NetworkTask *)requestLoadImageWithParam:(NSDictionary *)param success:(void(^)(NSString *responseCode,NSArray *loadImageItems,NSString *updateTime))successBlock error:(ErrorBlock)errorBlock{
//    
//    return [NET GETWithParameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        
//        NSString *responseCode = [resultObject safeObjectForKey:@"response_code"];
//        NSArray *loadImageItems = [LoadImageItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"list"]];
//        NSString *updateTime = [resultObject safeObjectForKey:@"update_time"];
//        if (successBlock) {
//            successBlock(responseCode,loadImageItems,updateTime);
//        }
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        if (errorBlock) {
//            errorBlock(error);
//        }
//    }];
//}
@end
