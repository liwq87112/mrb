//
//  MMTCBugOrTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMTCOrderModel.h"

#define BuyCellH 120

@interface MMTCBugOrTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *idNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *bugStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *butStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;

- (void)fillIntoModel:(MMTCBuyOrderListModel *)model;

@end
