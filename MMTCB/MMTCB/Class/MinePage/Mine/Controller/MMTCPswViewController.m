//
//  MMTCPswViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCPswViewController.h"
#import "MMTCConfirmPswViewController.h"
#import "MMTCPswModel.h"
#import "UIButton+countDown.h"
#import "CheckTextManager.h"

@interface MMTCPswViewController ()

@end

@implementation MMTCPswViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"修改密码";
    
    [self layercorder:self.phoneTextField];
    [self layercorder:self.msmTextField];
    
    self.sendCodeButton.layer.borderWidth = 0.5;
    self.sendCodeButton.layer.borderColor = [[UIColor colorWithHexString:mainColor]CGColor];
    self.sendCodeButton.layer.cornerRadius = 3.0;
    
}

- (void)layercorder:(UITextField *)textfield{
    textfield.layer.borderWidth = 0.5;
    textfield.layer.cornerRadius = 3.0;
    textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}

- (IBAction)sendMSMClick:(id)sender {
    
    if (![CheckTextManager checkTelNumber:_phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号"];
        return;
    }

    [_sendCodeButton startWithTime:60
                                       title:@"重新获取"
                                  titleColor:[UIColor colorWithHexString:mainColor]
                              countDownTitle:@"s"
                         countDownTitleColor:[UIColor colorWithHexString:mainColor ]
                                   mainColor:[UIColor whiteColor]
                                  countColor:[UIColor whiteColor]];
    
    //短信
    [SVProgressHUD showWithStatus:@"正在努力加载ing......请再稍等一下下~"];

    @weakify(self);
    [MMTCPswModel MineGetCheckCodeWithPhone:self.phoneTextField.text Success:^(NSInteger response_code, NSString *show_err, id json) {
        [SVProgressHUD dismiss];
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        }
    } error:^(NSError *error) {
        [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
    
}


- (IBAction)nextClick:(id)sender {
    
    if (![CheckTextManager checkTelNumber:self.phoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号"];
        return;
    }
    if (_msmTextField.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写验证码"];
        return;
    }
    
    [MMTCPswModel MineShopCheckCode:self.msmTextField.text Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            MMTCConfirmPswViewController *vc = [MMTCConfirmPswViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
    
    
}
///api/index/getCheckCode?docheck=1

//https://app.mmtcapp.com/api/index/getCheckCode  发送验证码
//{
//    "_f": 1,
//    "telephone": "13433647464"
//}


//https://app.mmtcapp.com/api/index/getCheckCode?docheck=1 发送验证码 效验
//{
//    "_f": 1,
//    "telephone": "13433647464"
//}

//{
//    "info": "原手机号码不正确",
//    "status": 0
//}

//https://app.mmtcapp.com/shopapi/shop/checkCode
//{
//    "_f": 1,
//    "code": "464645"
//}

//{
//    "info": "验证码不存在",
//    "status": 0
//}

@end
