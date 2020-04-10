//
//  ToolKit.h
//  ProjectFrameOC
//
//  Created by 淘翼购 on 2019/12/25.
//  Copyright © 2019 shenwuyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^GCDCallBack)(void);

@interface ToolKit : NSObject

#pragma mark - 用户信息
/**
 * 判断是否登录
 * @return true 登录  false 未登录
 */
+(BOOL)isLogin;

/// 判断是否登录，如果未登录，则跳转到登录页面
+(BOOL)isLoginAndJumpLoginPage:(UIViewController *)vc;

#pragma mark - 字符串处理
/// 获取字符串高度
+(CGFloat)getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width;

/// 对字符串进行处理
+(NSString *)dealWithString:(NSString *)str;

/// 中间4位为*号
+(NSString *)phoneEncryption:(NSString *)phoneNum;

/// 根据字符串获取size
+(CGSize)getSizeWithString:(NSString *)contentStr andFont:(UIFont *)font;

/// 获取字符串的行数
+(NSInteger)getRowsWithString:(NSString *)contentStr andFont:(UIFont *)font andWidth:(CGFloat)width;

// 处理图片路径
+(NSString *)getImageStr:(NSString *)imageStr;

/// json格式的字符串 转成 我们所需要的dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/// NSDictionary to JSON string
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/// 获取字符串的首字母
+ (NSString *)firstCharactorWithString:(NSString *)string;

#pragma mark - UIView处理
/// 获取顶层view
+(UIView *)getTopView;

// 获取顶层的ViewController
+(UIViewController *)getToptViewController;

/// UIView -> UIImageView
+(UIImageView *)getImageViewFromView:(UIView *)inputView;

/// UITextView自适应高度，必须要在addSubview之后调用，否则不起作用
+(void)autoHeight:(UITextView *)textView;

/// 旋转。isClockwise：true 顺时针  false 逆时针
+(void)rotateAnimation:(UIView *)view andIsClockwise:(BOOL)isClockwise;

#pragma mark - 时间
/// 获取当前日期,默认格式：yyyy-MM-dd HH:mm:ss
+(NSString *)getCurrentDate;

/// 获取当前日期,自定义格式
+(NSString *)getCurrentDate:(NSString *)dateFormatter;

/// 把日期字符串格式化为日期对象,默认格式：yyyy-MM-dd HH:mm:ss
+(NSDate *)getDateWithDateString:(NSString *)dateString;

/// 把日期字符串格式化为日期对象，自定义格式
+(NSDate *)getDateWithDateString:(NSString *)dateString andDateFormatter:(NSString *)dateFormatter;

/// 把日期对象格式化为日期字符串，自定义格式
+(NSString *)getDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter;

/// 日期格式化
+(NSString *)getDateString:(NSString *)dateStr;

/// 计算两者时间差，返回NSDateComponents
+(NSDateComponents *)getTimeDifference:(NSDate *)fromDate andToDate:(NSDate *)toDate andCalendarUnit:(NSCalendarUnit)calendarUnit;

/// 计算指定时间与当前的时间差,返回刚刚、xx分钟前、xx小时前、xx天前、xx月前、xx年前
+(NSString *)getTitleWithDateString:(NSString *)dateString;

/// String to TimeInterval
+(NSTimeInterval)getTimeIntervalFromString:(NSString *)dateString;

#pragma mark - 格式验证
/// 判断手机号格式是否正确
+(BOOL)validateMobile:(NSString *)mobile;

/// 判断是否为纯数字
+(BOOL)isPureInt:(NSString *)string;

#pragma mark - 颜色处理
/// 根据颜色创建图片
+(UIImage *)createImageWithColor:(UIColor *)color;

+(CAGradientLayer *)getGradientColor:(CGRect)bounds andColorArray:(NSArray *)colorArray;

#pragma mark - plist处理

/// 获取plist数据
+(NSMutableArray *)getPlistArrayData:(NSString *)plistName;

+(NSMutableDictionary *)getPlistDictionaryData:(NSString *)plistName;

#pragma mark - 系统参数
/// 获取ios系统版本号
+(CGFloat)getSystemVersionNo;

/// // 获取自定义的版本号
+ (NSString *)getVersionNo;

/// 获取app的icon图标名称
+(NSString *)getAppIconName;

/// 拨打手机号
+(void)makeCall:(NSString *)phoneNum;

+(AppDelegate *)getAppDelegate;

+(CGFloat)frameWidth:(CGFloat)width;

+(CGFloat)frameHeight:(CGFloat)height;

+(void)openUrl:(NSURL *)url;

#pragma mark - 短信验证码

+(void)showMobErrorInfo:(NSString *)errorCode;

#pragma mark - GCD

/// 创建子线程
+(void)createAsyncThreads:(GCDCallBack)gcdCallBack;

#pragma mark - UIAlertView
+(void)alertView:(id)target andTitle:(NSString *)title andMsg:(NSString *)msg andCancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitle:(NSString *)otherButtonTitle handler:(void (^)(int buttonIndex, UIAlertAction *alertView))handler;

+(void)actionSheetView:(id)target andTitle:(NSString *)title andMsg:(NSString *)msg andCancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitle:(NSArray *)otherButtonTitle handler:(void (^)(int buttonIndex, UIAlertAction *alertView))handler;

#pragma mark - NSUserDefaults
+(void)setValueByKey:(NSString *)key andObject:(id)obj;

/**
 * 如果没有值，默认返回""
 */
+(id)getValueByKey:(NSString *)key;

/**
 * 如果没有值，默认返回defaultValue,defaultValue为nil，返回""
 */
+(id)getValueByKey:(NSString *)key andDefaultValue:(id)defaultValue;

+(void)removeValueByKey:(NSString *)key;

+(void)clearUserDefaultCache;

#pragma mark - SVProgressHUD
+(void)showWithStatus:(NSString *)msg;

+(void)showInfoWithStatus:(NSString *)msg;

+(void)showSuccessWithStatus:(NSString *)msg;

+(void)showErrorWithStatus:(NSString *)msg;

+(void)showProgress:(NSString *)msg andProgressValue:(float)progressValue;

+(void)dismiss;

@end

NS_ASSUME_NONNULL_END
