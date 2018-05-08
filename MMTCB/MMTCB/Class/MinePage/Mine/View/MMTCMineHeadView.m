//
//  MMTCMineHeadView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCMineHeadView.h"
#import "LoginViewController.h"


@implementation MMTCMineHeadView
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.shopImageView.layer.cornerRadius = self.shopImageView.lq_height/2.0f;
    self.shopImageView.layer.masksToBounds = YES;
    self.exitButton.layer.cornerRadius = self.exitButton.lq_height/2.0f;
    self.exitButton.layer.borderWidth = 0.5f;
    self.exitButton.layer.borderColor = [[UIColor colorWithHexString:viewBackgroundColor]CGColor];
}

- (void)upDataMine
{
    _shopNameLabel.text = MMTC.nickname;
    _levelLabel.text = [MMTC.level stringValue];
    
    if ([MMTC.avatar containsString:@"http"])
    {
        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:MMTC.avatar]];
    }else{        
        [self.shopImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",MMTCIMAGE,MMTC.avatar]]  placeholderImage:nil];
    }
}

- (IBAction)exitClick:(id)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"是否退出当前用户" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self exitLogin];
    }];
    
    [alertVC addAction:alert];
    [alertVC addAction:alert2];
    
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    
}

- (void)exitLogin
{
    // 清除请求头中的Cookie：
//    NSHTTPCookieStorage *manager = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *cookieStorage = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    for (NSHTTPCookie *cookie in cookieStorage) {
//        [manager deleteCookie:cookie];
//    }
    // 清除NSUserDefault中的Cookie
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MMTCCookie"];
    Cookie = nil;
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    LoginViewController *login = [LoginViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
    self.window.rootViewController = nav;
}


@end
