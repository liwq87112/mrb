//
//  MMTCOrderTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MMTCOrderModel.h"
#import "MMTCDetailsModel.h"

#define MMTCOrderTableViewCellH 110
#define MMTCOrderTableViewCellGH 145


@interface MMTCOrderTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL detailsBool;

@property (weak, nonatomic) IBOutlet UIImageView *orderImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *markPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;


- (void)fillIntoModel:(MMTCOrderImageModel *)model;

- (void)fillIntoItemsModel:(MMTCDetailsItemsModel *)model;

- (void)fillIntoGroupInfoModel:(MMTCDetailsGroupInfoModel *)model;

@end
