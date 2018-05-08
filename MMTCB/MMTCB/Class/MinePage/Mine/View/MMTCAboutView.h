//
//  MMTCAboutView.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MMTCAboutViewH 220

@interface MMTCAboutView : UIView

@property (weak, nonatomic) IBOutlet UILabel *curVersionLabel;

- (void)upDataMine;

@end
