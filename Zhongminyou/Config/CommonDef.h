//
//  CommonDef.h
//  ProjectFrameOC
//
//  Created by 淘翼购 on 2019/12/25.
//  Copyright © 2019 shenwuyue. All rights reserved.
//

#ifndef CommonDef_h
#define CommonDef_h

#pragma mark - 服务器地址
#define BaseUrl @"https://zmy.yiduoxilanhua.cn"
#define ImageUrl @"https://zmy.yiduoxilanhua.cn"

#pragma mark - 机型判断 //
#define IPHONE5S ScreenWidth == 320 && ScreenHeight == 568
#define IPHONE6_7 ScreenWidth == 375 && ScreenHeight == 667
#define IPHONE6P_7P ScreenWidth == 414 && ScreenHeight == 736
#define IsiPhone11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsiPhone11Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IsiPhone11ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define IsiPhoneX IsiPhone11 || IsiPhone11Pro || IsiPhone11ProMax

#pragma mark - 尺寸大小
#define FW(w) [ToolKit frameWidth:w]
#define FH(h) [ToolKit frameWidth:h]

#pragma mark - NSString格式化
#define SWYNSStringFromFormat(fmt,...) [NSString stringWithFormat:fmt,##__VA_ARGS__]

#pragma mark - NSlog格式化
#define SWYLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#pragma mark - 弱引用
#define WEAKSELF __weak typeof(self) weakSelf = self;

#pragma mark - 支付
#define AppScheme @"www.xxx.com"

#pragma mark - 高德地图
#define MapAppKey @"70f85f21f20b08a5cde7d9ea9ecae6bc"

#pragma mark - 下载地址
#define AppStoreDownloadAddress @"https://itunes.apple.com/app/idxxxxxxxx"

#pragma mark - 版本号
#define VersionNo @"1.0"

#pragma mark - 推送
#define PushId @"www.xxx.com"


#pragma mark - view默认值设置
#define StatusBarHeight (IsiPhoneX ? 44 : 20)
#define NavigationBarHeight 44
#define HeaderHeight (StatusBarHeight + NavigationBarHeight)
#define TabBarHeight 49
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight (IsiPhoneX ? (([UIScreen mainScreen].bounds.size.height) - 34) : ([UIScreen mainScreen].bounds.size.height))

#pragma mark - 颜色
#define ColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]

#define NavigationBarColor ColorRGB(240, 240, 240)
#define TitleColor [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.00]
#define BackGroundColor ColorRGB(240, 240, 240)

#endif /* CommonDef_h */
