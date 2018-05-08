//
//  MMTCDetailsGroupThreeCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCDetailsModel.h"

#define MMTCDetailsGroupThreeCellH 240

@interface MMTCDetailsGroupThreeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *originPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *openIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *openTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *expireTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (void)fillIntoModel:(MMTCDetailsGroupInfoModel *)model;

@end
