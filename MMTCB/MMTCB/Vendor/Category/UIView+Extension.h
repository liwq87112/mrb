//
//  UIView+Extension.h
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/* 为避免与第三方框架（如：Masonry框架）属性同名，属性名称都加上前缀k */

@property (nonatomic, assign) CGSize kSize;

@property (nonatomic, assign) CGPoint kOrigin;

@property (nonatomic, assign) CGFloat kWidth;

@property (nonatomic, assign) CGFloat kHeight;

@property (nonatomic, assign) CGFloat kMaxX;

@property (nonatomic, assign) CGFloat kMaxY;

@property (nonatomic, assign) CGFloat kMidX;

@property (nonatomic, assign) CGFloat kMidY;

@property (nonatomic, assign) CGFloat kCenterY;

@property (nonatomic, assign) CGFloat kCenterX;

@end
