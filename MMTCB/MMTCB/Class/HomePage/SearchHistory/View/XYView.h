//
//  XYView.h
//  浏览历史-Label的字数和宽度自动换行
//
//  Created by XY on 2017/11/1.
//  Copyright © 2017年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XYViewDelegate <NSObject>

//index 是点击那个label  tag是此封装XYView本身的tag
- (void)xyViewDidClickItemAtIndex:(NSInteger)index with:(NSInteger)tag;



@end


@interface XYView : UIView

-(instancetype)initWithFrame:(CGRect)frame with:(NSMutableArray *)LablesArray with:(NSInteger)tag ;

@property(nonatomic,assign)CGRect frames;
@property(nonatomic,strong)NSMutableArray * LablesArray;

-(void)removeData;
@property (nonatomic, weak) id<XYViewDelegate> delegate;
@property(nonatomic,assign)NSInteger tag;

@end
