//
//  MMTCPswModel.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  ShopGetBindedPhone   @"/shopapi/shop/getBindedPhone"
#define  ShopCheckCodeAndBinedphone @"/shopapi/shop/checkCodeAndBinedphone"
#define  GetCheckCode @"/api/index/getCheckCode?docheck=1"
#define  ShopFeedback @"/shopapi/shop/feedback"
#define  ShopCheckCode @"/shopapi/shop/checkCode"

@interface MMTCPswModel : NSObject

typedef void(^ErrorBlock)(NSError *error);

//+(NetworkTask *)LoginlWithPhone:(NSString *)phone
//                           Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
//                             error:(ErrorBlock)errorBlock;


/** 获取原手机号 */
+(NetworkTask *)MineShopGetBindedPhoneSuccess:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                        error:(ErrorBlock)errorBlock;


/** 效验原手机和验证码*/
+(NetworkTask *)MineShopCheckCodeAndBinedphoneWithPhone:(NSString *)phone
                                                   Code:(NSString *)code
                                                Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                                  error:(ErrorBlock)errorBlock;
/** 发送验证码 */
+(NetworkTask *)MineGetCheckCodeWithPhone:(NSString *)phone
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock;

/** 效验验证码 */
+(NetworkTask *)MineShopCheckCode:(NSString *)code
                          Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                            error:(ErrorBlock)errorBlock;


/** 意见反馈 */
+(NetworkTask *)MineShopFeedbackContent:(NSString *)content
                                  Email:(NSString *)email
                               Img_srcs:(NSString *)img_srcs
                                Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                  error:(ErrorBlock)errorBlock;
@end
