//
//  MMTCCashModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  MoneyManage   @"/shopapi/money/manage"
#define  MoneyListData @"/shopapi/money/listData"
#define  MoneyIncomeList @"/shopapi/money/incomeList"
#define  MoneyIncomeDetailOfDate @"/shopapi/money/incomeDetailOfDate"
#define  MoneyWithdrawInfo  @"/shopapi/money/withdrawInfo"
#define  MoneyWithdrawDetail @"/shopapi/money/withdrawDetail"
#define  MoneyWithdrawStep @"/shopapi/money/withdrawStep"
#define  MoneyGetBank @"/shopapi/money/getBank"
#define  ShopApplyCash @"/shopapi/shop/applyCash"

typedef void(^ErrorBlock)(NSError *error);

@interface MMTCCashModel : NSObject

@property (nonatomic, copy) NSString * auth_time;
@property (nonatomic, copy) NSString * create_time;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * status;

@property (nonatomic, copy) NSString * total;
@property (nonatomic, copy) NSString * create_date;

@property (nonatomic, copy) NSString * category_title;
//@property (nonatomic, copy) NSString * money;
@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * tixian_money;
@property (nonatomic, copy) NSString * used_date_time;
@property (nonatomic, copy) NSString * yongjin;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * member_id;
@property (nonatomic, copy) NSString * item_id;
//@property (nonatomic, copy) NSString * used_date_time;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * bank_id;
@property (nonatomic, copy) NSString * info;
//@property (nonatomic, copy) NSString * item_id;

@property (nonatomic, copy) NSString * bank_name;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * identity_no;
@property (nonatomic, copy) NSString * car_no;



+(NetworkTask *)CachMoneyUserInfoSuccess:(void(^)(NSInteger response_code,NSString *show_err,id data))successBlock error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyListDataWithPage:(NSNumber *)page
                           Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                             error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyIncomeListWithPage:(NSNumber *)page
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyIncomeDetailOfDate:(NSString *)data
                                    Page:(NSNumber *)page
                                    Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                      error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyWithdrawInfoId:(NSString *)infoId
                                       Page:(NSNumber *)page
                                    Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                      error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyWithdrawDetailId:(NSString *)infoId
                                Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyWithdrawStepDetailId:(NSString *)infoId
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachMoneyGetBankSuccess:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                        error:(ErrorBlock)errorBlock;

+(NetworkTask *)CachShopApplyCashCode:(NSString *)code
                              Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock;


@end
