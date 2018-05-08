//
//  MMTCConfirmPswViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCConfirmPswViewController.h"

@interface MMTCConfirmPswViewController ()
//@property (weak, nonatomic) IBOutlet UITextField *pswTextField;

@end

@implementation MMTCConfirmPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    
    _pswTextField.secureTextEntry = YES;
    [self layercorder:_pswTextField];
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

- (IBAction)securityClick:(id)sender {
    _pswTextField.secureTextEntry = !_pswTextField.secureTextEntry;
    
    if (_pswTextField.secureTextEntry) {
        
        [_securityButton setImage:[UIImage imageNamed:@"login_eyeopen"] forState:UIControlStateNormal];
        
    }else
    {
        [_securityButton setImage:[UIImage imageNamed:@"login_eyeclose"] forState:UIControlStateNormal];
    }
}

- (IBAction)confirmClick:(id)sender {
    
    if (![self judgePassWordLegal:self.pswTextField.text]) {
        return;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
@end
