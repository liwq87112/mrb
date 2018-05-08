//
//  Const.h
//  xskj
//
//  Created by 黎芹 on 16/4/26.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const jumpBaseURL;

/** 美美Token  */
//extern NSString * PH_Token;
//extern NSString *IsOpenFuYou;
//extern NSMutableDictionary *ShangRao;
//
//extern NSString * const PH_TokenHead;

/** view背景颜色  */
extern NSString *const viewBackgroundColor;

/** nav颜色 */
extern NSString *const MMTCNavColor;

/** 主题  */
extern NSString *const mainColor;

/** title */
extern NSString *const titleColor;

/** title */
extern NSString *const PlaColor;

extern NSString *const mainFont;

///** 字体灰  */
//extern NSString *const fontGrey;
///** 渐变开始  */
//extern NSString *const startColour;
///** 渐变结束  */
//extern NSString *const endColour;
///** 文字深蓝  */
//extern NSString *const deepBlue;
//
//extern NSString *const stateRed;
//extern NSString *const stateBlue;
//extern NSString *const yiHuanGrey;
//extern NSString *const stateGrey;
//extern NSString *const lightGreen;
//extern NSString *const btnGrey;
//extern NSString *const lineGrey;
//extern NSString *const mainFont;
//extern NSString *const fontLight;
//extern NSString *const msmYellow;
//extern NSString *const btnRed;
//extern NSString *const failRed;
//extern NSString *const nomainColor;
//extern NSString *const seleColor;

/**cookie*/
extern NSString *Cookie;

/** 导航栏最大Y值  */
extern CGFloat const NavMaxY;
/** titleview的高度  */
extern CGFloat const titleViewH;

/** tabbar的高度  */
extern CGFloat const TabbarH;


//发布要取消注释  还要检查版本时间 同盾配置
//#define zhengShiFaBu  

/**    原生network   **/
#define KHOST        [Const sharedConst].myKHOST
//#define jumpBaseURL  [Const sharedConst].myJumpBaseURL
//#define nonURL       [Const sharedConst].myNonURL

#define VersionKey @"curVersion"



@interface Const : NSObject

@property(nonatomic,strong)NSString *myKHOST;

//
+ (Const *)sharedConst;
//-(void)selectAPIWithOption:(NSString*)Option;

@end







