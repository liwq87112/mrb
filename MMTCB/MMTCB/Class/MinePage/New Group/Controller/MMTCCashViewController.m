//
//  MMTCCashViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCCashViewController.h"
#import "MMTCCashHeadView.h"
#import "CashMoneyTableViewCell.h"
#import "MMTCCashModel.h"
#import "MMTCCashMoneyDetailsVC.h"
#import "MMTCCashInfoViewController.h"

@interface MMTCCashViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong) MMTCCashHeadView   *headView;
@property(nonatomic,assign) NSInteger page;

@property (nonatomic, copy) NSString * nickNameStr;
@property (nonatomic, copy) NSString * moneyStr;

@end

@implementation MMTCCashViewController

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
    
    self.title = @"提现管理";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CashMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"CashMoneyTableViewCell"];
    
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    __weak __typeof(self) weakSelf = self;
    

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataUserInfo];
        [weakSelf requestData];
    }];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MoreData)];
    
    [self.tableView beginHeaderRefreshing];
    
}

- (void)requestDataUserInfo
{
    @weakify(self);
    [MMTCCashModel CachMoneyUserInfoSuccess:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
           weak_self.nickNameStr = data[@"data"][@"bank"];
            weak_self.moneyStr = data[@"data"][@"balance"];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
}

- (void)requestData
{
    _page = 1;
    @weakify(self);
    [self.tableView.mj_footer resetNoMoreData];
    [self.dataArray removeAllObjects];
    [MMTCCashModel CachMoneyListDataWithPage:[NSNumber numberWithInteger:_page] Success:^(NSInteger response_code, NSString *show_err, id json) {
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
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } error:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];
    }];
}

- (void)MoreData{
    
    @weakify(self);
    [MMTCCashModel CachMoneyListDataWithPage:[NSNumber numberWithInteger:_page] Success:^(NSInteger response_code, NSString *show_err, id json) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"CellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        cell.textLabel.text = @"提现账户信息";
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"收款人：%@",SAFE_NIL_STRING(_nickNameStr)];
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:mainColor];
        return cell;
    }else{
        MMTCCashModel *model = self.dataArray[indexPath.row];
        CashMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashMoneyTableViewCell"];
       
        [cell fillInto:model];
        return cell;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        if (!self.headView) {
            self.headView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCCashHeadView" owner:nil options:nil] firstObject];
            self.headView.navigationController = self.navigationController;
        }
        if (self.moneyStr) {
//            self.headView.moneyLabel.text = SAFE_NIL_STRING(self.moneyStr);
            self.headView.moneyLabel.text = [NSString stringWithFormat:@"%@",self.moneyStr];

        }
        return self.headView;
    }else{
        UIView *LabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreemW, 30)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 100, 30)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"提现记录";
        [LabelView addSubview:label];
        LabelView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
        return LabelView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MMTCCashInfoViewController *vc = [MMTCCashInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MMTCCashModel *model = self.dataArray[indexPath.row];
        MMTCCashMoneyDetailsVC *vc = [MMTCCashMoneyDetailsVC new];
        vc.createTimeStr = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return CashH;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30.0f;
    }
    return CashHeadH;
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
