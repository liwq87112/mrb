//
//  MMTCFailureScanViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/3.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCFailureScanViewController.h"
#import "QCodeController.h"
#import "MMTCUserCodeViewController.h"

@interface MMTCFailureScanViewController ()

@end

@implementation MMTCFailureScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"验证结果";
}


- (IBAction)goOnScanClick:(id)sender {
    QCodeController *vc = [QCodeController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)inputClick:(id)sender {
    MMTCUserCodeViewController * code = [MMTCUserCodeViewController new];
    [self.navigationController pushViewController:code animated:YES];
}

-(void)popViewControllerAnimated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
