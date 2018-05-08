//
//  MMTCHomeHeadView.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/24.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCHomeHeadView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "MMTCSeachHistoryViewController.h"
#import "MMTCUserCodeViewController.h"
#import "QCodeController.h"
#import <AVFoundation/AVFoundation.h>

@implementation MMTCHomeHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];

    CGFloat space = 20.0;
    [self.scanButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                    imageTitleSpace:space];
    [self.inputCodeButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop
                                     imageTitleSpace:space];
}

#pragma mark - - - 输入验证
- (IBAction)inputClick:(id)sender {
    MMTCUserCodeViewController * code = [MMTCUserCodeViewController new];
    [self.navigationController pushViewController:code animated:YES];
    NSLog(@"input");
}

#pragma mark - - - 扫码验证
- (IBAction)scanClick:(id)sender {
    NSLog(@"scan");
    QCodeController *vc = [QCodeController new];
    [self QRCodeScanVC:vc];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - - - 查找
- (IBAction)searchClick:(id)sender {
    MMTCSeachHistoryViewController *his = [MMTCSeachHistoryViewController new];
    [self.navigationController pushViewController:his animated:YES];
}

- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 美容宝] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self.navigationController presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self.navigationController presentViewController:alertC animated:YES completion:nil];
}

@end
