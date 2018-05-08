//
//  UIControl+Additions.m
//  com
//
//  Created by lwq on 2016/11/30.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import "UIControl+Additions.h"

@implementation UIControl (Additions)

- (void)removeAllTargets {
    for (id target in [self allTargets]) {
        [self removeTarget:target action:NULL forControlEvents:UIControlEventAllEvents];
    }
}
@end
