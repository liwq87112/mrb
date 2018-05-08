//
//  MMTCCashHeadView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashHeadView.h"
#import "MMTCMoneyNslogViewController.h"
#import "MMTCCashMoneyViewController.h"
@implementation MMTCCashHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

#pragma mark - - - 余额明细
- (IBAction)howMoneyClick:(id)sender {
    NSLog(@"gggg");
    MMTCMoneyNslogViewController *vc = [[MMTCMoneyNslogViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - - - 提现
- (IBAction)cashMoneyClick:(id)sender {
    NSLog(@"ggggssss");
    MMTCCashMoneyViewController *vc = [[MMTCCashMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
