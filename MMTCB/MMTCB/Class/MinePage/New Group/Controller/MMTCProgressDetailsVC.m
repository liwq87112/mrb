//
//  MMTCProgressDetailsVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/7.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCProgressDetailsVC.h"
#import "MMTCCashModel.h"
#import "MMTCCashMoneyViewController.h"



@interface MMTCProgressDetailsVC ()

@end

@implementation MMTCProgressDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"进度详情";
    
    self.lineOneH.constant = 122 - 20;
    self.lineTwoH.constant = 187 - 20;
    
    [self questData];
}

- (void)questData
{
    [MMTCCashModel CachMoneyWithdrawStepDetailId:self.strId Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            //0  审核中。1 审核通过 3 已打款 2审核未通过
            MMTCCashModel *model = [MMTCCashModel mj_objectWithKeyValues:json[@"data"]];
            self.timeLabel.text = model.create_time;
            self.moneyLabel.text = model.money;
            NSInteger num = [model.status integerValue];
            
            switch (num) {
                case 0:
                    self.statusLabel.text = @"审核中";
                    self.statusLabel.textColor = [UIColor colorWithHexString:mainColor];
                    self.payTextLabel.textColor = [UIColor colorWithHexString:mainColor];
                    self.payStatusLabel.text = @"待支付";
                    self.imageViewTwo.image = [UIImage imageNamed:@"fail"];
                    self.imageViewThree.image = [UIImage imageNamed:@"more"];
                    
                    self.lineView2.lengthPattern = @[@5, @5];
                    self.lineView2.lineColor = [UIColor lightGrayColor];
                    [self.lineView2 setNeedsDisplay];

                    break;
                case 1:
                    self.statusLabel.text = @"审核已通过";
                    self.payTextLabel2.textColor = [UIColor colorWithHexString:mainColor];
                    self.payStatusLabel.textColor = [UIColor colorWithHexString:mainColor];
                    self.payStatusLabel.text = @"待支付";
                    self.imageViewTwo.image = [UIImage imageNamed:@"suc"];
                    self.imageViewThree.image = [UIImage imageNamed:@"more"];
                    
                    self.lineView2.lengthPattern = @[@5, @5];
                    self.lineView2.lineColor = [UIColor lightGrayColor];
                    [self.lineView2 setNeedsDisplay];

                    break;
                case 2:
                    self.statusLabel.text = @"审核未通过";
                    self.statusLabel.textColor = [UIColor colorWithHexString:mainColor];
                    self.payStatusLabel.text = @"待支付";
                    self.imageViewTwo.image = [UIImage imageNamed:@"fail"];
                    self.imageViewThree.image = [UIImage imageNamed:@"more"];
                    
                    self.lineView2.lengthPattern = @[@5, @5];
                    self.lineView2.lineColor = [UIColor lightGrayColor];
                    [self.lineView2 setNeedsDisplay];
                    break;
                case 3:
                    self.statusLabel.text = @"审核已通过";
                    
                    self.payTextLabel2.textColor = [UIColor colorWithHexString:mainColor];
                    self.payStatusLabel.textColor = [UIColor colorWithHexString:mainColor];
                    
                    self.payStatusLabel.text = @"已打款";
                    self.imageViewTwo.image = [UIImage imageNamed:@"suc"];
                    self.imageViewThree.image = [UIImage imageNamed:@"suc"];
                    
                    self.lineView2.lengthPattern = @[@5, @5];
                    self.lineView2.lineColor = [UIColor clearColor];
                    self.lineView2.backgroundColor = [UIColor colorWithHexString:@"#FFD539"];
                    [self.lineView2 setNeedsDisplay];

                    break;
                    
                    
                default:
                    break;
            }
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - - - 重新提现
- (IBAction)againCashClick:(id)sender {
    MMTCCashMoneyViewController *vc = [MMTCCashMoneyViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end


