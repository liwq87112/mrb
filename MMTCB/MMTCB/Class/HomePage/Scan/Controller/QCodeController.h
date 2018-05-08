//
//  QCodeController.h
//  DDAYGO
//
//  Created by 小树普惠 on 2017/10/10.
//  Copyright © 2017年 lwq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"

@interface QCodeController : BasicViewController

/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString * jump_URL;
/** 接收扫描的条形码信息 */
//@property (nonatomic, copy) NSString * jump_bar_code;


@end
