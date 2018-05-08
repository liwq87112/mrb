//
//  M_load.h
//  xskj
//
//  Created by Lqq on 16/5/5.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "M_Base.h"

@interface LoadItem : M_Base

@property(nonatomic, assign)NSInteger response_code;
@property(nonatomic, copy)NSString* show_err;
/** 图片 */
@property(nonatomic, strong)NSArray *list;
/**图片更新时间  时间搓*/
@property(nonatomic, strong)NSString *update_time;

@end


@interface LoadImageItem : M_Base
/** 图片URL地址*/
@property(nonatomic, strong)NSString *image_url;
/** 图片描述*/
@property(nonatomic, strong)NSString *alt;

@end


@interface I_Load : I_Base
//新特性界面
//+(NetworkTask *)requestLoadImageWithParam:(NSDictionary *)param success:(void(^)(NSString *responseCode,NSArray *loadImageItems,NSString *updateTime))successBlock error:(ErrorBlock)errorBlock;
@end
