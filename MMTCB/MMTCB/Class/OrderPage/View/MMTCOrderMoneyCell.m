//
//  MMTCOrderMoneyCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderMoneyCell.h"

@implementation MMTCOrderMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fillIntoModel:(MMTCOrderModel *)model{
    if ([model.discount_money isEqualToString:@"0.00"]) {
         self.totalLabel.text = [NSString stringWithFormat:@"合计：¥%@",model.total];
    }else{
        self.totalLabel.text = [NSString stringWithFormat:@"合计：¥%@(订单优惠-¥%@)",model.total,model.discount_money];}
}
@end
