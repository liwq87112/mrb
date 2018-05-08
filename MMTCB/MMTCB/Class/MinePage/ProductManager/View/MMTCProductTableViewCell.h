//
//  MMTCProductTableViewCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/4/25.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMTCProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productIdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *ProducttitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *spellMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *spellLabel;
@property (weak, nonatomic) IBOutlet UIButton *xiaJiaButton;
@property (weak, nonatomic) IBOutlet UIButton *editorButton;

@end
