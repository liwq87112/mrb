//
//  MMTCDetailsGroupViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsGroupViewController.h"
#import "MMTCDetailsModel.h"

#import "MMTCDetailsGroupThreeCell.h"
#import "MMTCDetailsGroupTwoCell.h"
#import "MMTCDetailsGroupCell.h"
#import "MMTCOrderTableViewCell.h"
#import "MMTCDetailsOrderViewController.h"
#import "MMTCGroupMemberDetailVC.h"

@interface MMTCDetailsGroupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MMTCDetailsGroupInfoModel *model;


@end

@implementation MMTCDetailsGroupViewController

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
    
    self.title = @"订单详情";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCOrderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsGroupCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsGroupCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsGroupTwoCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsGroupTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsGroupThreeCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsGroupThreeCell"];
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    [self getRequstData];
}

- (void)getRequstData{
    
//    @weakify(self);
    [MMTCDetailsModel OrderDetailsId:[NSNumber numberWithUnsignedInteger:[self.detailsId integerValue]] host:groupDetail Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            self.model = [MMTCDetailsGroupInfoModel mj_objectWithKeyValues:[[data safeObjectForKey:@"data"] safeObjectForKey:@"group_info"]];
            
            self.dataArray = [MMTCDetailsMembersModel mj_objectArrayWithKeyValuesArray:[[data safeObjectForKey:@"data"] safeObjectForKey:@"members"]];
            NSLog(@"%ld",self.dataArray.count);
            
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
    
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (_orderModel.create_time.length > 1) {
//        return self.dataArray.count +2;
//    }
    return self.dataArray.count+3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MMTCDetailsGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsGroupCell"];
        [cell fillIntoModel:_model];
        return cell ;
    }else if (indexPath.row == 1) {
        MMTCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCOrderTableViewCell"];
        [cell fillIntoGroupInfoModel:_model];
        return cell;
    }else if (indexPath.row == self.dataArray.count + 2)
    {
        MMTCDetailsGroupThreeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsGroupThreeCell"];
        [cell fillIntoModel:_model];
        return cell;
    }
    else{
        MMTCDetailsMembersModel *memModel = self.dataArray[indexPath.row-2];
        MMTCDetailsGroupTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsGroupTwoCell"];
        [cell fillIntoModel:memModel WithOpenId:_model.open_id];
        return cell;
    }
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"tou");
    }
    else if (indexPath.row == 1) {
        NSLog(@"编辑");
    }
    else if (indexPath.row == self.dataArray.count + 2) {
        NSLog(@"尾");
    }else{
        MMTCDetailsMembersModel *memModel = self.dataArray[indexPath.row-2];
        MMTCGroupMemberDetailVC *vc = [[MMTCGroupMemberDetailVC alloc]init];
        vc.detailsId = memModel.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return MMTCDetailsGroupCellH;
    }else if (indexPath.row == 1)
    {
        return MMTCOrderTableViewCellGH;
    }else if (indexPath.row == self.dataArray.count + 2)
    {
        return MMTCDetailsGroupThreeCellH;
    }
    else{
        return MMTCDetailsGroupTwoCellH;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
