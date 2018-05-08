//
//  UIColor+Hex.h
//  xskj
//
//  Created by 黎芹 on 16/4/26.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
// 默认alpha位1
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+(BOOL)compareRGBAColor1:(UIColor *)color1 withColor2:(UIColor *)color2;
@end
