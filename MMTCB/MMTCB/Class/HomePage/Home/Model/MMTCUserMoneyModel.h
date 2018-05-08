//
//  MMTCUserMoneyModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/28.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

#define verificationSee @"/shopapi/verification/see"
#define verificationConfirm @"/shopapi/verification/verification"
#define verificationOrderInfo @"/shopapi/verification/orderInfo"
typedef void(^ErrorBlock)(NSError *error);

@interface MMTCUserMoneyModel : NSObject

@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * used_date_time;
@property (nonatomic, strong) NSNumber * is_used;



+(NetworkTask *)HomeUserMoneyP:(NSNumber *)p
                           Psw:(NSString *)psw
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock;

+(NetworkTask *)HomeverificationConfirmID:(NSNumber *)orderId
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock;

+(NetworkTask *)HomeverificationConfirmIDInfo:(NSNumber *)orderId
                                      Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                                        error:(ErrorBlock)errorBlock;

@end
