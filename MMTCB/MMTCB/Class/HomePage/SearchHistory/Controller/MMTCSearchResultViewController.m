//
//  MMTCSearchResultViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCSearchResultViewController.h"
#import "MMTCDetailsGroupViewController.h"
#import "MMTCSearchResultView.h"
#import "MMTCDetailsOrderViewController.h"
#import "MMTCHomeTableViewCell.h"

@interface MMTCSearchResultViewController()
<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)  MMTCSearchResultView *searchResultView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic,assign) NSInteger page;

@end

@implementation MMTCSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"搜索结果";

    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCHomeTableViewCell"];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf questData];
    }];
     self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(MoreData)];
    
    [self questData];
}

- (void)questData
{
    _page = 1;
    @weakify(self);
    [self.tableView.mj_footer resetNoMoreData];
    [self.dataArray removeAllObjects];
    
    NSString *result = [_searchResult stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:result host:@"/shopapi/shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
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
        NSString *result = [_searchResult stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [MMTCHomeModel HomeListP:[NSNumber numberWithInteger:_page] kw:result host:@"/shop/site?" Success:^(NSInteger response_code, NSString *show_err, id json) {
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
    MMTCHomeModel *model = self.dataArray[indexPath.row];
    MMTCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCHomeTableViewCell"];
    [cell fillInto:model];
    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
      self.searchResultView = [MMTCSearchResultView createMMTCSearchHistoryHeaderView];
     self.searchResultView.resultTextField.text = _searchResult;
    return self.searchResultView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index = %ld",indexPath.row);
    
    MMTCHomeModel *model = self.dataArray[indexPath.row];
    
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
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptyorders"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"没有找到相关的订单~";
    
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
    [self.tableView reloadData];
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView {
    self.tableView.contentOffset = CGPointZero;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
