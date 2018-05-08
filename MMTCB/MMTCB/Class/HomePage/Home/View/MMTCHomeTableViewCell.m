//
//  MMTCHomeTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCHomeTableViewCell.h"

@implementation MMTCHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)fillInto:(MMTCHomeModel *)model{
    self.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",model.order_no];
    self.titleLabel.text = [NSString stringWithFormat:@"【%@】%@",model.category,model.title];
    self.timeLabel.text = model.used_date_time;
    self.nameLabel.text = model.nickname;
    self.moneyLabel.text = model.total;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
