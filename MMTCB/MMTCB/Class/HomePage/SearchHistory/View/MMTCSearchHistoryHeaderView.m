//
//  MMTCSearchHistoryHeaderView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCSearchHistoryHeaderView.h"
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

@implementation MMTCSearchHistoryHeaderView

-(void)awakeFromNib{
    
    [super awakeFromNib];

    // 就下面这两行是重点
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入订单号/产品名称" attributes: @{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:self.searchTextField.font }];
//    
//    self.searchTextField.attributedPlaceholder = attrString;
    self.searchTextField.borderStyle = UITextBorderStyleNone;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    self.searchTextField.clearButtonMode=UITextFieldViewModeAlways;
    
    [self getTextFild: self.searchTextField WithLeftViewImage:@"search"];
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


- (IBAction)click:(UIButton *)sender {
    NSLog(@"go");
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

#pragma mark --------- UITextFieldDelegate -------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField.text.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"抱歉,您输入的结果不能超过20个文字!"];
        return YES;
    }
    
    if (kStringIsEmpty(textField.text)) {
        [SVProgressHUD showErrorWithStatus:@"抱歉,您输入的结果不能为空!"];
        return YES;
    }
    
    if (self.retureBlock) {
        self.retureBlock(textField.text);
    }
    
    return YES;
}


+(instancetype)createMMTCSearchHistoryHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:@"MMTCSearchHistoryHeaderView" owner:nil options:nil] lastObject];
}
@end
