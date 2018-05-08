//
//  MMTCProductManagerVC.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCProductManagerVC.h"
#import "FSScrollContentView.h"
#import "FSPageContentView.h"
#import "MMTCProductManagerTwoVC.h"

@interface MMTCProductManagerVC ()<UIScrollViewDelegate,FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView * pageContentView;
@property (nonatomic, strong) FSSegmentTitleView * titleView;

@end

@implementation MMTCProductManagerVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"产品管理";
    
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreemW, 40) titles:@[@"已上架(0)",@"已下架(0)",@"待审核(0)"] delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.tag = 66;
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:14];
    self.titleView.titleFont = [UIFont systemFontOfSize:13];
    self.titleView.titleSelectColor = [UIColor orangeColor];
    self.titleView.indicatorColor = [UIColor orangeColor];
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    [@[@"已上架(0)",@"已下架(0)",@"待审核(0)"] enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MMTCProductManagerTwoVC * vc = [[MMTCProductManagerTwoVC alloc]init];
        vc.titleView = self.titleView;
//        vc.titleStr = obj;
//        vc.num = idx;
        [childVCs addObject:vc];
    }];
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,  40, ScreemW, ScreemH  - 40) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:_pageContentView];

}

#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"222 %ld- %ld",(long)endIndex,(long)startIndex);
    self.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSLog(@"111 %ld- %ld",(long)endIndex,(long)startIndex);
    self.titleView.selectIndex = endIndex;
}


@end
