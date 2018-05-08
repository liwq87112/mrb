//
//  LPHttpTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-19.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "LPHttpTool.h"
#import <AFNetworking.h>
//网络超时请求时间
#define TimeOutIntervalSet       60
static AFHTTPSessionManager * afHttpSessionMgr = NULL;
#define LWQLog(format,...) printf("%s",[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])

@implementation LPHttpTool


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params view:(UIView *)showView  success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showWaitAnimation:showView withState:YES];
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params
      success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
          if (success) {

              success(responseObject);
              [self showWaitAnimation:showView withState:NO];
              [self showNoNet:showView withState:NO];
          }
      } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error) {
          if (failure) {
             // NSLog(@"%@",failure);
              [self showNoNet:showView withState:YES];
              [self showWaitAnimation:showView withState:NO];
              failure(error);
          }
      }];
}


+(void)showNoNet:(UIView *)parentView withState:(BOOL)state
{
    static __weak UIImageView * _view;
    if (_view!=nil) {[_view removeFromSuperview];_view=nil;}
    if (state) {
        UIImageView * view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"无网络"]];
        view.contentMode=UIViewContentModeCenter;
        view.bounds=CGRectMake(0, 0, 175, 100);
        view.center=parentView.center;
        _view=view;
        [parentView addSubview:view];
    }
}


+(void)showWaitAnimation:(UIView *)parentView withState:(BOOL)state
{
    static __weak UIImageView * _view;
    if (_view!=nil) {[_view removeFromSuperview];_view=nil;}
    if (state) {
        UIImageView * view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索结果"]];
        view.contentMode=UIViewContentModeScaleToFill;
        view.bounds=CGRectMake(0, 0, 45, 32.5);
        view.center=parentView.center;
        NSArray *images = @[[UIImage imageNamed:@"奔跑的小矮人1"],
                            [UIImage imageNamed:@"奔跑的小矮人2"],
                            [UIImage imageNamed:@"奔跑的小矮人3"],
                            [UIImage imageNamed:@"奔跑的小矮人4"]];
        view.animationImages = images;
        [view startAnimating];
        _view=view;
        [parentView addSubview:view];
    }
}
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData)
    {
        for (IWFormData *formData in formDataArray)
        {
            [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
        }
    }success:^(NSURLSessionDataTask * _Nonnull task, id responseObject)
    {
        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error)
    {
        if (failure)
        {
            failure(error);
        }
    }];
}
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray view:(UIView *)showView success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    [self showWaitAnimation:showView withState:YES];
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData)
     {
         for (IWFormData *formData in formDataArray)
         {
             [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
         }
     }success:^(NSURLSessionDataTask * _Nonnull task, id responseObject)
     {
         if (success)
         {
             success(responseObject);
             [self showWaitAnimation:showView withState:NO];
         }
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error)
     {
         if (failure)
         {
             [self showWaitAnimation:showView withState:NO];
             failure(error);
         }
     }];
}
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(IWFormData *)formData success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    
   AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    // 2.发送请求
    
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> totalFormData)
     {
         [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
         
     }success:^(NSURLSessionDataTask * _Nonnull task, id responseObject)
     {
         if (success)
         {
             success(responseObject);
         }
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error)
     {
         if (failure)
         {
             failure(error);
         }
     }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
   AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params
      success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(NSURLSessionDataTask * _Nonnull task, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}




+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params Head:(NSString *)head HeadType:(NSString *)headType success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    //vType为参数名，1为参数的值
    mgr.requestSerializer.timeoutInterval = 15.0;
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    if (head.length > 2 && headType.length > 2) {
        [mgr.requestSerializer setValue:head forHTTPHeaderField:headType];
    }

    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params Head:(NSString *)head HeadType:(NSString *)headType formData:(IWFormData *)formDataa success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
     AFHTTPSessionManager *manager = [self initHttpManager];

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 5;
////    RACSubject *sub =[ RACSubject subject];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//
////    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
////   [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
//    NSLog(@"%@",url);
  
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        if (success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure)
        {
            failure(error);
        }
    }];

}

+ (AFHTTPSessionManager *)initHttpManager {
    if(afHttpSessionMgr == NULL ){
        afHttpSessionMgr = [AFHTTPSessionManager manager];
        //  JSON序列化
        afHttpSessionMgr.requestSerializer = [AFHTTPRequestSerializer serializer];
        afHttpSessionMgr.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        afHttpSessionMgr.requestSerializer.timeoutInterval = TimeOutIntervalSet;
        afHttpSessionMgr.responseSerializer = [AFJSONResponseSerializer serializer];
        afHttpSessionMgr.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[ @"application/json", @"text/html", @"text/json", @"text/javascript" ]];
    }
    
    return afHttpSessionMgr;
}


@end

/**
 *  用来封装文件数据的模型
 */
@implementation IWFormData

@end
