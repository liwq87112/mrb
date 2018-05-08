//
//  MMTCDetailsGroupThreeCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsGroupThreeCell.h"

@implementation MMTCDetailsGroupThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillIntoModel:(MMTCDetailsGroupInfoModel *)model
{
    
    _productIdLabel.text = model.item_id;
    _numLabel.text = [NSString stringWithFormat:@"%@人团",model.num];

    NSString *textStr = [NSString stringWithFormat:@"¥%@", model.origin_price];
    _originPriceLabel.attributedText = [self labelWithAttributedText:textStr];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    _openIDLabel.text = [NSString stringWithFormat:@"团单ID：%@",model.open_id];
    _openTimeLabel.text = [NSString stringWithFormat:@"开团时间：%@",model.open_time];
    // 0  拼团中。/1 OK 2 失败
    if ([model.status isEqualToString:@"0"])
    {
        _expireTimeLabel.text = [NSString stringWithFormat:@"预计到期：%@",model.expire_time];
        _statusLabel.text = @"进行中";
    }
    if ([model.status isEqualToString:@"1"])
    {
         _expireTimeLabel.text = [NSString stringWithFormat:@"成团时间：%@",model.done_time];
        _statusLabel.text = @"拼团成功";
    }
    if ([model.status isEqualToString:@"2"])
    {
         _expireTimeLabel.text = [NSString stringWithFormat:@"失效时间：%@",model.expire_time];
        _statusLabel.text = @"团单失效";
    }
}


- (NSMutableAttributedString *)labelWithAttributedText:(NSString *)attributedText
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:attributedText attributes:attribtDic];
    return attribtStr;
}


@end
