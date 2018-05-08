//
//  MMTCHomeModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ErrorBlock)(NSError *error);

@interface MMTCHomeModel : NSObject

@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * bill_id;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, strong) NSNumber * group_open_id;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * used_date_time;



+(NetworkTask *)HomeListP:(NSNumber *)p
                          kw:(NSString *)kw
                              host:(NSString *)host
                           Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                             error:(ErrorBlock)errorBlock;





@end
