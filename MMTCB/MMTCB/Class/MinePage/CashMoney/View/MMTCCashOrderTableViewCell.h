//
//  MMTCCashOrderTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCCashModel.h"

#define MMTCCashOrderTableViewCellH 220

@interface MMTCCashOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yongjinMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



- (void)fillIntoDetails:(MMTCCashModel *)model;

- (void)fillIntoCashDetails:(MMTCCashModel *)model;

@end
