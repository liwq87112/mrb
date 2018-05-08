//
//  MMTCMineViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCMineViewController.h"
#import "MMTCMineHeadView.h"
#import "MMTCProductManagerVC.h"
#import "MMTCCashViewController.h"
#import "MMTCPswViewController.h"
#import "MMTCBindingPViewController.h"
#import "MMTCFeedbackViewController.h"
#import "MMTCAboutViewController.h"
@interface MMTCMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) MMTCMineHeadView   *headView;
@property (nonatomic, strong) NSArray *StrArray;

@end

@implementation MMTCMineViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self mainColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self mainColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self whiteColor];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"商家后台";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    
//    self.StrArray = @[@"产品管理",@"财务管理",@"密码修改",@"手机绑定",@"意见反馈",@"在线客服",@"关于我们"];
     self.StrArray = @[@"财务管理",@"密码修改",@"手机绑定",@"意见反馈",@"关于我们"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.StrArray[indexPath.section];
    }else{
        cell.textLabel.text = self.StrArray[indexPath.row+(indexPath.section-1)*2+1];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (!self.headView) {
            self.headView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCMineHeadView" owner:nil options:nil] firstObject];
            self.headView.navigationController = self.navigationController;
        }
        [self.headView upDataMine];
        return self.headView;
    }
    else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return MineHeadViewH;
    }
    return CGFLOAT_MIN;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"dianji %@",self.StrArray[indexPath.row+indexPath.section*2]);
//    NSInteger row = indexPath.row+indexPath.section*2;
//    switch (row) {
//        case 0:{
//            MMTCProductManagerVC *vc = [[MMTCProductManagerVC alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];}
//            break;
//        case 1:{
//            MMTCCashViewController *vc = [[MMTCCashViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];}
//            break;
//        case 2:{
//            MMTCPswViewController *vc = [[MMTCPswViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];}
//            break;
//        case 3:{
//            MMTCBindingPViewController *vc = [[MMTCBindingPViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];}
//            break;
//        case 4:{
//            MMTCFeedbackViewController *vc = [[MMTCFeedbackViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];}
//            break;
//
//        default:
//            break;
//    }
    
    if (indexPath.section == 0) {
        MMTCCashViewController *vc = [[MMTCCashViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSInteger row = indexPath.row+(indexPath.section -1)*2+1;
        switch (row) {
            case 1:{
                MMTCPswViewController *vc = [[MMTCPswViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];}
                break;
            case 2:{
                MMTCBindingPViewController *vc = [[MMTCBindingPViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];}
                break;
            case 3:{
                MMTCFeedbackViewController *vc = [[MMTCFeedbackViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];}
                break;
            case 4:{
                MMTCAboutViewController *vc = [[MMTCAboutViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];}
                break;
            default:
                break;
        }
    }
   

}

@end
