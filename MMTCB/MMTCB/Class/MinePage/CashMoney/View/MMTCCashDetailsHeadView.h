//
//  MMTCCashDetailsHeadView.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MMTCCashDetailsHeadViewH 150

@interface MMTCCashDetailsHeadView : UIView

@property (strong,nonatomic) UINavigationController *navigationController;
@property (nonatomic, copy) NSString * strId;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

- (void)updataWithMoney:(NSString *)money Status:(NSNumber *)status;

@end
