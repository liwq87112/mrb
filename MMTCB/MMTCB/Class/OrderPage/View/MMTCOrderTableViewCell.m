//
//  MMTCOrderTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderTableViewCell.h"

@implementation MMTCOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _orderState.layer.borderWidth = 0.5;
    _orderState.layer.borderColor = [[UIColor colorWithHexString:mainColor]CGColor];
    _orderState.layer.cornerRadius = 3.0;
    _orderState.hidden = YES;
    _bgView.hidden = YES;
}

- (void)fillIntoModel:(MMTCOrderImageModel *)model
{
    [self.orderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.cover]] placeholderImage:nil];
    self.titleLabel.text = model.title;
    
    if (model.item_status.length > 1) {
        _orderState.hidden = NO;
        self.orderState.text = model.item_status;
    }
    
    self.priceLabel.text = model.price;
    self.numLabel.text = [NSString stringWithFormat:@"数量：%@",model.num];
    
    NSString *textStr = [NSString stringWithFormat:@"门市价 ¥%@元", model.market_price];
    self.markPriceLabel.attributedText = [self labelWithAttributedText:textStr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//中划线
- (NSMutableAttributedString *)labelWithAttributedText:(NSString *)attributedText
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:attributedText attributes:attribtDic];
    return attribtStr;
}

- (void)fillIntoItemsModel:(MMTCDetailsItemsModel *)model
{
     [self.orderImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.cover]] placeholderImage:nil];
     self.titleLabel.text = model.title;
    self.priceLabel.text = model.price;
    self.numLabel.text = [NSString stringWithFormat:@"数量：%@",model.num];
    NSString *textStr = [NSString stringWithFormat:@"门市价 ¥%@元", model.market_price];
    self.markPriceLabel.attributedText = [self labelWithAttributedText:textStr];
}

- (void)fillIntoGroupInfoModel:(MMTCDetailsGroupInfoModel *)model
{
    
    if ([model.cover containsString:@"http"])
    {
        [self.orderImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    }else{
        [self.orderImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.cover]]  placeholderImage:nil];
    }

    self.titleLabel.text = model.title;
    self.priceLabel.text = model.price;
//    self.numLabel.text = [NSString stringWithFormat:@"数量：%@",model.num];
    self.numLabel.hidden = YES;
    _bgView.hidden = NO;
    NSString *textStr = [NSString stringWithFormat:@"门市价 ¥%@", model.origin_price];
    self.markPriceLabel.attributedText = [self labelWithAttributedText:textStr];
}

@end
