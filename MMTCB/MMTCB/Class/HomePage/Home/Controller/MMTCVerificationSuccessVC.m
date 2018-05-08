//
//  MMTCVerificationSuccessVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/3.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCVerificationSuccessVC.h"

@interface MMTCVerificationSuccessVC ()

@property (weak, nonatomic) IBOutlet UIImageView *statusIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLABEL;
@property (weak, nonatomic) IBOutlet UILabel *nickNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MMTCVerificationSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"验证结果";
    
    if ([_status isEqual:@2]) {
        _statusLabel.text = @"订单已验证";
        _textLabel.text = @"您已经验证过了，不用再验证啦～";
        
        [self getDataRequest];
    }else{
        _orderLabel.hidden = YES;
        _bgView.hidden = YES;
        _statusLabel.text = @"验证成功";
        _textLabel.text = [NSString stringWithFormat:@"订单：%@ 已完成验证",_model.order_no];
    }
    
    
    
}


- (void)getDataRequest
{
    @weakify(self);
    [MMTCUserMoneyModel HomeverificationConfirmIDInfo:_model.id Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            //成功
            MMTCUserMoneyModel *model = [MMTCUserMoneyModel mj_objectWithKeyValues:data[@"data"]];
            if ([data[@"status"] isEqual:@1]) {
                weak_self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",model.order_no];
                weak_self.titleLabel.text = [NSString stringWithFormat:@"【%@】%@",model.category,model.title];
                weak_self.nickNamelabel.text = model.nickname;
                weak_self.priceLabel.text = model.total;
                weak_self.timeLABEL.text = model.used_date_time;
            }
            
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
}

-(void)popViewControllerAnimated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
