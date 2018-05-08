//
//  MMTCBugOrTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCBugOrTableViewCell.h"

@implementation MMTCBugOrTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _butStateLabel.layer.borderWidth = 0.5;
    _butStateLabel.layer.borderColor = [[UIColor colorWithHexString:mainColor]CGColor];
    _butStateLabel.layer.cornerRadius = 3.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillIntoModel:(MMTCBuyOrderListModel *)model{
    self.idNoLabel.text = [NSString stringWithFormat:@"订单号:%@",model.order_no];
//    self.groupStateLabel.text = model.order_status;
    self.priceLabel.text = model.total;
    self.discountLabel.text = model.discount_txt;
    
    NSString *textStr = [NSString stringWithFormat:@"原付款 ¥%@元", model.origin_total];
    self.oldPriceLabel.attributedText = [self labelWithAttributedText:textStr];

}

//中划线
- (NSMutableAttributedString *)labelWithAttributedText:(NSString *)attributedText{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:attributedText attributes:attribtDic];
    return attribtStr;
}



@end
