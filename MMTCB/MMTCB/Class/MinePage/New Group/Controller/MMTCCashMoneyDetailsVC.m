//
//  MMTCCashMoneyDetailsVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/4.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashMoneyDetailsVC.h"
#import "MMTCCashModel.h"
#import "MMTCCashOrderTableViewCell.h"
#import "MMTCCashDetailsHeadView.h"

@interface MMTCCashMoneyDetailsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) MMTCCashDetailsHeadView *headView;

@property (nonatomic, copy) NSString * modelStr;
@property (nonatomic, strong) NSNumber *statuNum;

@end

@implementation MMTCCashMoneyDetailsVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"提现明细";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCCashOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCCashOrderTableViewCell"];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    __weak __typeof(self) weakSelf = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MoreData)];
    
    [self.tableView beginHeaderRefreshing];
    
  
}

- (void)MoneyWithdrawDetai
{
    @weakify(self);
    [MMTCCashModel CachMoneyWithdrawDetailId:self.createTimeStr Success:^(NSInteger response_code, NSString *show_err, id json) {
          NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            weak_self.modelStr = json[@"data"][@"info"][@"money"];
            weak_self.statuNum = json[@"data"][@"info"][@"status"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
    }];
}

- (void)requestData
{
    _page = 1;
    @weakify(self);
    [self.tableView.mj_footer resetNoMoreData];
    [self.dataArray removeAllObjects];

    [MMTCCashModel CachMoneyWithdrawInfoId:self.createTimeStr Page:[NSNumber numberWithInteger:_page] Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            weak_self.page ++;
            NSArray *arr = [MMTCCashModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            if (arr.count < 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.dataArray addObjectsFromArray:arr];
            }
            NSLog(@"%ld",self.dataArray.count);
            
//            [self.tableView.mj_header endRefreshing];
            [self MoneyWithdrawDetai];//头信息
        }
    } error:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)MoreData{
    
    @weakify(self);
    [MMTCCashModel CachMoneyIncomeListWithPage:[NSNumber numberWithInteger:_page] Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            
            NSArray *arr = [MMTCCashModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            
            if (arr.count < 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                weak_self.page++;
                [self.dataArray addObjectsFromArray:arr];
                [self.tableView.mj_footer endRefreshing];
            }
            NSLog(@"%ld",self.dataArray.count);
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        [self.tableView endFooterRefreshing];
        [self.tableView endHeaderRefreshing];
    }];
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTCCashModel *model = self.dataArray[indexPath.row];
    MMTCCashOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCCashOrderTableViewCell"];
    [cell fillIntoCashDetails:model];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if (!self.headView) {
        self.headView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCCashDetailsHeadView" owner:nil options:nil] firstObject];
        self.headView.navigationController = self.navigationController;
    }
    self.headView.strId =self.createTimeStr;
    if (_modelStr.length > 0) {
        [self.headView updataWithMoney:self.modelStr Status:self.statuNum];
    }
    return self.headView;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MMTCCashOrderTableViewCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MMTCCashDetailsHeadViewH;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
