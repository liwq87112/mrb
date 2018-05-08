//
//  AppDelegate+AppServer.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "AppDelegate+AppServer.h"
#import <IQKeyboardManager.h>
#import "LoginViewController.h"
#import "MainViewController.h"

@implementation AppDelegate (AppServer)



- (void)initSVProgressHUD
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"232323" alpha:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}

- (void)initIQKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)NetWorkConfig
{
    //设置网络
    [NET setNetWorkingStateChangedBlock:^(NSString * stateSTR ) {
        
        if ( [stateSTR isEqualToString:@"断开网络"]) {
            
            //先放View
            //            if (_noNetWorkVC == nil) {
            //                _noNetWorkVC = [[[NSBundle mainBundle] loadNibNamed:@"NoNetWorkVC" owner:nil options:nil] firstObject];
            //                _noNetWorkVC.frame = CGRectMake(0, 0, ScreemW, ScreemH);
            //                [[UIApplication sharedApplication].keyWindow addSubview:_noNetWorkVC];
            //                _noNetWorkVC.hidden = YES;
            //            }
            
            //弹框
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"当前没有网络" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            alertView.tag = 100;
            [UIView appearance].tintColor = [UIColor colorWithHexString:mainColor];
            [alertView show];
            
        }else
        {
            NSString *tempStr = [NSString stringWithFormat:@"当网络状态为%@",stateSTR];
            [SVProgressHUD showSuccessWithStatus:tempStr];
            
            //            [_noNetWorkVC removeFromSuperview];
            //            _noNetWorkVC = nil;
        }
    }];
}

- (void)getNSUserDefaults
{
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"MMTCCookie"]) {
        Cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"MMTCCookie"];

        MMTC.avatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
        MMTC.nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
        MMTC.auth_status = [[NSUserDefaults standardUserDefaults] objectForKey:@"auth_status"];
        MMTC.level = [[NSUserDefaults standardUserDefaults] objectForKey:@"level"];
        
    }
}

- (void)loginOrHomeList
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"MMTCCookie"] == nil)
    {
        LoginViewController *login = [LoginViewController new];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
    }
    else
    {
        self.window.rootViewController = [self chooseRootViewController];
    }
    
    self.window.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];

}

#pragma mark - 选择需要进入的
- (UIViewController *)chooseRootViewController
{
    
    UIViewController *rootVc = nil;
    
    // 判断下用户有没有最新的版本
    // 最新的版本都是保存到info.plist
    // 从info.plist文件获取最新版本
    // 获取info.plist
    //    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    
    // 获取最新的版本号
    //    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    
    // 获取上一次的版本号
    //    NSString *lastVersion = [UserDefaults objectForKey:VersionKey];
    
    
    // 之前的最新的版本号 lastVersion
    //    if ([curVersion isEqualToString:lastVersion]) {
    ////        // 版本号相等
    rootVc = [[MainViewController alloc] init];
    ((UITabBarController *)rootVc).delegate = self;
    
    
    
    //    }else{ // 有最新的版本号
    ////
    ////        // 保存最新的版本号
    ////        // 保存到偏好设置
    //        [UserDefaults setObject:curVersion forKey:VersionKey];
    //        NewFeatureViewController *newFVC = [[NewFeatureViewController alloc] init];
    //
    //        // 创建新特性界面
    //        rootVc = newFVC;
    //    }
    
    //    BOOL noFirstLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:@"IS_FIRST_LAUNCH_KEY1"] boolValue];
    //
    //    if (noFirstLaunch) {
    //        //正常
    //        NSLog(@"111111");
    //        rootVc = [[MainViewController alloc] init];
    //        ((UITabBarController *)rootVc).delegate = self;
    //    } else {
    //        //引导页
    //        NSLog(@"123123");
    //        NewFeatureViewController *newFVC = [[NewFeatureViewController alloc] init];
    ////        [self.window addSubview:newFVC];
    //
    //        rootVc = newFVC;
    //        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"IS_FIRST_LAUNCH_KEY1"];
    //    }
    return rootVc;
}

@end
