//
//  MMTCCashHeadView.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CashHeadH 200.0f
@interface MMTCCashHeadView : UIView

@property (strong,nonatomic) UINavigationController *navigationController;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *cashButton;


@end
