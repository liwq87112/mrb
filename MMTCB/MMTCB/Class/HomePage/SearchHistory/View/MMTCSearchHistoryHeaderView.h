//
//  MMTCSearchHistoryHeaderView.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#define seachH 80.0f
@class MMTCSearchHistoryHeaderView;

@protocol MMTCSearchHistoryHeaderViewDelegate <NSObject>

- (void)MMTCSearchHistoryHeaderViewButton:(NSInteger)index;

@end

@interface MMTCSearchHistoryHeaderView : UIView<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, weak) id<MMTCSearchHistoryHeaderViewDelegate> delegate;

@property( copy, nonatomic) void( ^ retureBlock)(NSString * text);
@property( copy, nonatomic) void( ^ deleteBlock)(void);

+(instancetype)createMMTCSearchHistoryHeaderView;

@end
