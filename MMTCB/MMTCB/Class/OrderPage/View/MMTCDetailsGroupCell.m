//
//  MMTCDetailsGroupCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsGroupCell.h"

@implementation MMTCDetailsGroupCell

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
    // 0  拼团中。/1 OK 2 失败
    if ([model.status isEqualToString:@"0"]) {
        _statuimageView.image = [UIImage imageNamed:@"clock"];
         _leftNumLabel.text = [NSString stringWithFormat:@"还差 %@ 人成团",model.left_count];
        _leftTimeLabel.text = [NSString stringWithFormat:@"剩余时间：%@",model.left_time];
    }
    if ([model.status isEqualToString:@"1"]) {
        _statuimageView.image = [UIImage imageNamed:@"ok"];
         _leftNumLabel.text = @"拼团成功";
        _leftTimeLabel.text = [NSString stringWithFormat:@"开团时间：%@",model.open_time];
    }
    if ([model.status isEqualToString:@"2"]) {
        _statuimageView.image = [UIImage imageNamed:@"error"];
         _leftNumLabel.text = [NSString stringWithFormat:@"团单失效 还差 %@ 人成团",model.left_count];
        _leftTimeLabel.text = [NSString stringWithFormat:@"失效日期：%@",model.expire_time];
    }

}

@end
