//
//  MMTCDetailsOrThreeCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsOrThreeCell.h"

@implementation MMTCDetailsOrThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillIntoModel:(MMTCDetailsModel *)model{

    self.discountLabel.text = @"无";
//    [NSString stringWithFormat:@"¥%@",model.discount_money];
    self.allMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.origin_total];

    self.totalLabel.text = [NSString stringWithFormat:@"¥%@",model.total];
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单ID：%@",model.order_no];
    self.creatTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.create_time];
    if (![self isNull:model.pay_time]) {
        NSLog(@"go");
        _payLayouHeight.constant = 0;
    }else{
        self.payTimeLabel.text =[NSString stringWithFormat:@"付款时间：%@",model.pay_time];}
    self.orderStatuLabel.text = model.order_status;
}

-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}

- (void)fillIntoMemberModel:(MMTCGroupMemberDetailModel *)model
{
    _twoNameLable.hidden = YES;
    _discountLabel.hidden = YES;
    _hidLabel.hidden = YES;
    
//    _hidLayoutHeight.constant = 0;;
//    _hidTwoLayout.constant = 0;
//    _threeLayout.constant = 0;
    _zeroLayout.constant = -21;
    
    self.totalLabel.text = [NSString stringWithFormat:@"¥%@",model.money];
    
    self.firstNameLabel.text = @"成员身份";
    
    if ([model.is_leader integerValue] == 1) {
        self.allMoneyLabel.text = @"团长";
    }else{
        self.allMoneyLabel.text = @"团员";
    }

    self.orderNoLabel.text = [NSString stringWithFormat:@"订单ID：%@",model.order_no];
    self.creatTimeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.payed_time];

    self.payTimeLabel.text =[NSString stringWithFormat:@"拼团状态：%@",model.group_status];
    self.orderStatuLabel.text = model.pay_status;
}
@end
