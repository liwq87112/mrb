//
//  MMTCGroupMemberDetailVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/5.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCGroupMemberDetailVC.h"
#import "MMTCDetailsModel.h"

#import "MMTCDetailsOrThreeCell.h"
#import "MMTCDetailsOrOneCell.h"

@interface MMTCGroupMemberDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MMTCGroupMemberDetailModel *model;


@end

@implementation MMTCGroupMemberDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"订单详情";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsOrOneCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsOrOneCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsOrThreeCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsOrThreeCell"];
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    [self getRequstData];
}


- (void)getRequstData{
    
    //    @weakify(self);
    [MMTCDetailsModel OrderGroupMemberDetail:[NSNumber numberWithUnsignedInteger:[self.detailsId integerValue]]  Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            self.model = [MMTCGroupMemberDetailModel mj_objectWithKeyValues:[data safeObjectForKey:@"data"]];
            
            [self.dataArray addObject:@"1"];
            [self.dataArray addObject:@"1"];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
    
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MMTCDetailsOrOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsOrOneCell"];
        [cell fillIntoMemberModel:_model];
        return cell ;
    }else {
        MMTCDetailsOrThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsOrThreeCell"];
        [cell fillIntoMemberModel:_model];
        return cell;
        
    }
}


- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return MMTCDetailsOrOneCellH;
    }else
    {
        return MMTCDetailsOrThreeCellH2;
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
