//
//  MMTCHomeTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCHomeModel.h"
#define CellH 165.0f

@interface MMTCHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)fillInto:(MMTCHomeModel *)model;
@end
