//
//  UITableViewController+Category.m
//  com
//
//  Created by lwq on 2016/11/22.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import "UITableViewController+Category.h"

@implementation UITableViewController (Category)

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

@end
