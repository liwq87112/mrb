//
//  MMTCBindingPViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCBindingPViewController.h"
#import "MMTCBindNewPViewController.h"
#import "MMTCPswModel.h"
#import "UIButton+countDown.h"
#import "CheckTextManager.h"

@interface MMTCBindingPViewController ()

@property (weak, nonatomic) IBOutlet UILabel *oldBindPhone;


@property (weak, nonatomic) IBOutlet UITextField *bindPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *msmTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;


@end

@implementation MMTCBindingPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"绑定手机号码";
    
    [self layercorder:self.bindPhoneTextField];
    [self layercorder:self.msmTextField];
    
    self.sendCodeButton.layer.borderWidth = 0.5;
    self.sendCodeButton.layer.borderColor = [[UIColor colorWithHexString:mainColor]CGColor];
    self.sendCodeButton.layer.cornerRadius = 3.0;
    
    [self quesetData];//
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

- (void)quesetData
{
    [MMTCPswModel MineShopGetBindedPhoneSuccess:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            self.oldBindPhone.text = json[@"data"];
        }
    } error:^(NSError *error) {
        
    }];
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


- (IBAction)bindClick:(id)sender {
    
    if (![CheckTextManager checkTelNumber:_bindPhoneTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写手机号"];
        return;
    }
    if (_msmTextField.text.length < 5) {
        [SVProgressHUD showErrorWithStatus:@"请正确填写验证码"];
        return;
    }
    //效验原手机号码 和验证码

    [self checkCodeAndBinedphone];
    
   
}

//效验原手机号码 和验证码
- (void)checkCodeAndBinedphone
{
    [MMTCPswModel MineShopCheckCodeAndBinedphoneWithPhone:self.bindPhoneTextField.text Code:self.msmTextField.text Success:^(NSInteger response_code, NSString *show_err, id json) {
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            //成功跳转
            MMTCBindNewPViewController *vc = [[MMTCBindNewPViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
}

@end
