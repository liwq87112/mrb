//
//  MMTCOrderViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCOrderViewController.h"
#import "FSScrollContentView.h"
#import "FSPageContentView.h"
#import "MMTCOrderTwoViewController.h"

@interface MMTCOrderViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>

@property (nonatomic, strong) FSPageContentView * pageContentView;
@property (nonatomic, strong) FSSegmentTitleView * titleView;

@end

@implementation MMTCOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //导航栏颜色
    [self mainColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //导航栏颜色
    [self mainColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //导航栏颜色
    [self whiteColor];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //导航栏颜色
    [self whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单管理";
    NSArray *firstArr = @[@"项目订单",@"拼团订单",@"买单订单"];
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 0, ScreemW, 40) titles:firstArr delegate:self indicatorType:FSIndicatorTypeEqualTitle];
    self.titleView.firstBool = YES;
    self.titleView.tag = 66;
    self.titleView.titleSelectFont = [UIFont systemFontOfSize:14];
    self.titleView.titleFont = [UIFont systemFontOfSize:13];
    self.titleView.titleSelectColor = [UIColor orangeColor];
    self.titleView.titleNormalColor = [UIColor whiteColor];
    self.titleView.indicatorColor = [UIColor whiteColor];
    self.titleView.backgroundColor = [UIColor colorWithHexString:MMTCNavColor];
     UIButton *btn = [self.titleView viewWithTag:666];
     UIButton *btn1 = [self.titleView viewWithTag:666+1];
     UIButton *btn2 = [self.titleView viewWithTag:666+2];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"right"] forState:UIControlStateSelected];
    [btn setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
    [btn1 setBackgroundImage:[UIImage imageNamed:@"center"] forState:UIControlStateSelected];
    [btn1 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    
    [btn2 setBackgroundImage:[UIImage imageNamed:@"life"] forState:UIControlStateSelected];
    [btn2 setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];

    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    [firstArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MMTCOrderTwoViewController * vc = [[MMTCOrderTwoViewController alloc]init];
        vc.titleView1 = self.titleView;
        vc.num = idx+1;
        [childVCs addObject:vc];
    }];
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0,  40, ScreemW, ScreemH  - 40-naviBarH -tabBarH) childVCs:childVCs parentVC:self delegate:self];
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


- (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
}

@end
