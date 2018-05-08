//
//  MMTCCashMoneyDetailsVC.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTCCashMoneyDetailsVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString * createTimeStr;

@property (nonatomic, copy) NSString * infoId;
@end
