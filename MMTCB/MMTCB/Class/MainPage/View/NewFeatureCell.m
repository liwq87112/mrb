//
//  XMGNewFeatureCell.m
//  小码哥彩票
//
//  Created by xiaomage on 15/8/26.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "NewFeatureCell.h"

@interface NewFeatureCell ()



@end

@implementation NewFeatureCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = imageV;
        
        [self.contentView addSubview:imageV];
    }
    
    return _imageView;
}
- (void)setImageUrlString:(NSString *)imageUrlString{
    _imageUrlString = imageUrlString;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:nil];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
}

@end
