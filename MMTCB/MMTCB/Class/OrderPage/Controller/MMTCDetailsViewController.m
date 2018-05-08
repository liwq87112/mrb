//
//  MMTCDetailsViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsViewController.h"

#import "MMTCDetailsModel.h"

@interface MMTCDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *noDiscountLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatuLabel;
@property (weak, nonatomic) IBOutlet UIButton *clickButton;

@end

@implementation MMTCDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];

    [self getRequstData];
    
    [self setlayerWithImageView:self.imageView Button:self.clickButton];
}

-(void)setlayerWithImageView:(UIImageView *)imageView Button:(UIButton *)but
{
    imageView.layer.cornerRadius = imageView.kHeight/2.0;
    imageView.layer.masksToBounds = YES;
    but.layer.cornerRadius = 3.0;
}


- (void)getRequstData{
    
    [MMTCDetailsModel OrderDetailsId:[NSNumber numberWithUnsignedInteger:[self.detailsId integerValue]] host:orderDetail Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            MMTCDetailsModel *userModel = [MMTCDetailsModel mj_objectWithKeyValues:[[data safeObjectForKey:@"data"] safeObjectForKey:@"user"]];
            [self fillIntoWithUserModel:userModel];
            
            MMTCDetailsModel *orderModel = [MMTCDetailsModel mj_objectWithKeyValues:[[data safeObjectForKey:@"data"] safeObjectForKey:@"order"]];
            [self fillIntoWithOrderModel:orderModel];
        }
    } error:^(NSError *error) {
        
    }];
    
}

- (void)fillIntoWithUserModel:(MMTCDetailsModel *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]
//                                        [NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.avatar]]
                                           placeholderImage:nil];
    self.nickNameLabel.text = model.nickname;
    self.levelLabel.text = [model.level stringValue];
}

- (void)fillIntoWithOrderModel:(MMTCDetailsModel *)model
{
    self.originLabel.text = [NSString stringWithFormat:@"¥%@",model.origin_total];
    self.discountLabel.text = [NSString stringWithFormat:@"¥%@",model.discount_money];
    self.noDiscountLabel.text = [NSString stringWithFormat:@"¥%@",model.no_discount_money];
    
    self.totalLabel.text = [NSString stringWithFormat:@"¥%@",model.total];
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单ID：%@",model.order_no];
    self.creatTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.create_time];
    self.payTimeLabel.text =[NSString stringWithFormat:@"付款时间：%@",model.pay_time];
    self.orderStatuLabel.text = model.order_status;
    
}



- (IBAction)clickIt:(id)sender {
}







@end
