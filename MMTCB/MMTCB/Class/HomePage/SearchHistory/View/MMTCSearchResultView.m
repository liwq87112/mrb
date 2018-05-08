//
//  MMTCSearchResultView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/27.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCSearchResultView.h"

@implementation MMTCSearchResultView

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    // 就下面这两行是重点
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入订单号/产品名称" attributes: @{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:self.searchTextField.font }];
    
//    self.searchTextField.attributedPlaceholder = attrString;
//    self.searchTextField.borderStyle = UITextBorderStyleNone;
//    self.searchTextField.returnKeyType = UIReturnKeySearch;
//    self.searchTextField.delegate = self;
    self.resultTextField.clearButtonMode=UITextFieldViewModeAlways;
    
    [self getTextFild: self.resultTextField WithLeftViewImage:@"search"];
}

- (void)getTextFild:(UITextField *)textField WithLeftViewImage:(NSString *)imageStr
{
    UIView *LeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    image.image = [UIImage imageNamed:imageStr];
    [LeftView addSubview:image];
    textField.leftView = LeftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.layer.cornerRadius = 3.0;
    textField.layer.masksToBounds = YES;
    
}

+(instancetype)createMMTCSearchHistoryHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:@"MMTCSearchResultView" owner:nil options:nil] lastObject];
}
@end
