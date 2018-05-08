//
//  MMTCCashInfoViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/8.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashInfoViewController.h"
#import "MMTCCashModel.h"
#import "MMTCBindNewPViewController.h"

@interface MMTCCashInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) MMTCCashModel *model;
@end

@implementation MMTCCashInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _titleArray = @[@"开户名称",@"开户银行",@"身份证号",@"银行账户"];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    [self requestDataUserInfo];
}

- (void)requestDataUserInfo
{
    @weakify(self);

    [MMTCCashModel CachMoneyGetBankSuccess:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            weak_self.model = [MMTCCashModel mj_objectWithKeyValues:json[@"data"]];
            [self.dataArray addObject:weak_self.model.username];
            [self.dataArray addObject:weak_self.model.bank_name];
            [self.dataArray addObject:weak_self.model.identity_no];
            [self.dataArray addObject:weak_self.model.car_no];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - - - 更换用户
- (IBAction)changeAccountClick:(id)sender {
    
    MMTCBindNewPViewController *vc = [MMTCBindNewPViewController new];
    vc.changeAccount = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - - - - - - - deleDelegate - - - - - - - - - - -
- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = self.dataArray[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
