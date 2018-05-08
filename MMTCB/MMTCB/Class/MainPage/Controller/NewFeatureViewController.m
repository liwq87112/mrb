//
//  XMGNewFeatureViewController.m
//  小码哥彩票
//
//  Created by xiaomage on 15/8/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "NewFeatureCell.h"
#import "M_load.h"

@interface NewFeatureViewController ()
@property(nonatomic, strong)NSArray *imageItems;
@end

@implementation NewFeatureViewController


// 使用UICollectionView步骤
// 1.设置流水布局
// 2.UICollectionViewCell只能注册
// 3.必须自定义UICollectionViewCell
- (instancetype)init
{
    // 流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 设置每一行的间距
    layout.minimumLineSpacing = 0;

    // 设置每个cell的间距
    layout.minimumInteritemSpacing = 0;
    
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//    // 设置每组的内边距
//    layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    return [self initWithCollectionViewLayout:layout];
}

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求数据
    [self requestLoadImagesData];
    
    // 注意:  self.collectionView != self.view
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册cell
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:ID];
    
    // 取消弹簧效果
    self.collectionView.bounces = NO;
    
    // 取消显示指示器
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    // 开启分页模式
    self.collectionView.pagingEnabled = YES;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"新特性界面"];
     self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"新特性界面"];
     self.navigationController.navigationBarHidden = NO;
}
#pragma mark - 自定义方法
- (void)requestLoadImagesData{
//    [I_Load requestLoadImageWithParam:@{@"act":@"l_loading_image"} success:^(NSString *responseCode, NSArray *loadImageItems, NSString *updateTime) {
//        LQLog(@"%@",responseCode);
//        LQLog(@"%@",updateTime);
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%@%@",@"LaunchIntrudutionImage",@(i)];
        [imageArray addObject:imageName];
    }
    self.imageItems = imageArray;

    [self.collectionView reloadData];
//    } error:^(NSError *error) {
//    }];
}
#pragma mark - UICollectionView数据源
// 返回有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageItems.count + 1;
    
}

// 返回每个cell长什么样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   NewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    LoadImageItem *item = [self.imageItems safeObjectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.imageItems safeObjectAtIndex:indexPath.row]];
//    cell.imageUrlString = item.image_url;
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    LQLog(@"%f----%f",scrollView.contentOffset.x,scrollView.lq_width);
    if (scrollView.contentOffset.x >= scrollView.lq_width * (_imageItems.count - 1) + 20) {
//        [UIApplication sharedApplication].keyWindow.rootViewController = [[MainViewController alloc] init];
        [self.navigationController popViewControllerAnimated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.imageItems.count - 1) {
//        MainViewController *main = [[MainViewController alloc] init];
//        [UIApplication sharedApplication].keyWindow.rootViewController = main;
        [self.navigationController popViewControllerAnimated:NO];
    }
}


@end
