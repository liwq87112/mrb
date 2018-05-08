//
//  MMTCDetailsGroupTwoCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsGroupTwoCell.h"

@implementation MMTCDetailsGroupTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _layerLabel.layer.borderWidth = 0.5;
    _layerLabel.layer.borderColor = [[UIColor colorWithHexString:mainColor]CGColor];
    _avatarImageView.layer.cornerRadius = _avatarImageView.kHeight/2;
    _avatarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)fillIntoModel:(MMTCDetailsMembersModel *)model WithOpenId:(NSString *)openId
{
    _nickNameLabel.text = model.nickname;
    _payTimeLabel.text = model.payed_time;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:nil];
    _orderNoLabel.text = [NSString stringWithFormat:@"团单ID：%@",openId];
}


@end
