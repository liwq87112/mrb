//
//  MMTCBindNewPViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCBindNewPViewController.h"
#import "MMTCCashBankViewController.h"

#import "UIButton+countDown.h"
#import "CheckTextManager.h"
#import "MMTCPswModel.h"

@interface MMTCBindNewPViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bindPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *msmTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@end

@implementation MMTCBindNewPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_changeAccount) {
        self.title = @"手机号验证";
        self.bindPhoneTextField.placeholder = @"请输入绑定的手机号码";
    }else{
        self.title = @"绑定手机号码";
    }
    
 

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

- (IBAction)sendCodeClick:(id)sender {
    
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
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        }
    } error:^(NSError *error) {
        [weak_self.sendCodeButton cancelCountDownWith:@"重新获取"];
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
    
}

- (IBAction)confirmClick:(id)sender {
    if (![CheckTextManager checkTelNumber:_bindPhoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号"];
        return;
    }
    if (_msmTextField.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写验证码"];
        return;
    }
    if (_changeAccount) {
        //绑定提现信息
        MMTCCashBankViewController *vc = [MMTCCashBankViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //手机号绑定成功
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
