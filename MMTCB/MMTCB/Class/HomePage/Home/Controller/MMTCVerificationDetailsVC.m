//
//  MMTCVerificationDetailsVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/3.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCVerificationDetailsVC.h"
#import "MMTCVerificationSuccessVC.h"

@interface MMTCVerificationDetailsVC ()
@property (weak, nonatomic) IBOutlet UIImageView *covorImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *subButton;

@end

@implementation MMTCVerificationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([_model.cover containsString:@"http"])
    {
        [self.covorImageView sd_setImageWithURL:[NSURL URLWithString:_model.cover]];
    }else{
        [self.covorImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",MMTCIMAGE,_model.cover]]  placeholderImage:nil];
    }
    _orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",_model.order_no];
    _nickNameLabel.text = [NSString stringWithFormat:@"用户%@",_model.nickname];
    _titleLabel.text = [NSString stringWithFormat:@"【%@】%@",_model.category,_model.title];
    _priceLabel.text = _model.total;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmClick:(id)sender {
    
    @weakify(self);
    [MMTCUserMoneyModel HomeverificationConfirmID:_model.id Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            //成功
            if ([data[@"status"] isEqual:@1]) {
                MMTCVerificationSuccessVC *vc = [[MMTCVerificationSuccessVC alloc]init];
                vc.model = weak_self.model;
                vc.status = @1;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
}



@end
