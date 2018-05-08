//
//  MMTCLoginHttp.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTCLoginHttp : NSObject

//typedef void(^NoParamsBlock)();
typedef void(^ErrorBlock)(NSError *error);

+(NetworkTask *)LoginlWithPassword:(NSString *)password
                             Username:(NSString *)username
                                  code:(NSString *)code
                               Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                 error:(ErrorBlock)errorBlock;




+(NetworkTask *)MineFeedBackWithImageData:(NSData *)data
                                  Success:(void(^)(NSInteger response_code,NSString *show_err,id json))successBlock
                                    error:(ErrorBlock)errorBlock;
@end
