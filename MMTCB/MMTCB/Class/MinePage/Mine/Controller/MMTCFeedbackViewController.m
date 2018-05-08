//
//  MMTCFeedbackViewController.m
//  MMTCB
//
//  Created by 李文强 on 2018/4/26.
//  Copyright © 2018年 李文强. All rights reserved.
//

#import "MMTCFeedbackViewController.h"
#import "HXPhotoPicker.h"
#import <YYTextView.h>
#import "MMTCLoginHttp.h"
#import "MMTCPswModel.h"

static const CGFloat kPhotoViewMargin = 5.0;

@interface MMTCFeedbackViewController ()<HXPhotoViewDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (strong, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
@property (nonatomic, assign) YYTextView *textView;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MMTCFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"意见反馈";
    
    [self layercorder:self.emailTextField];
    
    
    YYTextView *textView = [YYTextView new];
    textView.placeholderText = @"想吐槽就吐槽，想表扬就表扬，我们都爱～";
    textView.placeholderFont = [UIFont systemFontOfSize:15];
    textView.frame = CGRectMake(20, 20, ScreemW - 40, 150);
    textView.font = [UIFont systemFontOfSize:16];
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.allowsUndoAndRedo = YES; /// Undo and Redo
    textView.maximumUndoLevel = 10; /// Undo level
    textView.scrollIndicatorInsets = textView.contentInset;
    
    textView.layer.borderWidth = 0.5;
    textView.layer.cornerRadius = 3.0;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:textView];
    self.textView = textView;

//    [textView becomeFirstResponder];
    
    self.scrollView.alwaysBounceVertical =self;
    
    CGFloat width = self.scrollView.frame.size.width;_manager.configuration.themeColor = [UIColor blackColor];
//    self.manager.configuration.themeColor = [UIColor blackColor];
//    self.manager.configuration.cellSelectedTitleColor = [UIColor blackColor];
    
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin, width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    photoView.outerCamera = YES;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:photoView];
    self.photoView = photoView;

}

- (void)layercorder:(UITextField *)textfield{
    textfield.layer.borderWidth = 0.5;
    textfield.layer.cornerRadius = 3.0;
    textfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
}


#pragma mark - - - 提交反馈
- (IBAction)submitClick:(id)sender {

    
    [MMTCPswModel MineShopFeedbackContent:@"" Email:@"" Img_srcs:@"" Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"info = %@ code = %ld json = %@",show_err,response_code,json);
        if (response_code == 0 || response_code == 202) {
            [SVProgressHUD showErrorWithStatus:show_err];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
    }];
    
//    https://app.mmtcapp.com/services/uploader/uploadImg
//    tmp_f5b62cf5a5ed7cdf3b95ac32737bba2f.jpg
    
    
//    {
//        "info": "\/static\/upload\/image\/20180507\/20180507094746_75932.jpg",
//        "status": 1
//    }
    
    //post
    
//    https://app.mmtcapp.com/shopapi/shop/feedback
//    {
//        "_f": 1,
//        "content": "测试",
//        "contact": "mmtc",
//        "img_srcs": "/static/upload/image/20180507/20180507094746_75932.jpg"
//    }
//    {
//        "info": "",
//        "status": 1
//    }
}





#pragma mark - - - 图片选择
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
//    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
//    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
//     NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos.firstObject.previewPhoto,videos);

    [HXPhotoTools selectListWriteToTempPath:allList requestList:^(NSArray *imageRequestIds, NSArray *videoSessions) {
        NSSLog(@"requestIds - image : %@ \nsessions - video : %@",imageRequestIds,videoSessions);
    } completion:^(NSArray<NSURL *> *allUrl, NSArray<NSURL *> *imageUrls, NSArray<NSURL *> *videoUrls) {
        NSSLog(@"allUrl - %@\nimageUrls - %@\nvideoUrls - %@",allUrl,imageUrls,videoUrls);
        
    } error:^{
        NSSLog(@"失败");
    }];
//
//    NSData *data = [NSData dataWithContentsOfFile:imageUrls.firstObject];
            NSData *data = UIImageJPEGRepresentation(photos.firstObject.previewPhoto,1.0);
    [MMTCLoginHttp MineFeedBackWithImageData:data Success:^(NSInteger response_code, NSString *show_err, id json) {
        NSLog(@"code %ld - json %@ error %@",response_code,json,show_err);
    } error:^(NSError *error) {

    }];
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
    
}



- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}


- (HXDatePhotoToolManager *)toolManager {
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.openCamera = YES;
        _manager.configuration.lookLivePhoto = YES;
        _manager.configuration.photoMaxNum = 1;
        _manager.configuration.videoMaxNum = 6;
        _manager.configuration.maxNum = 10;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = NO;

        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
        __weak typeof(self) weakSelf = self;
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager) {
            
            // 这里拿使用系统相机做例子
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    HXPhotoModel *model;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        model = [HXPhotoModel photoModelWithImage:image];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools savePhotoToCustomAlbumWithName:self.manager.configuration.customAlbumName photo:model.thumbPhoto];
        }
    }else  if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *url = info[UIImagePickerControllerMediaURL];
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                         forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
        float second = 0;
        second = urlAsset.duration.value/urlAsset.duration.timescale;
        model = [HXPhotoModel photoModelWithVideoURL:url videoTime:second];
        if (self.manager.configuration.saveSystemAblum) {
            [HXPhotoTools saveVideoToCustomAlbumWithName:self.manager.configuration.customAlbumName videoURL:url];
        }
    }
    if (self.manager.configuration.useCameraComplete) {
        self.manager.configuration.useCameraComplete(model);
    }
}

@end
