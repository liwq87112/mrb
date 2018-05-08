//
//  CashMoneyTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "CashMoneyTableViewCell.h"

@implementation CashMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillInto:(MMTCCashModel *)model
{
//    model.status
    NSInteger statu = [model.status integerValue];
    // 1 审核通过 0 审核中 3 已打款 4审核未通过
    switch (statu) {
        case 1:
            self.cashStatusLabel.text = @"提现周期（审核通过）";
            break;
        case 0:
            self.cashStatusLabel.text = @"提现周期（审核中）";
            break;
        case 2:
            self.cashStatusLabel.text = @"提现周期（审核未通过）";
            break;
        case 3:
            self.cashStatusLabel.text = @"提现周期（已打款）";
            break;
        default:
            break;
    }
    self.timeLabel.text = model.create_time;
    self.moneyLabel.text = [NSString stringWithFormat:@"+%@",model.money];
    
}

- (void)fillIntoDetails:(MMTCCashModel *)model
{
    self.cashStatusLabel.textColor = [UIColor colorWithHexString:mainColor];
    self.moneyLabel.textColor = [UIColor darkGrayColor];
    
    self.cashStatusLabel.text = [NSString stringWithFormat:@"+%@元",model.total];
    self.timeLabel.text = model.create_date;
    self.moneyLabel.text = @"包含订单";
}

@end
