//
//  MMTCAboutViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCAboutViewController.h"
#import "MMTCAboutView.h"

@interface MMTCAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) MMTCAboutView   *headView;
@end

@implementation MMTCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
}

#pragma mark - - - - - - - deleDelegate - - - - - - - - - - -
- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text = @"官方客服";
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = @"400-184-8008";
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!self.headView) {
        self.headView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCAboutView" owner:nil options:nil] firstObject];
    }
    [self.headView upDataMine];
    return self.headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //打电话
    [self telephone];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MMTCAboutViewH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (BOOL)isCurrentMobileSystem10_2 {
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [systemVersion compare:@"10.2" options:NSNumericSearch] == NSOrderedSame) {
        return YES;
    }
    return NO;
}

-(void)telephone {
    if ([self isCurrentMobileSystem10_2]) {
        //IOS10.2之后
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001848008"]]];
    }
    else {
        //IOS10.2之前
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"4001848008" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4001848008"]]];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


@end
