//
//  UIImage+Render.m

//
//  Created by Lqq on 16/1/20.
//  Copyright © 2016年 Lqq. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)
+ (UIImage *)imageNamedWithOriginalImage:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
