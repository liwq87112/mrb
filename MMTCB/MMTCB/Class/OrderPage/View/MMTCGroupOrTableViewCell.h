//
//  MMTCGroupOrTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMTCOrderModel.h"

#define GroupCellH 155

@interface MMTCGroupOrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *idNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupStateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *ogiginPricLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *numOpenLabel;

- (void)fillIntoModel:(MMTCGroupOrderListModel *)model;
@end
