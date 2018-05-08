//
//  MMTCOrderModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/28.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>


#define itemOrderList @"/shopapi/shop_manager/itemOrderList"
#define groupOrderList @"/shopapi/shop_manager/groupOrderList"
#define buyOrderList @"/shopapi/shop_manager/buyOrderList"


@class MMTCOrderImageModel;
@class MMTCGroupOrderListModel;
@class MMTCBuyOrderListModel;

typedef void(^ErrorBlock)(NSError *error);

@interface MMTCOrderModel : NSObject

@property (nonatomic, copy) NSString * discount_money;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * is_cancelled;
@property (nonatomic, copy) NSString * coupon_id;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * order_type;
@property (nonatomic, copy) NSString * payed;
@property (nonatomic, copy) NSString * total;
@property (nonatomic, assign) NSString * used_count;

@property (nonatomic, strong) NSArray<MMTCOrderImageModel *> * items;

+(NetworkTask *)OrderListType:(NSNumber *)Type
                         Page:(NSNumber *)Page
                           Kw:(NSString *)kw
                          host:(NSString *)host
                       Success:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock
                         error:(ErrorBlock)errorBlock;

@end

@interface MMTCOrderImageModel : NSObject

@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * is_noted;
@property (nonatomic, copy) NSString * is_used;
@property (nonatomic, copy) NSString * item_status;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * pwd;
@property (nonatomic, copy) NSString * refund_money;
@property (nonatomic, copy) NSString * refund_status;
@property (nonatomic, copy) NSString * title;

@end

@interface MMTCGroupOrderListModel : NSObject

@property (nonatomic, copy) NSString * category_title;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * id_no;
@property (nonatomic, strong) NSNumber * is_expired;//
@property (nonatomic, strong) NSNumber * left_num;//
@property (nonatomic, strong) NSNumber * left_seconds;//
@property (nonatomic, copy) NSString * left_time;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * num_used;
@property (nonatomic, copy) NSString *order_status;
@property (nonatomic, copy) NSString *origin_price;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;

@end

@interface MMTCBuyOrderListModel : NSObject

@property (nonatomic, copy) NSString * coupon_id;
@property (nonatomic, copy) NSString * discount;
@property (nonatomic, copy) NSString * discount_money;
@property (nonatomic, copy) NSString * discount_txt;
@property (nonatomic, copy) NSString * discount_type;
@property (nonatomic, strong) NSNumber * is_expired;//
@property (nonatomic, strong) NSNumber * left_num;//
@property (nonatomic, strong) NSNumber * left_seconds;//
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * is_cancelled;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString *order_type;
@property (nonatomic, copy) NSString *origin_total;
@property (nonatomic, copy) NSString *payed;
@property (nonatomic, copy) NSString *total;

@end
