//
//  LQNavigationController.m
//  LQ 0120 BUDEJIE
//
//  Created by Lqq on 16/1/20.
//  Copyright © 2016年 Lqq. All rights reserved.
//

#import "MainNavigationController.h"
#import "UIImage+Image.h"
#import "UIViewController+Util.h"

@interface MainNavigationController ()<UIGestureRecognizerDelegate>

@end
@implementation MainNavigationController


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)load
{
    if (AboveIOS9) {
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:mainFont];
        [navBar setTitleTextAttributes:dict];
   
        //未渐变时延时@"#e64a3d"
        [navBar setBackgroundColor:[UIColor whiteColor]];
        
        [navBar setBarTintColor:[UIColor whiteColor]];
         navBar.translucent = NO;
    }else{
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:mainFont];
        [[UINavigationBar appearance] setTitleTextAttributes:dict];
        [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //将系统的设置不可用
    self.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {//非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -50) forBarMetrics:UIBarMetricsDefault];
        [viewController setBackButton];
    }

    [super pushViewController:viewController animated:animated];
    
    //根据栈顶控制器 设置导航条title
    //拿到tabbar控制器
//    UITabBarController *tabbarVC = (UITabBarController *)self.tabBarController;
//    viewController.navigationItem.title = tabbarVC.selectedViewController.tabBarItem.title;
}

#pragma mark - 手势代理
//手势是否应该被识别
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count > 1) {
        return YES;
    }else{
        return NO;
    }
}


@end







