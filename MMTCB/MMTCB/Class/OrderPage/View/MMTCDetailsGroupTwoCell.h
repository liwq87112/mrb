//
//  MMTCDetailsGroupTwoCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCDetailsModel.h"

#define MMTCDetailsGroupTwoCellH 105

@interface MMTCDetailsGroupTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *layerLabel;

- (void)fillIntoModel:(MMTCDetailsMembersModel *)model WithOpenId:(NSString *)openId;

@end
