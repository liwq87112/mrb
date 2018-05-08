//
//  XYView.m
//  浏览历史-Label的字数和宽度自动换行
//
//  Created by XY on 2017/11/1.
//  Copyright © 2017年 XY. All rights reserved.
//
/**
 * 屏幕的宽、高
 */
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)

#define Lable_H  30

#import "XYView.h"

@implementation XYView

-(instancetype)initWithFrame:(CGRect)frame with:(NSMutableArray *)LablesArray  with:(NSInteger)tag {
    
    if(self = [super initWithFrame:frame]){
       
        self.tag = tag;
        self.frames = frame;
        self.LablesArray = LablesArray;
        [self setUpUI];
        
    }
    
    return self;
}


-(void)removeData{
    self.LablesArray = nil;
    [self removeFromSuperview];
}

-(void)setUpUI{
    
    for (int i = 0 ; i< self.LablesArray.count; ++i) {
        
        UILabel * label = [[UILabel alloc] init];
        [self addSubview:label];
        label.tag= i;
        NSString * title_str =  self.LablesArray[i];
        label.text = title_str;
        label.userInteractionEnabled = YES;
        
        
        
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = Lable_H /2.0;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.borderWidth = 1.0;
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor lightGrayColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        
        
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
        
    }
    
}

#pragma mark ------------------- 点击事件 -------------------
-(void)tapClick:(UITapGestureRecognizer *)tap{
    UILabel * label =(UILabel *) tap.view;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xyViewDidClickItemAtIndex:with:)]) {
        
        [self.delegate xyViewDidClickItemAtIndex:label.tag with:self.tag];
    }
    
    
}


//计算 lable的宽度
- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{ NSFontAttributeName:[UIFont systemFontOfSize:15] };  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, Lable_H)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
   
    return rect.size.width;
}

-(void)layoutSubviews{
    [super layoutSubviews];
   

    CGFloat horizSpace = 8;//按钮之间的间距
    CGFloat startX = horizSpace;// 按钮的 x
    CGFloat startY = 10;

    for (UILabel * label  in self.subviews) {
        
        CGFloat btnW = [self calculateRowWidth:label.text]+20;
        if (startX + btnW > SCREEN_W - horizSpace) {
            startX = 8;
            startY += Lable_H + 10;
        }
        label.frame = CGRectMake(startX, startY, btnW, Lable_H);
        startX += (btnW + horizSpace);

    }
    if(self.subviews.count == 0){
        
         self.frame = CGRectMake(self.frames.origin.x, self.frames.origin.y, SCREEN_W, 0);
         self.frames = CGRectMake(self.frames.origin.x, self.frames.origin.y, SCREEN_W, 0);
        
    }else{
        
         self.frame = CGRectMake(self.frames.origin.x, self.frames.origin.y, SCREEN_W, startY +Lable_H + 10);
         self.frames = CGRectMake(self.frames.origin.x, self.frames.origin.y, SCREEN_W, startY +Lable_H + 10);
    }

   
}

@end
