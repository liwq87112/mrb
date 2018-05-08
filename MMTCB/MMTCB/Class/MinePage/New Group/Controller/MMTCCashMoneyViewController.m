//
//  MMTCCashMoneyViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashMoneyViewController.h"
#import "CheckTextManager.h"
#import "UIButton+countDown.h"
#import "MMTCPswModel.h"
#import "MMTCCashModel.h"

@interface MMTCCashMoneyViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bindPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *msmTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;

@end

@implementation MMTCCashMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"手机验证";
    
    [self layercorder:self.bindPhoneTextField];
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

#pragma mark - - - 确认
- (IBAction)comfirmClick:(id)sender {
//    @weakify(self);
    
    if (![CheckTextManager checkTelNumber:_bindPhoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号"];
        return;
    }
    if (self.msmTextField.text.length < 3) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写验证码"];
        return;
    }
    [MMTCCashModel CachShopApplyCashCode:self.msmTextField.text Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
//            [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
             [SVProgressHUD showErrorWithStatus:@"网络超时"];
        }
    } error:^(NSError *error) {
        
    }];
}

- (IBAction)sendMSMClick:(id)sender {
    
    if (![CheckTextManager checkTelNumber:_bindPhoneTextField.text]) {
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
    [MMTCPswModel MineGetCheckCodeWithPhone:self.bindPhoneTextField.text Success:^(NSInteger response_code, NSString *show_err, id json) {
        [SVProgressHUD dismiss];
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            
        }
    } error:^(NSError *error) {
        [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//https://app.mmtcapp.com/api/index/getCheckCode  发送验证码
//{
//    "_f": 1,
//    "telephone": "13433647464"
//}

//{
//    "info": "",
//    "status": 1
//}


//https://app.mmtcapp.com/shopapi/shop/applyCash 提现
//{
//    "_f": 1,
//    "code": "927472"
//}

//{
//    "info": "操作成功！",
//    "status": 1
//}
@end
