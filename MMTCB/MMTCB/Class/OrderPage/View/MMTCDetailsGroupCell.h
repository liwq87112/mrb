//
//  MMTCDetailsGroupCell.h
//  MMTCB
//
//  Created by 李文强 on 2018/5/2.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTCDetailsModel.h"

#define MMTCDetailsGroupCellH 80

@interface MMTCDetailsGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *statuimageView;
@property (weak, nonatomic) IBOutlet UILabel *leftNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;

- (void)fillIntoModel:(MMTCDetailsGroupInfoModel *)model;

@end
