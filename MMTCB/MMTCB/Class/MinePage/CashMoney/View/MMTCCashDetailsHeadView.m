//
//  MMTCCashDetailsHeadView.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashDetailsHeadView.h"
#import "UIGestureRecognizer+YYAdd.h"
#import "MMTCProgressDetailsVC.h"

@implementation MMTCCashDetailsHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.topView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id sender) {
        NSLog(@"go to new");
        MMTCProgressDetailsVC *vc = [MMTCProgressDetailsVC new];
        vc.strId =self.strId;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.topView addGestureRecognizer:g];
    
}

- (void)updataWithMoney:(NSString *)money Status:(NSNumber *)status
{
    //0  审核中。1 审核通过 3 已打款 2审核未通过
    self.moneyLabel.text = money;
    NSInteger num = [status integerValue];
    switch (num) {
        case 0:
            _statuLabel.text = @"审核中，点击查看详情";
            break;
        case 1:
            _statuLabel.text = @"审核通过，点击查看详情";
            break;
        case 2:
            _statuLabel.text = @"审核未通过，点击查看详情";
            break;
        case 3:
            _statuLabel.text = @"已打款，点击查看详情";
            break;
            
        default:
            break;
    }
}



@end
