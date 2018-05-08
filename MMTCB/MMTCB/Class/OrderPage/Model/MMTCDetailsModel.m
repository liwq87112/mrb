//
//  MMTCDetailsModel.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsModel.h"

@implementation MMTCDetailsModel
+(NetworkTask *)OrderDetailsId:(NSNumber *)noId
                          host:(NSString *)host
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"id":SAFE_NIL_STRING(noId)
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

+(NetworkTask *)OrderGroupMemberDetail:(NSNumber *)noId
                               Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                                 error:(ErrorBlock)errorBlock
{
    NSDictionary *dic = @{@"_f":SAFE_NIL_STRING(@3),
                          @"id":SAFE_NIL_STRING(noId)
                          };
    return [NET GETWithParameters:dic Host:groupMemberDetail success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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


@implementation MMTCDetailsItemsModel



@end

@implementation MMTCDetailsMembersModel



@end

@implementation MMTCDetailsGroupInfoModel



@end


@implementation MMTCGroupMemberDetailModel



@end
