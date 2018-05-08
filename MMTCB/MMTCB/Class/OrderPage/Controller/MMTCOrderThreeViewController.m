//
//  MMTCOrderThreeViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderThreeViewController.h"
#import "MMTCOrderTableViewCell.h"
#import "MMTCOrderIdTableViewCell.h"
#import "MMTCOrderMoneyCell.h"
#import "MMTCGroupOrTableViewCell.h"
#import "MMTCBugOrTableViewCell.h"

#import "MMTCOrderHeadView.h"
#import "MMTCOrderModel.h"

#import "MMTCDetailsViewController.h"
#import "MMTCDetailsOrderViewController.h"
#import "MMTCDetailsGroupViewController.h"

@interface MMTCOrderThreeViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic,strong) MMTCOrderHeadView   *HeadView;
@property(nonatomic,assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@end

@implementation MMTCOrderThreeViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCOrderTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCOrderIdTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCOrderIdTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCOrderMoneyCell" bundle:nil] forCellReuseIdentifier:@"MMTCOrderMoneyCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCGroupOrTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCGroupOrTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MMTCBugOrTableViewCell" bundle:nil] forCellReuseIdentifier:@"MMTCBugOrTableViewCell"];
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
    self.tableView.estimatedRowHeight =0;
    self.tableView.estimatedSectionHeaderHeight =0;
    self.tableView.estimatedSectionFooterHeight =0;
    
    @weakify(self);
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weak_self requestDataType:weak_self.twoNum];
    }];
    [self.tableView beginHeaderRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weak_self requesMoreData];
    }];
}


- (void)requestDataType:(NSInteger )num{
    _page = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [self.sectionArray removeAllObjects];
    [self.dataArray removeAllObjects];

    NSString *host;//接口
    NSNumber *number;//第几个
    switch (self.firstNum) {
        case 1:
            host = itemOrderList;
            number = [NSNumber numberWithInteger:self.twoNum - 1];
            break;
        case 2:
            host = groupOrderList;
            number = [NSNumber numberWithInteger:self.twoNum - 1];
            break;
        case 3:
            host = buyOrderList;
            number = [NSNumber numberWithInteger:0];
            break;
        default:
            break;
    }
    
    @weakify(self);
    [MMTCOrderModel OrderListType:number Page:[NSNumber numberWithUnsignedInteger:_page] Kw:nil  host:host Success:^(NSInteger response_code, NSString *show_err, id data) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,data);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            weak_self.page ++;
            if (weak_self.firstNum == 1) {
                NSArray *arr = [MMTCOrderModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.sectionArray addObjectsFromArray:arr];
                }
            }
            if (weak_self.firstNum == 2) {
                 NSArray *arr = [MMTCGroupOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.dataArray addObjectsFromArray:arr];
                }
            }
            if (weak_self.firstNum == 3) {
                NSArray *arr = [MMTCBuyOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    [self.dataArray addObjectsFromArray:arr];
                }
            }
            NSLog(@"%ld - %ld",self.sectionArray.count,self.dataArray.count);
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } error:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];

}

- (void)requesMoreData{
    NSString *host;//接口
    NSNumber *number;//第几个
    switch (self.firstNum) {
        case 1:
            host = itemOrderList;
            number = [NSNumber numberWithInteger:self.twoNum - 1];
            break;
        case 2:
            host = groupOrderList;
            number = [NSNumber numberWithInteger:self.twoNum - 1];
            break;
        case 3:
            host = buyOrderList;
            number = [NSNumber numberWithInteger:0];
            break;
        default:
            break;
    }
    
    @weakify(self);
    [MMTCOrderModel OrderListType:number Page:[NSNumber numberWithUnsignedInteger:_page] Kw:nil  host:host Success:^(NSInteger response_code, NSString *show_err, id data) {
        if (response_code == 0) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            if (weak_self.firstNum == 1) {
                NSArray *arr = [MMTCOrderModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    weak_self.page++;
                    [self.sectionArray addObjectsFromArray:arr];
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            if (weak_self.firstNum == 2) {
                NSArray *arr = [MMTCGroupOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    weak_self.page++;
                    [self.dataArray addObjectsFromArray:arr];
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            if (weak_self.firstNum == 3) {
                NSArray *arr = [MMTCBuyOrderListModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
                if (arr.count < 1) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else
                {
                    weak_self.page++;
                    [self.dataArray addObjectsFromArray:arr];
                    [self.tableView.mj_footer endRefreshing];
                }
            }            
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        [self.tableView endFooterRefreshing];
        [self.tableView endHeaderRefreshing];
    }];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.firstNum == 1) {
         return self.sectionArray.count;
    }
    else{
        return 1;
    }
}

- (NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.firstNum == 1) {
        MMTCOrderModel *model = self.sectionArray[section];
        return model.items.count+2;
    }
    else{
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.firstNum == 1) {
        MMTCOrderModel *model = self.sectionArray[indexPath.section];
        if (indexPath.row == 0) {
            MMTCOrderIdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCOrderIdTableViewCell"];
            [cell fillIntoModel:model];
            return cell ;
        }else
            if (indexPath.row == model.items.count + 1) {
                MMTCOrderMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCOrderMoneyCell"];
                [cell fillIntoModel:model];
                return cell;
            }
            else{
                NSArray *arr = [MMTCOrderImageModel mj_objectArrayWithKeyValuesArray:model.items];
                MMTCOrderImageModel *imageModel = arr[indexPath.row-1];
                MMTCOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCOrderTableViewCell"];
                [cell fillIntoModel:imageModel];
                return cell;
            }
    }else if (self.firstNum == 2) {
        MMTCGroupOrderListModel *model = self.dataArray[indexPath.row];
        MMTCGroupOrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCGroupOrTableViewCell"];
        [cell fillIntoModel:model];
        return cell ;
    }
    else{
        MMTCBuyOrderListModel *model = self.dataArray[indexPath.row];
        MMTCBugOrTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMTCBugOrTableViewCell"];
        [cell fillIntoModel:model];
        return cell ;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        self.HeadView = [[[NSBundle mainBundle] loadNibNamed:@"MMTCOrderHeadView" owner:nil options:nil] firstObject];
        self.HeadView.navigationController = self.navigationController;
        return self.HeadView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"index = %ld",indexPath.row);
   
    switch (self.firstNum) {
        case 1:{
            MMTCOrderModel *model = self.sectionArray[indexPath.section];
            MMTCDetailsOrderViewController *vc = [[MMTCDetailsOrderViewController alloc]init];
            vc.detailsId = model.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            MMTCGroupOrderListModel *model = self.dataArray[indexPath.row];
            MMTCDetailsGroupViewController *vc = [[MMTCDetailsGroupViewController alloc]init];
            vc.detailsId = model.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            MMTCBuyOrderListModel *model = self.dataArray[indexPath.row];
            MMTCDetailsViewController *vc = [[MMTCDetailsViewController alloc]init];
            vc.detailsId = model.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.firstNum == 1) {
        MMTCOrderModel *model = self.sectionArray[indexPath.section];
        if (indexPath.row == 0) {
            return 44;
        }else
            if (indexPath.row == model.items.count + 1) {
                return 54;
            }
        return MMTCOrderTableViewCellH;
    }else if(self.firstNum == 2){
        return GroupCellH;
    }else{
        return BuyCellH;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return OrderHeadH;
    }
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
- (NSMutableArray *)sectionArray
{
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}


#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"emptyorders"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"没有找到记录";
    
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
