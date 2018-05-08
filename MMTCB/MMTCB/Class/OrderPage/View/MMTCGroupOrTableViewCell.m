//
//  MMTCGroupOrTableViewCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCGroupOrTableViewCell.h"

@implementation MMTCGroupOrTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)fillIntoModel:(MMTCGroupOrderListModel *)model
{
    self.idNoLabel.text = [NSString stringWithFormat:@"团单ID:%@",model.id_no];
    self.groupStateLabel.text = model.order_status;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.cover]] placeholderImage:nil];
    self.groupTitleLabel.text = model.title;
    self.ogiginPricLabel.text = model.price;
    self.oldPriceLabel.text = model.origin_price;
    self.numOpenLabel.text = [NSString stringWithFormat:@"%@人团",model.num];
    if ([model.left_num integerValue] == 0) {
        self.groupNumLabel.text = [NSString stringWithFormat:@"满%@人团",model.num_used];
    }else{
        self.groupNumLabel.text = [NSString stringWithFormat:@"还差%@人成团",model.left_num];
    }
}

@end
