//
//  DLCBaseTableViewController.m
//  NewtonFitness
//
//  Created by huabing jiang on 2017/7/10.
//  Copyright © 2017年 DLC. All rights reserved.
//

#import "DLCBaseTableViewController.h"

@interface DLCBaseTableViewController ()

@end

@implementation DLCBaseTableViewController

@synthesize items = _items;
@synthesize tableView = _tableView;

// 更换TableViewStyle 想用 UITableViewStyleGrouped 在继承视图中重写此方法
-(UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

//默认风格 有header和footer有悬浮效果
- (UITableView *)tableView
{
    if (!_tableView) {
        CGFloat defa_x = 0.0f , defa_y = 64.0f , defa_w = ScreemW , defa_h = ScreemH -defa_y;
        CGRect rect = CGRectMake(defa_x, defa_y, defa_w, defa_h);
        _tableView = [[UITableView alloc] initWithFrame:rect style:[self tableViewStyle]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithHexString:viewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Setter & Getter
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

#pragma mark - UITableViewDelegate & DataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *baseCellIdentifier = @"baseCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:baseCellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:baseCellIdentifier];
    }
    return cell;
}

#pragma mark - Custom Method
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.tableView.contentInset = UIEdgeInsetsZero;
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
}

//创建下拉刷新试图
- (void)createRefreshHeaderView
{
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self headerRefreshData];
        [self.tableView.mj_header endRefreshing];
    }];
    _headerView = self.tableView.mj_header;
}

- (void)createRefreshHeaderViewWithBlock:(void (^)(void))completion
{
    self.tableView.mj_header = [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        [self headerRefreshData];
        [self.tableView.mj_header endRefreshing];
        completion();
    }];
    _headerView = self.tableView.mj_header;
}

- (void)createRefreshHeaderViewWithTarget:(id)target refreshingAction:(SEL)action
{
    if (target == nil || action == nil) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(headerRefreshData)];
    }
    else
    {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target
                                                                    refreshingAction:action];
    }
    [self.tableView.mj_header beginRefreshing];
    _headerView = self.tableView.mj_header;
}

//创建上拉加载试图
- (void)createRefreshFooterView
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self footerRefreshData];
        [self.tableView.mj_footer endRefreshing];
    }];
    _footerView = self.tableView.mj_footer;
}

- (void)createRefreshFooterViewWithBlock:(void (^)(void))completion
{
    self.tableView.mj_footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self footerRefreshData];
        [self.tableView.mj_footer endRefreshing];
        completion();
        
    }];
    _footerView = self.tableView.mj_footer;
}

- (void)createRefreshFooterViewWithTarget:(id)target refreshingAction:(SEL)action
{
    if (target == nil || action == nil) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
                                                                        refreshingAction:@selector(footerRefreshData)];
    }
    else
    {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target
                                                                        refreshingAction:action];
    }
    [self.tableView.mj_footer endRefreshing];
    _footerView = self.tableView.mj_footer;
}

#pragma -
#pragma - RefreshData
- (void)headerRefreshData
{
    NSLog(@"下拉刷新");
}

- (void)footerRefreshData
{
    NSLog(@"上拉加载");
}

/*
 *以下三个方法暂放，如果以后用到在自行加上
 */
- (void)loadMoreData
{
    [self headerRefreshData];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadLastData
{
    [self headerRefreshData];
    [self.tableView.mj_footer setHidden:YES];
}
- (void)reset
{
    [self headerRefreshData];
    [self.tableView.mj_footer resetNoMoreData];
}

@end
