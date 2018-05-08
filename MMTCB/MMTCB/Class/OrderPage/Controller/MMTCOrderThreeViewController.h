//
//  MMTCOrderThreeViewController.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSSegmentTitleView.h"
@interface MMTCOrderThreeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FSSegmentTitleView * firstTitleView;
@property (nonatomic, strong) FSSegmentTitleView * twoTitleView;

@property (nonatomic, assign) NSInteger firstNum;
@property (nonatomic, assign) NSInteger twoNum;

@end
