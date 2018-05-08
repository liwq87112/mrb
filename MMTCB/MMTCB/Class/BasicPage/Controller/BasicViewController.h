//
//  BasicViewController.h
//  com
//
//  Created by lwq on 2016/11/10.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Util.h"

@interface BasicViewController : UIViewController

+ (instancetype)instanceControllerWithSBName:(NSString*)sb className:(NSString*)className;

-(void)showWithInfo:(NSString *)info;

#pragma mark- 主颜色
-(void)mainColor;

#pragma mark- 白颜色
-(void)whiteColor;

@end
