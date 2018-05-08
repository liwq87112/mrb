//
//  UITableViewController+UITableViewController_showInfo_.m
//  com
//
//  Created by lwq on 2016/11/15.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import "UITableViewController+UITableViewController_showInfo_.h"

@implementation UITableViewController (UITableViewController_showInfo_)

#pragma mark - 警示
-(void)showWithInfo:(NSString *)info
{
    UILabel *hud = [[UILabel alloc]initWithFrame:CGRectMake(0, -hudHH, ScreemW, hudHH)];
    hud.backgroundColor = hudBackgroundColor;
    hud.textColor = [UIColor whiteColor];
    hud.textAlignment = NSTextAlignmentCenter;
    [hud setFont:[UIFont systemFontOfSize:19]];
    hud.adjustsFontSizeToFitWidth = YES;
    hud.text = info;
    [ self.view addSubview : hud ] ;
    
    [UIView animateWithDuration:0.5 animations:^{
        hud.lq_y = 0;
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                hud.lq_y = -hudHH ;
            } completion:^(BOOL finished) {
                [hud removeFromSuperview];
            }];
            
        });
        
    }];
    
    
}

-(void)viewDidLoad
{
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
}


#pragma mark- 主颜色
-(void)mainColor
{
    if (AboveIOS9) {
        UINavigationBar *navBar = self.navigationController.navigationBar;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [navBar setTitleTextAttributes:dict];
        
        //未渐变时延时@"#e64a3d"
        [navBar setBackgroundColor:[UIColor colorWithHexString:mainColor]];
        
        [navBar setBarTintColor:[UIColor colorWithHexString:mainColor]];
        navBar.translucent = NO;
    }else{
        UINavigationBar *navBar = self.navigationController.navigationBar;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [navBar setTitleTextAttributes:dict];
        [navBar setBackgroundColor:[UIColor colorWithHexString:mainColor]];
        [navBar setBarTintColor:[UIColor colorWithHexString:mainColor]];
        [navBar setTranslucent:NO];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [self.navigationItem setHidesBackButton:YES];

    
    UIButton *backBtn = self.navigationItem.leftBarButtonItem.customView;
    [backBtn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateHighlighted];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


#pragma mark- 白颜色
-(void)whiteColor
{
    if (AboveIOS9) {
        UINavigationBar *navBar = self.navigationController.navigationBar;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:mainFont];
        [navBar setTitleTextAttributes:dict];
        
        //未渐变时延时@"#e64a3d"
        [navBar setBackgroundColor:[UIColor whiteColor]];
        
        [navBar setBarTintColor:[UIColor whiteColor]];
        navBar.translucent = NO;
    }else{
        UINavigationBar *navBar = self.navigationController.navigationBar;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:mainFont];
        [navBar setTitleTextAttributes:dict];
        [navBar setBackgroundColor:[UIColor whiteColor]];
        [navBar setBarTintColor:[UIColor whiteColor]];
        [navBar setTranslucent:NO];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            [self.navigationItem setHidesBackButton:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}

@end
