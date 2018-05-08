//
//  MMTCOrderHeadView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderHeadView.h"
#import "MMTCSeachHistoryViewController.h"

@implementation MMTCOrderHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (IBAction)historyClick:(id)sender {
    MMTCSeachHistoryViewController *vc = [MMTCSeachHistoryViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
