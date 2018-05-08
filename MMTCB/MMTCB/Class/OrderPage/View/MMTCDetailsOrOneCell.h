//
//  MMTCDetailsOrOneCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCDetailsModel.h"

#define MMTCDetailsOrOneCellH 120;

@interface MMTCDetailsOrOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIButton *clickItButton;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

- (void)fillIntoModel:(MMTCDetailsModel *)model;

- (void)fillIntoMemberModel:(MMTCGroupMemberDetailModel *)model;


@end
