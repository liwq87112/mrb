//
//  MMTCCashOrderTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashOrderTableViewCell.h"

@implementation MMTCCashOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFrame:(CGRect)frame
{
    CGFloat w =10;
    frame.origin.y+=w/2;
    frame.size.height-=w;
    [super setFrame:frame];
}

- (void)fillIntoDetails:(MMTCCashModel *)model
{
    _orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",model.order_no];
    _titleLabel.text = [NSString stringWithFormat:@"【%@】%@",model.category_title,model.title];
    _timeLabel.text = model.used_date_time;
    _nickNameLabel.text = model.nickname;
    
    _orderMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.money];
    _yongjinMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.yongjin];
    _priceLabel.text =  [NSString stringWithFormat:@"%@",model.tixian_money];
}

- (void)fillIntoCashDetails:(MMTCCashModel *)model
{
    _orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",model.order_id];
    _titleLabel.text = [NSString stringWithFormat:@"【%@】%@",model.category_title,model.title];
    _timeLabel.text = model.used_date_time;
    _nickNameLabel.text = model.nickname;
    
    _orderMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    _yongjinMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    _priceLabel.text =  [NSString stringWithFormat:@"%@",model.tixian_money];
}

@end
