//
//  MMTCDetailsOrThreeCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCDetailsModel.h"

#define MMTCDetailsOrThreeCellH 210;
#define MMTCDetailsOrThreeCellH2 210 - 21;


@interface MMTCDetailsOrThreeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *discountLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatuLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *twoNameLable;
@property (weak, nonatomic) IBOutlet UILabel *twoKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hidLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payLayouHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hidLayoutHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hidTwoLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeLayout;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zeroLayout;

- (void)fillIntoModel:(MMTCDetailsModel *)model;

- (void)fillIntoMemberModel:(MMTCGroupMemberDetailModel *)model;
@end
