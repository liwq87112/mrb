//
//  MMTCUserCodeViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCUserCodeViewController.h"
#import "MMTCHomeModel.h"
#import "MMTCUserMoneyModel.h"
#import "MMTCVerificationDetailsVC.h"
#import "MMTCVerificationSuccessVC.h"

@interface MMTCUserCodeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *validationTextField;
@property (nonatomic, strong) NSString *inputStr;

@end

@implementation MMTCUserCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"输入消费码";
    
    [self buttonWithLay:self.zeroButton];
    [self buttonWithLay:self.oneButton];
    [self buttonWithLay:self.twoButton];
    [self buttonWithLay:self.threeButton];
    [self buttonWithLay:self.fourButton];
    [self buttonWithLay:self.fiveButton];
    [self buttonWithLay:self.sixButton];
    [self buttonWithLay:self.severButton];
    [self buttonWithLay:self.eightButton];
    [self buttonWithLay:self.nightButton];
    [self buttonWithLay:self.codeButton];
    
    [self layercorder:self.validationTextField];
}



#pragma mark - - - TextField
- (void)layercorder:(UITextField *)textfield{
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.clearButtonMode=UITextFieldViewModeAlways;
    textfield.delegate = self;
}

- (void)buttonWithLay:(UIButton *)button{
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [[UIColor colorWithHexString:PlaColor]CGColor];
    
    button.layer.cornerRadius = button.kHeight/2.f;
    button.layer.masksToBounds = YES;
}

#pragma mark - - - 验证
- (IBAction)validationClick:(id)sender {
 
    [MMTCUserMoneyModel HomeUserMoneyP:@3 Psw:[_validationTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""]  Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            MMTCUserMoneyModel *model = [MMTCUserMoneyModel mj_objectWithKeyValues:data];
            if ([model.is_used isEqual:@1]) {
                //用过
                MMTCVerificationSuccessVC *vc = [[MMTCVerificationSuccessVC alloc]init];
                vc.status = @2;
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                MMTCVerificationDetailsVC *vc = [[MMTCVerificationDetailsVC alloc]init];
                vc.model = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];

}

#pragma mark - - -  输入验证码
- (IBAction)inputClick:(UIButton *)sender {
    
    if (self.validationTextField.text.length > 13) {
        return;
    }
    
    if (self.validationTextField.text.length > 0) {
        self.validationTextField.text = [NSString stringWithFormat:@"%@%ld",self.validationTextField.text,sender.tag - 1];
        if (self.validationTextField.text.length == 4) {
            self.validationTextField.text =[NSString stringWithFormat:@"%@ ",self.validationTextField.text];
        }
        if (self.validationTextField.text.length == 9) {
            self.validationTextField.text =[NSString stringWithFormat:@"%@ ",self.validationTextField.text];
        }
        
    }else{
        self.validationTextField.text = [NSString stringWithFormat:@"%ld",sender.tag - 1];
    }

    //可以验证
    if (self.validationTextField.text.length > 13) {
        _codeButton.userInteractionEnabled = YES;
        [_codeButton setBackgroundColor:[UIColor colorWithHexString:mainColor]];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        _codeButton.userInteractionEnabled = NO;
        [_codeButton setBackgroundColor:[UIColor colorWithHexString:viewBackgroundColor]];
        [_codeButton setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField*)textField
{
    _codeButton.userInteractionEnabled = NO;
    [_codeButton setBackgroundColor:[UIColor colorWithHexString:viewBackgroundColor]];
    [_codeButton setTitleColor:[UIColor colorWithHexString:titleColor] forState:UIControlStateNormal];
    return YES;
}

@end
