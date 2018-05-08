//
//  UIView+Extension.m
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

/* 尺寸大小 */
- (CGSize)kSize
{
    return self.frame.size;
}

- (void)setKSize:(CGSize)kSize
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    self.frame = CGRectMake(x, y, kSize.width, kSize.height);
}

/* 位置 */
- (CGPoint)kOrigin
{
    return self.frame.origin;
}

- (void)setKOrigin:(CGPoint)kOrigin
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.frame = CGRectMake(kOrigin.x, kOrigin.y, w, h);
}

/* 宽度 */
- (CGFloat)kWidth
{
    return self.frame.size.width;
}

- (void)setKWidth:(CGFloat)kWidth
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat h = self.frame.size.height;
    self.frame = CGRectMake(x, y, kWidth, h);
}

/* 高度 */
- (CGFloat)kHeight
{
    return self.frame.size.height;
}

- (void)setKHeight:(CGFloat)kHeight
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width;
    self.frame = CGRectMake(x, y, w, kHeight);
}

/* 最小x坐标 */
- (CGFloat)kMidX
{
    return self.frame.origin.x;
}

- (void)setKMidX:(CGFloat)kMidX
{
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.frame = CGRectMake(kMidX, y, w, h);
}

/* 最小y坐标 */
- (CGFloat)kMidY
{
    return self.frame.origin.y;
}

- (void)setKMidY:(CGFloat)kMidY
{
    CGFloat x = self.frame.origin.x;
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.frame = CGRectMake(x, kMidY, w, h);
}

/* 最大x坐标 */
- (CGFloat)kMaxX
{
    return (self.frame.origin.x + self.frame.size.width);
}

- (void)setKMaxX:(CGFloat)kMaxX
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat w = kMaxX - x;
    CGFloat h = self.frame.size.height;
    self.frame = CGRectMake(x, y, w, h);
}

/* 最大y坐标 */
- (CGFloat)kMaxY
{
    return (self.frame.origin.y + self.frame.size.height);
}

- (void)setKMaxY:(CGFloat)kMaxY
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat w = self.frame.size.width;
    CGFloat h = kMaxY - y;
    self.frame = CGRectMake(x, y, w, h);
}

/* 中心Y坐标 */
- (CGFloat)kCenterY
{
    return (self.frame.origin.y + self.frame.size.height/2);
}

- (void)setKCenterY:(CGFloat)kCenterY
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat x = self.frame.origin.x;
    CGFloat y = kCenterY - h/2;
    self.frame = CGRectMake(x, y, w, h);
}

/* 中心X坐标 */
- (CGFloat)kCenterX
{
    return (self.frame.origin.x + self.frame.size.width/2);
}

- (void)setKCenterX:(CGFloat)kCenterX
{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    CGFloat x = kCenterX - w/2;
    CGFloat y = self.frame.origin.y;
    self.frame = CGRectMake(x, y, w, h);
}


@end
