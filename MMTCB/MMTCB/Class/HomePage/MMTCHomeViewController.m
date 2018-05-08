//
//  MMTCHomeViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCHomeViewController.h"
#import "LoginViewController.h"
@interface MMTCHomeViewController ()

@end

@implementation MMTCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"商家后台";

    NSLog(@"objectForKey%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MMTCLOG"]);
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"MMTCLOG"] == nil) {
        NSLog(@"没有登录进入");
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:NO completion:nil];
    }else{
        NSLog(@"登录进入");

    }
}



@end
