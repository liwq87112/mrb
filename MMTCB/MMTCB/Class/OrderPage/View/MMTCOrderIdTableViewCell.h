//
//  MMTCOrderIdTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCOrderModel.h"
@interface MMTCOrderIdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;

- (void)fillIntoModel:(MMTCOrderModel *)model;

@end