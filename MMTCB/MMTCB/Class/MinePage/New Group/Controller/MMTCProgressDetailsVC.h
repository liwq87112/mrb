//
//  MMTCProgressDetailsVC.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/7.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPDashedLineView.h"

@interface MMTCProgressDetailsVC : UIViewController

@property (nonatomic, copy) NSString * strId;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *payStatusLabel;

@property (weak, nonatomic) IBOutlet IPDashedLineView *lineView2;

@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

@property (weak, nonatomic) IBOutlet UILabel *payTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTextLabel2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTwoH;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
