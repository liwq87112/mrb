//
//  MMTCOrderIdTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderIdTableViewCell.h"

@implementation MMTCOrderIdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillIntoModel:(MMTCOrderModel *)model{
    self.orderStateLabel.text = model.order_status;
    self.orderIdLabel.text = [NSString stringWithFormat:@"产品号:%@",model.order_no];
}

@end
