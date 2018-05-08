//
//  MMTCProductManagerTwoVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCProductManagerTwoVC.h"
#import "MMTCProductTableViewCell.h"
#import "MMTCHomeModel.h"
@interface MMTCProductManagerTwoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArry;
@property (nonatomic, strong) NSMutableArray *homeArray;
@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NetworkTask *task;

@end

@implementation MMTCProductManagerTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self initaWithTableView];
    
    [self addMJRefresh];
}


- (void)initaWithTableView{
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }

    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCProductTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCProductTableViewCell"];
    
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    self.tableView.allowsMultipleSelection = YES;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 67, 0);
}

- (void)addMJRefresh{
    @weakify(self);
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [weak_self requestData];
    }];
    
    //    [self.tableview.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self requesMoreData];
    }];
}


- (void)requestData{
    _page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self.dataArry removeAllObjects];
    //请求
    sleep(1);[self.tableView.mj_header endRefreshing];
    
    //    https://app.mmtcapp.com/shopapi/shop/site?p=1&_f=3
    //    https://app.mmtcapp.com/shopapi/shop/site?p=1&_f=3
//    _page = 1;
//    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:@"3" host:@"shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
//        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
//        if (response_code == 0) {
//            [SVProgressHUD showErrorWithStatus:show_err];
//        }else{
//            _page ++;
//            NSArray *arr = [MMTCHomeModel mj_objectArrayWithKeyValuesArray:json[@"info"]];
//            if (arr.count < 1) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                //                [self.tableView endHeaderRefreshing];
//            }else
//            {
//                [self.homeArray addObjectsFromArray:arr];
//            }
//            NSLog(@"%ld",self.homeArray.count);
//            [self.tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
//        }
//    } error:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//    }];
}

- (void)requesMoreData{
    sleep(1);[self.tableView.mj_footer endRefreshing];
    //    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:@"3" host:@"shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
    //        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
    //        if (response_code == 0) {
    //            [SVProgressHUD showErrorWithStatus:show_err];
    //        }else{
    //
    //            NSArray *arr = [MMTCHomeModel mj_objectArrayWithKeyValuesArray:json[@"info"]];
    //
    //            if (arr.count < 1) {
    //                [self.tableView.mj_footer endRefreshingWithNoMoreData];
    //            }else
    //            {
    //                _page++;
    //                [self.homeArray addObjectsFromArray:arr];
    //                [self.tableView.mj_footer endRefreshing];
    //            }
    //            NSLog(@"%ld",self.homeArray.count);
    //            [self.tableView reloadData];
    //
    //        }
    //    } error:^(NSError *error) {
    //        [self.tableView endFooterRefreshing];
    //        [self.tableView endHeaderRefreshing];
    //    }];
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.homeArray.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MMTCHomeModel *model = self.homeArray[indexPath.row];
    MMTCProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCProductTableViewCell"];
//    [cell fillInto:model];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index = %ld",indexPath.row);
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return CellH;
    return 180.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(NSMutableArray *)homeArray
{
    if (!_homeArray) {
        _homeArray = [NSMutableArray array];
    }
    return _homeArray;
}

#pragma mark - - - 发布产品
- (IBAction)releaseClick:(id)sender {
}

@end
