//
//  Network.h
//  KlineFight
//
//  Created by Jaykon on 15/10/22.
//  Copyright © 2015年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//  基于 AFNetworking 2.x~3.x with NSURLSession

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "STEncrypt.h"
#import "SafeControl.h"

#define NET [Network shareInstance]

//网络任务控制
@interface NetworkTask : NSObject

+ (nullable instancetype)netWorkWithSessionDataTask:(nullable NSURLSessionDataTask*)task;
- (void)cancel;
- (void)suspend;
- (void)resume;

@end


//网络任务管理
//网络状态block
typedef void(^NetWorkingStateBlock)( NSString* _Nonnull );


@interface Network : NSObject

@property(nonatomic,strong)AFHTTPSessionManager *manager;

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090) || TARGET_OS_WATCH

NS_ASSUME_NONNULL_BEGIN






+(instancetype)shareInstance;

#pragma mark - 普通行为
- (nullable NetworkTask *)GETWithParameters:(nullable id)parameters
                      success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (nullable NetworkTask *)POSTWithParameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark - POST 图片
- (nullable NetworkTask *)POSTFileWithParameters:(nullable id)parameters
                                        formData:(NSData*)formData
                                        progress:(nullable void (^)(NSProgress * uploadProgress))progress
                                         success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                         failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;





-(void)setCookie:(NSString*)key
           value:(NSString*)value;

//-(void)switchHost:(nullable  NSString*)host;





#pragma mark - POST方法
- (NetworkTask *)POSTWithParms:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NetworkTask *)POSTWithParameters:(nullable id)parameters
                               Host:(NSString *)host
                            success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NetworkTask *)GETWithParameters:(nullable id)parameters
                              Host:(NSString *)host
                           success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                           failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;



/*------------------------------新接口-----------------------------------*/

#pragma mark - POST方法 图片
- (NetworkTask *)N_POSTFileWithParameters:(nullable id)parameters
                                 formData:(NSData*)data
                                 progress:(nullable void (^)(NSProgress * uploadProgress))progress
                                  success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;


#pragma mark - 网络状态
//block可以改变
@property(nonatomic,copy)__block NSString *netWorkingState;

//获取网络状态
-(void)getNetWorkingState;

//设置网络状态变化block
-(void)setNetWorkingStateChangedBlock:(NetWorkingStateBlock)mangerBlock;







NS_ASSUME_NONNULL_END

#endif







@end
