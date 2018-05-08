//
//  MMTCDetailsModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ErrorBlock)(NSError *error);

#define orderDetail @"/shopapi/shop_manager/orderDetail"
#define groupDetail @"/shopapi/shop_manager/groupDetail"
#define groupMemberDetail @"/shopapi/shop_manager/groupMemberDetail"

@class MMTCDetailsItemsModel;
@class MMTCDetailsGroupInfoModel;
@class MMTCDetailsMembersModel;
@class MMTCGroupMemberDetailModel;

@interface MMTCDetailsModel : NSObject

/** user */
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * intro;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * sign;

@property (nonatomic, strong) NSNumber * level;
/** order */
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * discount_money;
@property (nonatomic, copy) NSString * discount_txt;
@property (nonatomic, copy) NSString * no_discount_money;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * order_type;
@property (nonatomic, copy) NSString * origin_total;
@property (nonatomic, copy) NSString * payed;
@property (nonatomic, copy) NSString * pay_time;
@property (nonatomic, copy) NSString * total;

+(NetworkTask *)OrderDetailsId:(NSNumber *)noId
                         host:(NSString *)host
                      Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                        error:(ErrorBlock)errorBlock;


+(NetworkTask *)OrderGroupMemberDetail:(NSNumber *)noId
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock;


@end

//
@interface MMTCDetailsItemsModel : NSObject

@property (nonatomic, copy) NSString * category_title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * is_noted;
@property (nonatomic, copy) NSString * is_used;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * title;

@end

@interface MMTCDetailsMembersModel : NSObject

@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * payed_time;
@property (nonatomic, copy) NSString * refund;


@end


@interface MMTCDetailsGroupInfoModel : NSObject

@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * expire_time;
@property (nonatomic, copy) NSString * is_expired;
@property (nonatomic, copy) NSString * item_id;
@property (nonatomic, copy) NSString * left_count;
@property (nonatomic, copy) NSString * left_time;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * open_id;
@property (nonatomic, copy) NSString * open_time;
@property (nonatomic, copy) NSString * origin_price;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * done_time;
@end

@interface MMTCGroupMemberDetailModel : NSObject

@property (nonatomic, copy) NSString * is_leader;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * level;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * intro;
@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * payed_time;
@property (nonatomic, copy) NSString * group_status;
@property (nonatomic, copy) NSString * pay_status;

@end

