//
//  MMTCDetailsOrOneCell.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsOrOneCell.h"

@implementation MMTCDetailsOrOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setlayerWithImageView:self.coverImageView Button:self.clickItButton];
}

-(void)setlayerWithImageView:(UIImageView *)imageView Button:(UIButton *)but
{
    imageView.layer.cornerRadius = imageView.kHeight/2.0;
    imageView.layer.masksToBounds = YES;
    but.layer.cornerRadius = 3.0;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fillIntoModel:(MMTCDetailsModel *)model{
    
    if ([model.avatar containsString:@"http"])
    {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.avatar]]  placeholderImage:nil];
    }
              
    self.nickNameLabel.text = model.nickname;
    self.levelLabel.text = [model.level stringValue];
}

- (void)fillIntoMemberModel:(MMTCGroupMemberDetailModel *)model
{
    if ([model.avatar containsString:@"http"])
    {
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    }else{
        
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",MMTCIMAGE,model.avatar]]  placeholderImage:nil];
    }
    
    self.nickNameLabel.text = model.nickname;
    self.levelLabel.text = model.level;
}

- (IBAction)AtHeClick:(id)sender {
    [SVProgressHUD showInfoWithStatus:@"美美正在加急开发中，敬请期待～"];
}


@end
