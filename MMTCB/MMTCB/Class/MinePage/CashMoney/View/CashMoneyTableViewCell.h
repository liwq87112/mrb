//
//  CashMoneyTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCCashModel.h"

#define CashH 60
@interface CashMoneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cashStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)fillInto:(MMTCCashModel *)model;

- (void)fillIntoDetails:(MMTCCashModel *)model;

@end
