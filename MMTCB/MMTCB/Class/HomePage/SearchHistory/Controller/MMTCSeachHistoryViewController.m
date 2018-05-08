//
//  MMTCSeachHistoryViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCSeachHistoryViewController.h"
#import "MMTCSearchHistoryHeaderView.h"
#import "XYView.h"
//#import <Realm.h>
#import <Realm/Realm.h>
#import "MMTCSearchHistoryModel.h"
#import "MMTCSearchResultViewController.h"
#import "MSSAutoresizeLabelFlow.h"


@interface MMTCSeachHistoryViewController ()<XYViewDelegate>

@property (strong, nonatomic)  UIScrollView *historyScrollView;
@property (strong, nonatomic)  MMTCSearchHistoryHeaderView *searchHistoryHeaderView;
//@property (nonatomic,strong) XYView *   ;

@property (nonatomic,strong) MSSAutoresizeLabelFlow *labelView;
@end

@implementation MMTCSeachHistoryViewController

#pragma mark - - - - lifeCycle - - - -
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    //从数据库获取已经保存的 Model
    [self getResultsFromRelam];
    
    if (self.searchHistoryHeaderView.kWidth < ScreemW) {
        self.searchHistoryHeaderView.frame = CGRectMake(0, 0, ScreemW, seachH);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"搜索订单";
    
    @weakify(self);
    [self.searchHistoryHeaderView setRetureBlock:^(NSString *text ) {
        NSLog(@"go");
        //加到数据库 并且去跳到搜索结果界面 搜索
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults *results = [MMTCSearchHistoryModel allObjectsInRealm:realm];

        MMTCSearchResultViewController * vc = [[MMTCSearchResultViewController alloc] init];
        vc.searchResult =text;//根据这个 去搜索

        [weak_self.navigationController pushViewController:vc animated:YES];

        //相同的不存储
        for (MMTCSearchHistoryModel * model in results) {

            NSLog(@" 需要存储的数据-------:%@",model.historyStr);
            if ([model.historyStr isEqualToString: text]) {
                return ;
            }
        }
        MMTCSearchHistoryModel * model = [[MMTCSearchHistoryModel alloc] init];
        model.historyStr = text;

        //存储 单个数据
        [realm beginWriteTransaction];
        [realm addObject:model];
        [realm commitWriteTransaction];
        
    }];
 
    [self.searchHistoryHeaderView setDeleteBlock:^{
        NSLog(@"chuqu");
        [weak_self showAlertView];
    }];
}

-(void)getResultsFromRelam{
    
    //历史记录  从数据库 获取
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [MMTCSearchHistoryModel allObjectsInRealm:realm];

    NSMutableArray * hisetoryArr =  [NSMutableArray array];

    for (MMTCSearchHistoryModel * model in results) {

        NSLog(@"获取查寻的数据-------:%@",model.historyStr);
        [hisetoryArr addObject:model.historyStr];
    }
    
    if (hisetoryArr.count > 0) {
        NSLog(@"gp");
    }else{
        NSLog(@"bu go");
    }
    
    _labelView = [[MSSAutoresizeLabelFlow alloc]initWithFrame:CGRectMake(0, 0, self.historyScrollView.kWidth, self.historyScrollView.kHeight) titles:hisetoryArr selectedHandler:^(NSUInteger index, NSString *title) {
        NSLog(@"%@",title);
        RLMRealm *realm = [RLMRealm defaultRealm];
        RLMResults *results = [MMTCSearchHistoryModel allObjectsInRealm:realm];
        
        MMTCSearchHistoryModel* model = results[index];
        
        MMTCSearchResultViewController * vc = [[MMTCSearchResultViewController alloc] init];
        vc.searchResult =model.historyStr;//根据这个 去搜索
        //
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    if (![self.view.subviews containsObject:self.historyScrollView]) {
        [self.view addSubview:self.historyScrollView];
    }

    if (![self.historyScrollView.subviews containsObject:_labelView]) {
        NSLog(@"go");
         [self.historyScrollView addSubview:_labelView];
    }

    //设置滚动范围
    self.historyScrollView.contentSize = CGSizeMake(0,  _labelView.kHeight + 80);
}

#pragma mark ----- XYViewDelegate -----
-(void)xyViewDidClickItemAtIndex:(NSInteger)index with:(NSInteger)tag{
    
    NSLog(@"------点击的Label:%zd ++++++目前的控件:%zd",index,tag);
    
    //历史记录  从数据库 获取
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults *results = [MMTCSearchHistoryModel allObjectsInRealm:realm];
    
    MMTCSearchHistoryModel* model = results[index];
  
    MMTCSearchResultViewController * vc = [[MMTCSearchResultViewController alloc] init];
    vc.searchResult =model.historyStr;//根据这个 去搜索
//
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark ------------------- 删除 ------------------
-(void)showAlertView{
    
    UIAlertController * al = [UIAlertController alertControllerWithTitle:@"温习提示" message:@"是否清楚搜索记录" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
     @weakify(self);
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //还要 删除数据库
        [weak_self.labelView removeFromSuperview];
        [weak_self.historyScrollView removeFromSuperview];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteAllObjects];
        [realm commitWriteTransaction];
    }];
    [al addAction:cancel];
    [al addAction:action];
    [self presentViewController:al animated:YES completion:nil];

}



#pragma mark  ---------  搜索结果  -----------
-(UIScrollView *)historyScrollView{
    
    if (_historyScrollView == nil) {
        _historyScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.searchHistoryHeaderView.kHeight , ScreemW, ScreemH - self.searchHistoryHeaderView.kHeight )];
//        _historyScrollView.backgroundColor =[UIColor groupTableViewBackgroundColor];
        _historyScrollView.bounces = YES;
        _historyScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0,0);
        _historyScrollView.scrollEnabled = YES;
        _historyScrollView.userInteractionEnabled = YES;
        
        [self.view addSubview:_historyScrollView];
    }
    
    return _historyScrollView;
}

- (MMTCSearchHistoryHeaderView *)searchHistoryHeaderView
{
    if (!_searchHistoryHeaderView) {
        _searchHistoryHeaderView = [MMTCSearchHistoryHeaderView createMMTCSearchHistoryHeaderView];
        _searchHistoryHeaderView.frame = CGRectMake(0, 0, ScreemW, seachH);
        [self.view addSubview:self.searchHistoryHeaderView];
    }
    return _searchHistoryHeaderView;
}

@end
