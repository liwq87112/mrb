//
//  DLCBaseTableViewController.h
//  NewtonFitness
//
//  Created by huabing jiang on 2017/7/10.
//  Copyright © 2017年 DLC. All rights reserved.
//

#import "BasicViewController.h"
#import "MJRefresh.h"

@interface DLCBaseTableViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView     *tableView;
@property (nonatomic,strong,readonly)NSMutableArray  *items;

@property (nonatomic,strong,readonly) MJRefreshFooter * footerView;
@property (nonatomic,strong,readonly) MJRefreshHeader * headerView;
@property (assign, nonatomic) BOOL isFootRefresh; //是否是上拉加载


/*
 * 更换TableViewStyle 想用 UITableViewStyleGrouped 在继承视图中重写此方法
 */
- (UITableViewStyle)tableViewStyle;

/*
 * 创建下拉刷新视图
 */
- (void)createRefreshHeaderView;
- (void)createRefreshHeaderViewWithBlock:(void (^)(void))completion;
- (void)createRefreshHeaderViewWithTarget:(id)target refreshingAction:(SEL)action;

/*
 * 创建上拉刷新视图
 */
- (void)createRefreshFooterView;
- (void)createRefreshFooterViewWithBlock:(void (^)(void))completion;
- (void)createRefreshFooterViewWithTarget:(id)target refreshingAction:(SEL)action;

/*
 * 刷新下拉 方法 默认为refreshData
 */
- (void)headerRefreshData;

/*
 * 刷新上拉 方法 默认为refreshData
 */
- (void)footerRefreshData;

/*
 *以下三个方法暂放，以下三个方法暂放，如果以后用到在自行加上
 */
#pragma -
#pragma - Mark
/*
 * 上拉刷新 加载最后一份数据,footView变为已经全部加载完毕
 */
- (void)loadMoreData;

/*
 * 上拉刷新 加载完成所有数据,隐藏footView
 */
- (void)loadLastData;

/*
 * 上拉刷新 加载最后一份数据,footView不可点击 reset之后可重新点击刷新数据
 */
- (void)reset;

@end
