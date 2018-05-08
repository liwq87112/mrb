//
//  MMTCHomeViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCHomeViewController.h"
#import "LoginViewController.h"
#import "MMTCHomeTableViewCell.h"
#import "MMTCHomeHeadView.h"
#import "MMTCHomeModel.h"
#import "MMTCDetailsOrderViewController.h"
#import "MMTCDetailsGroupViewController.h"

@interface MMTCHomeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic,strong) MMTCHomeHeadView   *bannnerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *homeArray;

@end

@implementation MMTCHomeViewController

#pragma mark - - - - lifeCycle - - - -

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self mainColor];
    [self requestData];
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
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }

    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCHomeTableViewCell"];

    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
     self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MoreData)];
    
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    UIView *refreshBG = [[UIView alloc]initWithFrame:CGRectMake(0, -ScreemH, ScreemW, ScreemH)];
    refreshBG.backgroundColor = [UIColor colorWithHexString:MMTCNavColor];
    [self.tableView addSubview:refreshBG];
    [self.tableView sendSubviewToBack:refreshBG];
    
}


- (void)MoreData{
    @weakify(self);
    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:nil host:@"/shopapi/shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            
            NSArray *arr = [MMTCHomeModel mj_objectArrayWithKeyValuesArray:json];
            
            if (arr.count < 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                weak_self.page++;
                [self.homeArray addObjectsFromArray:arr];
                [self.tableView.mj_footer endRefreshing];
            }
            NSLog(@"%ld",self.homeArray.count);
            [self.tableView reloadData];
           
        }
    } error:^(NSError *error) {
        [self.tableView endFooterRefreshing];
        [self.tableView endHeaderRefreshing];
    }];
}

- (void)requestData{
    
    _page = 1;
     @weakify(self);
    [self.tableView.mj_footer resetNoMoreData];
    [self.homeArray removeAllObjects];
    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:nil host:@"/shopapi/shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else if(response_code == 202)
        {
            //去登录
        }
        else{
            weak_self.page ++;
            NSArray *arr = [MMTCHomeModel mj_objectArrayWithKeyValuesArray:json];
            if (arr.count < 1) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.homeArray addObjectsFromArray:arr];
            }
            NSLog(@"%ld",self.homeArray.count);
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } error:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
    }];
}


#pragma - mark - 上拉加载 下拉刷新
//- (void)headerRefreshData
//{
//    if(![NetApiManager getNetStaus]) {//无网提示
////        [self.view showLoadingMeg:NETE_ERROR_MESSAGE time:MESSAGE_SHOW_TIME];
//        return;
//    }
//    _page = 1;
//    self.isFootRefresh = NO;
//    [self.dataArry removeAllObjects];
//    [self hotMessageListWithType:self.type withSearch:self.search];
//}



- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MMTCHomeModel *model = self.homeArray[indexPath.row];
    MMTCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCHomeTableViewCell"];
    [cell fillInto:model];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    self.bannnerView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCHomeHeadView" owner:nil options:nil] firstObject];
    self.bannnerView.navigationController = self.navigationController;
    return self.bannnerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index = %ld",indexPath.row);

    MMTCHomeModel *model = self.homeArray[indexPath.row];
    
    if ([model.group_open_id stringValue].length > 1) {
        MMTCDetailsGroupViewController *vc = [[MMTCDetailsGroupViewController alloc]init];
        vc.detailsId = [model.group_open_id stringValue];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MMTCDetailsOrderViewController *vc = [[MMTCDetailsOrderViewController alloc]init];
        vc.detailsId = model.bill_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellH;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return BannerViewH;
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

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptyorders"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"您还没有验证记录哦，祝开张大吉～";
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
//    // 设置所有字体大小为 #15
//    [attStr addAttribute:NSFontAttributeName
//                   value:[UIFont systemFontOfSize:15.0]
//                   range:NSMakeRange(0, text.length)];
//    // 设置所有字体颜色为浅灰色
//    [attStr addAttribute:NSForegroundColorAttributeName
//                   value:[UIColor lightGrayColor]
//                   range:NSMakeRange(0, text.length)];
//    // 设置指定4个字体为蓝色
//    [attStr addAttribute:NSForegroundColorAttributeName
//                   value:HexColor(@"#007EE5")
//                   range:NSMakeRange(7, 4)];
    return attStr;
}

//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
//    return -70.0f;
//}

#pragma mark - DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    // button clicked...
    NSLog(@"go");
//    [self.tableView reloadData];
    [self.tableView beginHeaderRefreshing];
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tableView.contentOffset = CGPointZero;
}

@end
