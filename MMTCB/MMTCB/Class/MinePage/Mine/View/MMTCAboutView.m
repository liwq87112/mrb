//
//  MMTCAboutView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCAboutView.h"

@implementation MMTCAboutView

- (void)awakeFromNib
{
    [super awakeFromNib];
    

}


- (void)upDataMine
{
    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    
    //获取最新的版本号
    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    self.curVersionLabel.text = [NSString stringWithFormat:@"v%@",curVersion];
}

@end
