//
//  MainViewController.m
//  xskj
//
//  Created by 黎芹 on 16/4/25.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "MainViewController.h"
#import "MMTCHomeViewController.h"
#import "MMTCOrderViewController.h"
#import "MMTCMineViewController.h"
#import "MainNavigationController.h"
#import "UIImage+Image.h"

@interface MainViewController ()

@end

@implementation MainViewController
+ (void)load
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //字体颜色
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#828C98"];
    //字体大小
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    //字体颜色
    dict2[NSForegroundColorAttributeName] = [UIColor colorWithHexString:mainColor];
    if (AboveIOS9) {
        UITabBarItem *tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
       
        [tabbarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
       
        [tabbarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
        
        UITabBar *tabbar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [tabbar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];

    }else{
        
        [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
        [[UITabBarItem appearance]  setTitleTextAttributes:dict2 forState:UIControlStateSelected];
        
        [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChirldVc];

}

- (void)setupAllChirldVc
{
    
    [self setupOneChirlVc:[[MMTCHomeViewController alloc] init] withImage:[UIImage imageNamedWithOriginalImage:@"order11"] selImage:[UIImage imageNamedWithOriginalImage:@"order12"] title:@"订单验证"];
    
    [self setupOneChirlVc:[MMTCOrderViewController new] withImage:[UIImage imageNamedWithOriginalImage:@"order21"] selImage:[UIImage imageNamedWithOriginalImage:@"order22"] title:@"订单管理"];
    
    [self setupOneChirlVc:[MMTCMineViewController new] withImage:[UIImage imageNamedWithOriginalImage:@"mine1"] selImage:[UIImage imageNamedWithOriginalImage:@"mine2"] title:@"我的"];

}
- (void)setupOneChirlVc:(UIViewController*)VC withImage:(UIImage *)image selImage:(UIImage *)selImage title:(NSString *)title
{
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = image;
    nav.tabBarItem.selectedImage = selImage;

}



@end
