//
//  MMTCHomeHeadView.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BannerViewH 200.0f
@interface MMTCHomeHeadView : UIView

@property (strong,nonatomic) UINavigationController *navigationController;

@property (weak, nonatomic) IBOutlet UIButton *inputCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end
