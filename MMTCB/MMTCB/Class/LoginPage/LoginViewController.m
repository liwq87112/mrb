//
//  LoginViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
///Users/liwenqiang/Desktop/mmtc/MMTCB/MMTCB/Class/HomePage

#import "LoginViewController.h"
#import "MainNavigationController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MMTCLoginHttp.h"
#import "MMTCUserInfo.h"

@interface LoginViewController ()

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *securityButton;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"美美商户登录";
    _passwordTextField.secureTextEntry = YES;
    [self layercorder:self.userNameTextField];
    [self layercorder:self.passwordTextField];
}

#pragma mark - - - TextField 简单封装
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

#pragma mark - - - 隐藏还是显示
- (IBAction)securityClick:(id)sender {
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    
    if (_passwordTextField.secureTextEntry) {
        
        [_securityButton setImage:[UIImage imageNamed:@"login_eyeopen"] forState:UIControlStateNormal];
    
    }else
    {
        [_securityButton setImage:[UIImage imageNamed:@"login_eyeclose"] forState:UIControlStateNormal];
    }
}

#pragma mark - - - 登录
- (IBAction)LoginClick:(id)sender {
    
    [SVProgressHUD showWithStatus:@"正在登录"];
    [MMTCLoginHttp LoginlWithPassword:self.passwordTextField.text Username:self.userNameTextField.text code:@"/shopapi/login/login?" Success:^(NSInteger response_code, NSString *show_err,id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];  
        }else{
            
            MMTCUserInfo *model = [MMTCUserInfo mj_objectWithKeyValues:json[@"info"]];
            MMTCUserInfo2 *model2 = [MMTCUserInfo2 mj_objectWithKeyValues:model.data];
            MMTC.avatar = model2.avatar;
            MMTC.nickname = model2.nickname;
            MMTC.auth_status = model2.auth_status;
            MMTC.level = model2.level;
            
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];

            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSHTTPCookie *cookie = [[cookieJar cookies]firstObject];
            NSLog(@"cookie3 －> %@", cookie);

            Cookie = [NSString stringWithFormat:@"%@=%@",cookie.name,cookie.value];
            
            //存储归档后的cookie
            NSUserDefaults*userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject: Cookie forKey: @"MMTCCookie"];
            
            [userDefaults setObject: MMTC.avatar forKey: @"avatar"];
            [userDefaults setObject: MMTC.nickname forKey: @"nickname"];
            [userDefaults setObject: MMTC.auth_status forKey: @"auth_status"];
            [userDefaults setObject: MMTC.level forKey: @"level"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults synchronize];
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainViewController *tabs = [[MainViewController alloc] init];
            appDelegate.window.rootViewController = tabs;
            
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];

}



@end
