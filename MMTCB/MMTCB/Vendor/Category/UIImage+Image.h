//
//  UIImage+Image.h
//  
//
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;


//生成渐变图片
+ (UIImage*) gradientImageFromColors:(NSArray*)colors ByGradientType:(NSInteger)gradientType inSize:(CGSize)size;


//base64支付串转图片
+ (UIImage*)imageFromBase64Str:(NSString*)imgStr;

//图片转base64
+ (NSString*)strFromImage:(UIImage*)originImage;

@end
