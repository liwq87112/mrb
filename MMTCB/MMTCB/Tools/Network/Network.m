//
//  Network.m
//  KlineFight
//  
//  Created by Jaykon on 15/10/22.
//  Copyright © 2015年 Guangzhou ZhangAoBo Software Technology Co., Ltd. All rights reserved.
//


#import "Network.h"
#import "LPAppInterface.h"
#define  N_HOST @"http://192.168.1.49:85"

#ifdef DEBUG

#define WQLog(FORMAT, ...) fprintf(stderr, "%s:%zd\t%s\n", [[[NSString stringWithUTF8String: __FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String]);

#else

#define WQLog(FORMAT, ...) nil

#endif
//网络任务控制
@implementation NetworkTask{
    NSURLSessionDataTask *_sessionDatatask;
}

+ (instancetype)netWorkWithSessionDataTask:(NSURLSessionDataTask*)task{
    NetworkTask *atask=[[NetworkTask alloc] init];
    atask->_sessionDatatask=task;
    return atask;
}

- (void)cancel{
    [_sessionDatatask cancel];
}

- (void)suspend{
    [_sessionDatatask suspend];
}

- (void)resume{
    [_sessionDatatask resume];
}

@end


//网络任务管理
@interface Network()

@property(nonatomic,copy)NetWorkingStateBlock netWorkBlock;
@property(nonatomic,copy)NSString *version;

@end


@implementation Network

#pragma mark - 初始化系列
+(instancetype)shareInstance{
    static Network *network=nil;
    static dispatch_once_t singlet;
    dispatch_once(&singlet, ^{
        network=[[Network alloc] init];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });
    return network;
}

-(instancetype)init{
    self=[super init];
    if(self){
        [self instannceManagerWithHost:KHOST];
    }
    return self;
}

-(void)instannceManagerWithHost:(NSString*)host{
    
    _manager=[[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:KHOST]];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //正式发布
#ifdef zhengShiFaBu
    //不是正式环境才要设置证书
    
#else
//    NSString *api = [[NSUserDefaults standardUserDefaults] objectForKey:@"api"];
//    
//    if (![api isEqualToString:@"www"]) {
//        
//        //不是正式环境才要设置证书
//        
//        NSString *cerName;
//        
//        if ([api isEqualToString:@"weitest"]) {
//            
//            cerName = @"";
//            
//        }else if ([api isEqualToString:@"vtest"]) {
//            
//            cerName = @"server_vtest";
//            
//        }else if ([api isEqualToString:@"test"])
//        {
//            
//            cerName = @"server_test";
//        }
//        
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:cerName ofType:@"cer"];
//        NSLog(@"cer-->%@",cerPath);
//        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        // 是否允许,NO-- 不允许无效的证书
//        [securityPolicy setAllowInvalidCertificates:YES];
//        securityPolicy.validatesDomainName = NO;
//        NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
//        securityPolicy.pinnedCertificates = set;
//        // 设置证书
//        [securityPolicy setPinnedCertificates:certSet];
//        
//        _manager.securityPolicy = securityPolicy;
//    }
    
#endif
    
    //设置网络监控
    [self getNetWorkingState];
    //设置超时时间
    [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    _manager.requestSerializer.timeoutInterval = 30;
    [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //设置网络缓存
    NSURLCache * cache = [[NSURLCache alloc] initWithMemoryCapacity:50 * 1024 * 1024 diskCapacity:500 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
}

#pragma mark - 请求参数处理，原始请求参数需要加密或者排序等处理，修改此方法
- (instancetype)originalParametersHandelWith:(nullable id)originalParameters
{
    //打印
    NSLog(@"请求参数->%@",originalParameters);
    
    NSString *ASEStr = nil;
    if (originalParameters) {
        NSString *jsonStr = [originalParameters mj_JSONString];
        ASEStr = [STEncrypt AESEncryptWithSting:jsonStr];
    }
    id parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"mrt6" forKey:@"mrt"];
    [parameters setObject:@"4" forKey:@"i_type"];
    [parameters setObject:@"4" forKey:@"r_type"];
    [parameters setObject:@"IOS" forKey:@"dev_type"];
    [parameters setObject:@"2017070212" forKey:@"version"];
    [parameters setObject:@"323000000" forKey:@"sor_code"];
    [parameters setObject:_version forKey:@"version_name"];
    
    if (ASEStr) {
        [parameters setObject:ASEStr forKey:@"requestData"];
    }
    
    return parameters;
}

#pragma mark - 返回数据处理，返回数据需要解密或状态码判断等处理，修改此方法
- (id)originalResponseObjectHandelWith:(nullable id)originalResponseObject
{
    id  jsonResponse;
    
    //解密
    if ([originalResponseObject isKindOfClass:[NSData class]]) {
        NSString *resStr = [[NSString alloc] initWithData:originalResponseObject encoding:NSUTF8StringEncoding];
//        NSString *decrypStr = [STEncrypt AESDecryptWithSting:resStr];
        jsonResponse = [resStr mj_JSONObject];
    }else{
        jsonResponse = originalResponseObject;
    }

    //打印
 
    //正常数据处理，请求正常，但是有可能数据是失败的，成功 @"response_code" == 1
    if (![jsonResponse isKindOfClass:[NSDictionary class]] && ![jsonResponse isKindOfClass:[NSArray class]]) {
        NSLog(@"返回对象类型错误");
        
        [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
        
        return [NSError errorWithMsg:@"请求失败" domain:@"请求失败" code:0];
        
//    }else if ([SAFE_VALUE_FOR_KEY(jsonResponse, @"response_code") intValue] != 1 )
//    {
//        NSLog(@"response_code错误,show_err:%@",SAFE_VALUE_FOR_KEY(jsonResponse, @"show_err"));
//        
//        [SVProgressHUD showErrorWithStatus:SAFE_VALUE_FOR_KEY(jsonResponse, @"show_err")];
//        
//        return [NSError errorWithMsg:SAFE_VALUE_FOR_KEY(jsonResponse, @"show_err") domain:SAFE_VALUE_FOR_KEY(jsonResponse, @"show_err") code:0];
    }else
    {
        //数据正常才返回数据对象
        NSLog(@"请求成功");
        return jsonResponse;
    }

}

#pragma mark - GET方法
- (NetworkTask *)GETWithParameters:(nullable id)parameters
                                    success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{

    NSURLSessionDataTask *thisTask = [_manager GET:[NSString stringWithFormat:@"%@/mapi/index.php",KHOST]
                                        parameters:[self originalParametersHandelWith:parameters]
                                          progress:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功处理
       id HandelObj = [self originalResponseObjectHandelWith:responseObject];
       if (![HandelObj isKindOfClass:[NSError class]]) {
           
           success(thisTask,HandelObj);
           
       }else
       {
           failure(thisTask,HandelObj);
       }
           
                                               
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败处理
        id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
        if ([errorDescription isKindOfClass:[NSString class]] &&
            [errorDescription isEqualToString:@"已取消"]) {
            NSLog(@"请求已取消");
            failure(task,error);
            
        }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
            
            failure(task,error);
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
            failure(task,error);
            
        }
    }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}


#pragma mark - POST方法
- (NetworkTask *)POSTWithParameters:(nullable id)parameters
                            success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

    NSURLSessionDataTask *thisTask = [_manager POST:@"https://app.mmtcapp.com/shopapi/login/login"
                                         parameters:parameters
                                           progress:nil
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //成功处理
                                                
                                                NSLog(@"%@",responseObject);
                                       
                                                
        id HandelObj = [self originalResponseObjectHandelWith:responseObject];
                 

        if (![HandelObj isKindOfClass:[NSError class]]) {

            success(thisTask,HandelObj);

        }else
        {
            failure(thisTask,HandelObj);
        }
                                                
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //失败处理
        id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
        if ([errorDescription isKindOfClass:[NSString class]] &&
            [errorDescription isEqualToString:@"已取消"]) {
            NSLog(@"请求已取消");
            failure(task,error);
            
        }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
            
            failure(task,error);
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
            failure(task,error);
            
        }
        
    }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}






#pragma mark - 设置Cookie
-(void)setCookie:(NSString*)key
           value:(NSString*)value{
    
    NSString *cookiestring=nil;
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        if ([cookie.name isEqualToString:key]) {
            continue;
        }
        if (cookiestring) {
            cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,cookie.name,cookie.value];
        }else{
            cookiestring=[NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
        }
    }
    if (cookiestring) {
        cookiestring=[NSString stringWithFormat:@"%@;%@=%@",cookiestring,key,value];
    }else{
        cookiestring=[NSString stringWithFormat:@"%@=%@",key,value];
    }
    [_manager.requestSerializer setValue:cookiestring forHTTPHeaderField:@"Cookie"];
}

#pragma mark - 获取网络状态
-(void)getNetWorkingState
{
//    默认监控自己服务器
//    _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"]];
//    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    __weak typeof(_manager) weakManager = _manager;
    __weak typeof(self) weakSelf = self;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                _netWorkingState = @"未知网络";
                //无缓存才下载
                weakManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                _netWorkingState = @"断开网络";
                //加载缓存，没有就失败
                weakManager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                _netWorkingState = @"手机网络";
                //无缓存才下载
                weakManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                _netWorkingState = @"WIFI网络";
                //无缓存才下载
                weakManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
            }
                break;
            default:
            {
                _netWorkingState = @"获取失败";
            }
                break;
        }
        
        static unsigned int i = 0;
        if (weakSelf.netWorkBlock) {
            if (!([weakSelf.netWorkingState isEqualToString:@"手机网络" ] || [weakSelf.netWorkingState isEqualToString:@"WIFI网络" ])) {
                weakSelf.netWorkBlock(weakSelf.netWorkingState);
            }else if(i > 0)
            {
                weakSelf.netWorkBlock(weakSelf.netWorkingState);
            }
        }
        i = 1;
    }];
    [_manager.reachabilityManager startMonitoring];
}

#pragma mark - 设置网络状态变化block
-(void)setNetWorkingStateChangedBlock:(NetWorkingStateBlock)mangerBlock
{
    _netWorkBlock = mangerBlock;
}





#pragma mark - POST方法
- (NetworkTask *)POSTWithParms:(nullable id)parameters
                            success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    
    NSLog(@"参数：%@  地址：%@。最新地址:%@",parameters,[NSString stringWithFormat:@"%@/mapi/index.php",KHOST],[self originalParametersHandelWith:parameters]);
//    http://192.168.1.49:85/api/App/SendTelCode?TelNo=13112341234&Type=register
    NSURLSessionDataTask *thisTask = [_manager POST:@" http://192.168.1.49:85/api/User/CheckIsOld" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        成功处理
        NSLog(@"newrebs: %@",responseObject);
        
        id HandelObj = [self originalResponseObjectHandelWith:responseObject];
        if (![HandelObj isKindOfClass:[NSError class]]) {
            
            success(thisTask,HandelObj);
            
        }else
        {
            failure(thisTask,HandelObj);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        失败处理
        NSLog(@"newrebs: %@",error);
        
        id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
        if ([errorDescription isKindOfClass:[NSString class]] &&
            [errorDescription isEqualToString:@"已取消"]) {
            NSLog(@"请求已取消");
            failure(task,error);
            
        }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
            
            failure(task,error);
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
            failure(task,error);
            
        }
    }];
        
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}

#pragma mark --------------------------新接口----------------------------
#pragma mark - POST方法
- (NetworkTask *)N_POSTFileWithParameters:(nullable id)parameters
                               formData:(NSData*)data
                               progress:(nullable void (^)(NSProgress * uploadProgress))progress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *thisTask = [_manager POST:[NSString stringWithFormat:@"%@%@",N_HOST,@"/api/Authen/UploadRealPhoto"]
//                                      [NSString stringWithFormat:@"%@/mapi/index.php",KHOST]
                                         parameters:parameters
//                                      [self originalParametersHandelWith:parameters]
                          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                              
                              if (formData!= nil) {
                                  //添加附件
                                  [formData appendPartWithFileData:data
                                                              name:@"file"
                                                          fileName:@"iOSiMG.png"
                                                          mimeType:@"image/png"];
                              }
                              
                          }progress:^(NSProgress * _Nonnull uploadProgress) {
                              
                              progress(uploadProgress);
                              
                          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              //成功处理
                              id HandelObj = [self originalResponseObjectHandelWith:responseObject];
                              if (![HandelObj isKindOfClass:[NSError class]]) {
                                  
                                  success(thisTask,HandelObj);
                                  
                              }else
                              {
                                  failure(thisTask,HandelObj);
                              }
                          }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              //失败处理
                              id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
                              if ([errorDescription isKindOfClass:[NSString class]] &&
                                  [errorDescription isEqualToString:@"已取消"]) {
                                  NSLog(@"请求已取消");
                                  failure(task,error);
                                  
                              }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
                                  
                                  failure(task,error);
                                  
                              }else{
                                  
                                  [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
                                  failure(task,error);
                                  
                              }
                          }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}




#pragma mark - - - - - - -- - - - -- - 美美天成 http

- (NetworkTask *)POSTWithParameters:(nullable id)parameters
                               Host:(NSString *)host
                            success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                            failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    if (Cookie.length > 0) {
        [_manager.requestSerializer setValue:Cookie forHTTPHeaderField:@"cookie"];
    }
    NSURLSessionDataTask *thisTask = [_manager POST:[LPAppInterface GetURLWithInterfaceAddr:host]
                                         parameters:parameters
                                           progress:^(NSProgress * _Nonnull uploadProgress) {
                                               
                                           }
                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            
                                                
                                                //成功处理
                                                id HandelObj = [self originalResponseObjectHandelWith:responseObject];
                                                
                            
                                                if (![HandelObj isKindOfClass:[NSError class]]) {
                                                    
                                                    success(thisTask,HandelObj);
                                                    
                                                }else
                                                {
                                                    failure(thisTask,HandelObj);
                                                }
                                                
                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                //失败处理
                                                id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
                                                if ([errorDescription isKindOfClass:[NSString class]] &&
                                                    [errorDescription isEqualToString:@"已取消"]) {
                                                    NSLog(@"请求已取消");
                                                    failure(task,error);
                                                    
                                                }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
                                                    
                                                    failure(task,error);
                                                    
                                                }else{
                                                    
                                                    [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
                                                    failure(task,error);
                                                    
                                                }
                                                
                                            }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}

#pragma mark - GET方法
- (NetworkTask *)GETWithParameters:(nullable id)parameters
                              Host:(NSString *)host
                           success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                           failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
  
    if (Cookie.length > 0) {
        [_manager.requestSerializer setValue:Cookie forHTTPHeaderField:@"cookie"];
    }
    NSURLSessionDataTask *thisTask = [_manager GET:[LPAppInterface GetURLWithInterfaceAddr:host]
                                        parameters:parameters
                                          progress:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                               
                                               //成功处理
//                                               NSLog(@"%@",responseObject);
                                               id HandelObj = [self originalResponseObjectHandelWith:responseObject];
//                                               NSLog(@"%@",HandelObj);
                                               if (![HandelObj isKindOfClass:[NSError class]]) {
                                                   
                                                   success(thisTask,HandelObj);
                                                   
                                               }else
                                               {
                                                   failure(thisTask,HandelObj);
                                               }
                                               
                                               
                                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                               //失败处理
                                               id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
                                               if ([errorDescription isKindOfClass:[NSString class]] &&
                                                   [errorDescription isEqualToString:@"已取消"]) {
                                                   NSLog(@"请求已取消");
                                                   failure(task,error);
                                                   
                                               }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
                                                   
                                                   failure(task,error);
                                                   
                                               }else{
                                                   
                                                   [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
                                                   failure(task,error);
                                                   
                                               }
                                           }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}

#pragma mark - POST方法
- (NetworkTask *)POSTFileWithParameters:(nullable id)parameters
                               formData:(NSData*)data
                               progress:(nullable void (^)(NSProgress * uploadProgress))progress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id resultObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *thisTask = [_manager POST:@"https://app.mmtcapp.com/services/uploader/uploadImg"
                                         parameters:[self originalParametersHandelWith:parameters]
                          constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                              
                              if (formData!= nil) {
                                  //添加附件
                                  [formData appendPartWithFileData:data
                                                              name:@"file"
                                                          fileName:@"iOSiMG.png"
                                                          mimeType:@"image/png"];
                              }
                              
                          }progress:^(NSProgress * _Nonnull uploadProgress) {
                              
                              progress(uploadProgress);
                              
                          } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                              //成功处理
                              id HandelObj = [self originalResponseObjectHandelWith:responseObject];
                              if (![HandelObj isKindOfClass:[NSError class]]) {
                                  
                                  success(thisTask,HandelObj);
                                  
                              }else
                              {
                                  failure(thisTask,HandelObj);
                              }
                          }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                              //失败处理
                              id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
                              if ([errorDescription isKindOfClass:[NSString class]] &&
                                  [errorDescription isEqualToString:@"已取消"]) {
                                  NSLog(@"请求已取消");
                                  failure(task,error);
                                  
                              }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
                                  
                                  failure(task,error);
                                  
                              }else{
                                  
                                  [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
                                  failure(task,error);
                                  
                              }
                          }];
    
    
    //    NSURLSessionDataTask *thisTask = [_manager POST:[NSString stringWithFormat:@"%@/mapi/index.php",KHOST]
    //                                         parameters:[self originalParametersHandelWith:parameters]
    //                                           progress:nil
    //                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //                                                //成功处理
    //                                                id HandelObj = [self originalResponseObjectHandelWith:responseObject];
    //                                                if (![HandelObj isKindOfClass:[NSError class]]) {
    //
    //                                                    success(thisTask,HandelObj);
    //
    //                                                }else
    //                                                {
    //                                                    failure(thisTask,HandelObj);
    //                                                }
    //
    //                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //                                                //失败处理
    //                                                id errorDescription = SAFE_VALUE_FOR_KEY(error.userInfo, @"NSLocalizedDescription");
    //                                                if ([errorDescription isKindOfClass:[NSString class]] &&
    //                                                    [errorDescription isEqualToString:@"已取消"]) {
    //                                                    NSLog(@"请求已取消");
    //                                                    failure(task,error);
    //
    //                                                }else if ([_netWorkingState isEqualToString:@"断开网络"]) {
    //
    //                                                    failure(task,error);
    //
    //                                                }else{
    //
    //                                                    [SVProgressHUD showErrorWithStatus:@"网络不够稳定哦~请稍后重试~"];
    //                                                    failure(task,error);
    //
    //                                                }
    //
    //                                            }];
    
    return [NetworkTask netWorkWithSessionDataTask:thisTask];
}

@end
