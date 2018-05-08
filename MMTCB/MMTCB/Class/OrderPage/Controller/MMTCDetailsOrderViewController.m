//
//  MMTCDetailsOrderViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCDetailsOrderViewController.h"
#import "MMTCOrderTableViewCell.h"
#import "MMTCDetailsOrThreeCell.h"
#import "MMTCDetailsOrOneCell.h"

#import "MMTCDetailsModel.h"

@interface MMTCDetailsOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) MMTCDetailsModel *userModel;
@property (nonatomic, strong) MMTCDetailsModel *orderModel;

@end

@implementation MMTCDetailsOrderViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsOrThreeCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsOrThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCDetailsOrOneCell" bundle:nil] forCellReuseIdentifier:@"MMTCDetailsOrOneCell"];

    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    [self getRequstData];
}

- (void)getRequstData{
    
    @weakify(self);
    [MMTCDetailsModel OrderDetailsId:[NSNumber numberWithUnsignedInteger:[self.detailsId integerValue]] host:orderDetail Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            weak_self.userModel = [MMTCDetailsModel mj_objectWithKeyValues:[[data safeObjectForKey:@"data"] safeObjectForKey:@"user"]];

            weak_self.orderModel = [MMTCDetailsModel mj_objectWithKeyValues:[[data safeObjectForKey:@"data"] safeObjectForKey:@"order"]];
            
            self.dataArray = [MMTCDetailsItemsModel mj_objectArrayWithKeyValuesArray:[[data safeObjectForKey:@"data"] safeObjectForKey:@"items"]];
            NSLog(@"%ld",self.dataArray.count);
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        
    }];
    
}


- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_orderModel.create_time.length > 1) {
        return self.dataArray.count +2;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        MMTCDetailsOrOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsOrOneCell"];
        [cell fillIntoModel:_userModel];
        return cell ;
    }else
        if (indexPath.row == self.dataArray.count + 1) {
            MMTCDetailsOrThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCDetailsOrThreeCell"];
            [cell fillIntoModel:_orderModel];
            return cell;
        }
        else{
            MMTCDetailsItemsModel *imageModel = self.dataArray[indexPath.row-1];
            MMTCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCOrderTableViewCell"];
            [cell fillIntoItemsModel:imageModel];
            return cell;
        }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"tou");
    }
    else
        if (indexPath.row == self.dataArray.count + 1)
        {
            NSLog(@"wei");
        } else
        {
            NSLog(@"tiaoz");            
        }
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return MMTCDetailsOrOneCellH;
    }else if (indexPath.row == self.dataArray.count + 1)
    {
        if (![self isNull:_orderModel.pay_time]) {
            return MMTCDetailsOrThreeCellH2;
        }else{
            return MMTCDetailsOrThreeCellH;}
    }else{
        return MMTCOrderTableViewCellH;
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
-(BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return NO;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return NO;
    }
    else if (object==nil){
        return NO;
    }
    return YES;
}


@end
