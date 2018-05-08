//
//  MMTCOrderTwoViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderTwoViewController.h"
#import "FSScrollContentView.h"
#import "FSPageContentView.h"
#import "MMTCOrderThreeViewController.h"
@interface MMTCOrderTwoViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView * pageContentView;
@property (nonatomic, strong) FSSegmentTitleView * titleView;

@end

@implementation MMTCOrderTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *array = [NSMutableArray array];
    switch (_num) {
        case 1:
            array = [NSMutableArray arrayWithArray:@[@"全部",@"待付款",@"待验证",@"待写日记",@"已退款"]];
            break;
        case 2:
             array = [NSMutableArray arrayWithArray:@[@"全部",@"拼团中",@"拼团成功",@"拼团失败"]];
            break;
        default:
            break;
    }
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    if (_num == 3) {
        MMTCOrderThreeViewController * vc = [[MMTCOrderThreeViewController alloc]init];
        vc.firstTitleView = self.titleView1;
        vc.twoTitleView = self.titleView;
        vc.firstNum = self.num;
        [childVCs addObject:vc];
        self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, ScreemW, ScreemH  - 40-naviBarH-tabBarH) childVCs:childVCs parentVC:self delegate:self];
        [self.view addSubview:_pageContentView];
    }else{
        self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreemW, 40) titles:array delegate:self indicatorType:FSIndicatorTypeEqualTitle];
        self.titleView.tag = 66;
        self.titleView.titleSelectFont = [UIFont systemFontOfSize:14];
        self.titleView.titleFont = [UIFont systemFontOfSize:13];
        self.titleView.titleSelectColor = [UIColor orangeColor];
        self.titleView.indicatorColor = [UIColor orangeColor];
        [self.view addSubview:_titleView];
        
        
        [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MMTCOrderThreeViewController * vc = [[MMTCOrderThreeViewController alloc]init];
            vc.firstTitleView = self.titleView1;
            vc.twoTitleView = self.titleView;
            vc.firstNum = self.num;
            vc.twoNum = idx+1;
            [childVCs addObject:vc];
        }];
        self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,  40, ScreemW, ScreemH  - 80-naviBarH-tabBarH) childVCs:childVCs parentVC:self delegate:self];
        [self.view addSubview:_pageContentView];
    }

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
