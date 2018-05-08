//
//  UIScrollView+LQRefresh.m
//  xskj
//
//  Copyright © 2016年 lq. All rights reserved.
//

#import "UIScrollView+LQRefresh.h"

@implementation UIScrollView (LQRefresh)

/**
 *  添加下拉刷新
 *
 *  @param block 回调
 */
- (void)addHeaderWithRefreshingBlock:(void(^)())block
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
}
- (void)addHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    self.mj_header = header;
}

- (void)addStyleWhiteHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    header.arrowView.image = [UIImage imageNamed:@"下箭头"];
    self.mj_header = header;
}



/**
 *  开始下拉刷新
 */
-(void)beginHeaderRefreshing
{
    [self.mj_header beginRefreshing];
}

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefreshing
{
    [self.mj_header endRefreshing];
}


/**
 *  添加上拉刷新
 *
 *  @param block 回调
 */
- (void)addFooterWithRefreshingBlock:(void(^)())block
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}
- (void)addFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    footer.automaticallyHidden = YES;
    self.mj_footer = footer;
}

/**
 *  结束上拉刷新
 */
- (void)endFooterRefreshing
{
    [self.mj_footer endRefreshing];
}

/**
 *  没有更多数据
 */
- (void)endRefreshingWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}
@end
