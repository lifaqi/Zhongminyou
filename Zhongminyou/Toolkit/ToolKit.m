//
//  ToolKit.m
//  ProjectFrameOC
//
//  Created by 淘翼购 on 2019/12/25.
//  Copyright © 2019 shenwuyue. All rights reserved.
//

#import "ToolKit.h"
#import "SVProgressHUD.h"

#import "LoginViewController.h"

@implementation ToolKit

#pragma mark - 用户信息
/**
 * 判断是否登录
 * @return true 登录  false 未登录
 */
+(BOOL)isLogin{
    NSString *isLogin = [ToolKit getValueByKey:@"isLogin"];
    if (isLogin != nil && [isLogin isEqual:@"YES"]) {
        return true;
    }else{
        return false;
    }
}

/// 判断是否登录，如果未登录，则跳转到登录页面
+(BOOL)isLoginAndJumpLoginPage:(UIViewController *)vc{
    if ([ToolKit isLogin]) {
        return true;
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = true;
        [vc.navigationController pushViewController:loginVC animated:true];
        return false;
    }
}

+(void)setAccountInfo:(AccountInfoModel *)model{
    NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:nil];
    [ToolKit setValueByKey:@"AccountInfo" andObject:tempData];
}

+(AccountInfoModel *)getAccountInfo{
    NSData *tempData = [ToolKit getValueByKey:@"AccountInfo"];
    return [NSKeyedUnarchiver unarchivedObjectOfClass:[AccountInfoModel class] fromData:tempData error:nil];
}

+(void)setUserInfo:(UserInfoModel *)model{
    NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:nil];
    [ToolKit setValueByKey:@"UserInfo" andObject:tempData];
}

+(UserInfoModel *)getUserInfo{
    NSData *tempData = [ToolKit getValueByKey:@"UserInfo"];
    return [NSKeyedUnarchiver unarchivedObjectOfClass:[AccountInfoModel class] fromData:tempData error:nil];
}

#pragma mark - 字符串处理
+(CGFloat)getHeightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
 
// 对字符串进行处理
+(NSString *)dealWithString:(NSString *)str{
    str = [NSString stringWithFormat:@"%@",str];
    if([str isEqual:[NSNull null]] || [str isEqual:@"(null)"] || [str isEqual:@"<null>"]){
        return @"";
    }
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; // 去除收尾的空格和回车
}

// 中间4位为*号
+(NSString *)phoneEncryption:(NSString *)phoneNum{
    if (phoneNum == nil || phoneNum.length == 0) {
        return @"";
    }
    if (phoneNum.length < 11) {
        return phoneNum;
    }
    phoneNum = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return phoneNum;
}

// 根据字符串获取size
+(CGSize)getSizeWithString:(NSString *)contentStr andFont:(UIFont *)font{
    return [contentStr sizeWithAttributes:@{NSFontAttributeName:font}];
}

// 获取字符串的行数
+(NSInteger)getRowsWithString:(NSString *)contentStr andFont:(UIFont *)font andWidth:(CGFloat)width{
    CGSize size = [ToolKit getSizeWithString:contentStr andFont:font];
    return ceil(size.width / width);
}

// 处理图片路径
+(NSString *)getImageStr:(NSString *)imageStr{
    if (imageStr.length > 5 && [[imageStr substringToIndex:4] isEqual:@"http"]) {
        return imageStr;
    }else{
        return [NSString stringWithFormat:@"%@%@",ImageUrl,imageStr];
    }
}

// json格式的字符串 转成 我们所需要的dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

// NSDictionary to JSON string
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

// 获取字符串的首字母
+ (NSString *)firstCharactorWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *s = [str capitalizedString];
    return s;
}

#pragma mark - UIView处理
// 获取顶层view
+(UIView *)getTopView{
    UIView *topView = [UIApplication sharedApplication].windows[0].subviews[0];
    return topView;
}

+(UIViewController *)getToptViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].windows[0].rootViewController;
    
    return [self topViewControllerWithRootViewController:rootViewController];
}

+(UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

// UIView -> UIImageView
+(UIImageView *)getImageViewFromView:(UIView *)inputView{
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIImageView *snapshot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, inputView.frame.size.width, inputView.frame.size.height)];
    snapshot.image = image;
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}

+(void)autoHeight:(UITextView *)textView{
    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, [textView sizeThatFits:textView.bounds.size].height);
}

+(void)rotateAnimation:(UIView *)view andIsClockwise:(BOOL)isClockwise{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (isClockwise) {
        animation.fromValue = [NSNumber numberWithFloat:0.f];
        animation.toValue =  [NSNumber numberWithFloat:M_PI *2];
    }else{
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue = [NSNumber numberWithFloat:M_PI *2];
        animation.toValue =  [NSNumber numberWithFloat:0.f];
    }
    animation.duration  = 3;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [view.layer addAnimation:animation forKey:nil];
}

#pragma mark - 时间
// 获取当前日期,默认格式：yyyy-MM-dd HH:mm:ss
+(NSString *)getCurrentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter stringFromDate:[[NSDate alloc] init]];
}

// 获取当前日期,自定义格式
+(NSString *)getCurrentDate:(NSString *)dateFormatter{
    NSDateFormatter *mDateFormatter = [[NSDateFormatter alloc] init];
    mDateFormatter.dateFormat = dateFormatter;
    return [mDateFormatter stringFromDate:[[NSDate alloc] init]];
}

// 把日期字符串格式化为日期对象,默认格式：yyyy-MM-dd HH:mm:ss
+(NSDate *)getDateWithDateString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [dateFormatter dateFromString:dateString];
}

// 把日期字符串格式化为日期对象，自定义格式
+(NSDate *)getDateWithDateString:(NSString *)dateString andDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *dateFormatterTemp = [[NSDateFormatter alloc] init];
    dateFormatterTemp.dateFormat = dateFormatter;
    return [dateFormatterTemp dateFromString:dateString];
}

// 把日期对象格式化为日期字符串，自定义格式
+(NSString *)getDateStringWithDate:(NSDate *)date andDateFormatter:(NSString *)dateFormatter{
    NSDateFormatter *dateFormatterTemp = [[NSDateFormatter alloc] init];
    dateFormatterTemp.dateFormat = dateFormatter;
    return [dateFormatterTemp stringFromDate:date];
}

+(NSString *)getDateString:(NSString *)dateStr{
    NSArray *arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [ToolKit getDateWithDateString:dateStr];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger week = [comps weekday];
    return [NSString stringWithFormat:@"%ld月%ld日 %@",(long)month,(long)day,[arrWeek objectAtIndex:week]];
}

// 计算两者时间差，返回NSDateComponents
+(NSDateComponents *)getTimeDifference:(NSDate *)fromDate andToDate:(NSDate *)toDate andCalendarUnit:(NSCalendarUnit)calendarUnit{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:calendarUnit fromDate:fromDate toDate:toDate options:NSCalendarMatchStrictly];
    return cmps;
}

// 计算指定时间与当前的时间差,返回刚刚、xx分钟前、xx小时前、xx天前、xx月前、xx年前
+(NSString *)getTitleWithDateString:(NSString *)dateString{
    // 把日期字符串格式化为日期对象
    NSDate *date = [ToolKit getDateWithDateString:dateString andDateFormatter:@"yyyy-MM-dd HH:mm:ss"];
    
    // 得到与当前时间差
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    
    // 取绝对值
    timeInterval = fabs(timeInterval);
    
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval / 60) < 60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else if((temp = temp / 60) < 24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    
    else if((temp = temp / 24) < 30){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    
    else if((temp = temp / 30) < 12){
        result = [NSString stringWithFormat:@"%d月前",temp];
    }
    else{
        temp = temp / 12;
        result = [NSString stringWithFormat:@"%d年前",temp];
    }
    
    return  result;
}

// String to TimeInterval
+(NSTimeInterval)getTimeIntervalFromString:(NSString *)dateString{
    NSDate *timeDate = [ToolKit getDateWithDateString:dateString];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[timeDate timeIntervalSince1970]];
    return timeSp.longLongValue * 1000;
}

#pragma mark - 格式验证
// 判断手机号格式是否正确
+(BOOL)validateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

// 判断是否为纯数字
+(BOOL)isPureInt:(NSString *)string{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - 颜色处理
// 根据颜色创建图片
+(UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}

+(CAGradientLayer *)getGradientColor:(CGRect)bounds andColorArray:(NSArray *)colorArray{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = bounds;
    gradientLayer.colors = colorArray;
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    return gradientLayer;
}

#pragma mark - plist处理
+(NSMutableArray *)getPlistArrayData:(NSString *)plistName{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableArray *plistData = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    return plistData;
}

+(NSDictionary *)getPlistDictionaryData:(NSString *)plistName{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return plistData;
}

#pragma mark - 系统参数
// 获取ios版本号
+(CGFloat)getSystemVersionNo{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

// 获取自定义的版本号
+ (NSString *)getVersionNo{
    return VersionNo;
}

// 获取app的icon图标名称
+(NSString *)getAppIconName{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    //获取app中所有icon名字数组
    NSArray *iconsArr = infoDict[@"CFBundleIcons"][@"CFBundlePrimaryIcon"][@"CFBundleIconFiles"];
    //取最后一个icon的名字
    NSString *iconLastName = [iconsArr lastObject];
    
    return iconLastName;
}

// 拨打手机号
+(void)makeCall:(NSString *)phoneNum
{
    if(phoneNum ==nil || phoneNum.length==0){
        return;
    }
    if (phoneNum.length == 11) {
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@" " withString:@""];
        phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
    [ToolKit openUrl:[NSURL URLWithString:str]];
}

+(AppDelegate *)getAppDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+(CGFloat)frameWidth:(CGFloat)width{
    if (IPHONE5S) {
        return width / 414 * 320;
    }else if (IPHONE6_7){
        return width / 414 * 375;
    }else{
        return width;
    }
}

+(CGFloat)frameHeight:(CGFloat)height{
    if (IPHONE5S) {
        return height / 736 * 568;
    }else if (IPHONE6_7){
        return height / 736 * 667;
    }else{
        return height;
    }
}

+(void)openUrl:(NSURL *)url{
    if ([ToolKit getSystemVersionNo] >= 10) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }else{
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 短信验证码
+(void)showMobErrorInfo:(NSString *)errorCode{
    NSDictionary *errorDict = [ToolKit getPlistDictionaryData:@"MobErrorList"];
    [ToolKit showErrorWithStatus:errorDict[SWYNSStringFromFormat(@"300%@",errorCode)]];
}

#pragma mark - GCD

+(void)createAsyncThreads:(GCDCallBack)gcdCallBack{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        gcdCallBack();
    });
}

#pragma mark - UIAlertView
+(void)alertView:(id)target andTitle:(NSString *)title andMsg:(NSString *)msg andCancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitle:(NSString *)otherButtonTitle handler:(void (^)(int buttonIndex, UIAlertAction *alertView))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (cancelButtonTitle != nil) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler != nil) {
                handler(0, action);
            }
        }];
        [alertController addAction:cancelAction];
    }
    if (otherButtonTitle != nil) {
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (handler != nil) {
                handler(1, action);
            }
        }];
        [alertController addAction:otherAction];
    }
    
    [target presentViewController:alertController animated:true completion:nil];
}

+(void)actionSheetView:(id)target andTitle:(NSString *)title andMsg:(NSString *)msg andCancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitle:(NSArray *)otherButtonTitle handler:(void (^)(int buttonIndex, UIAlertAction *alertView))handler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancelButtonTitle != nil) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (handler != nil) {
                handler(0, action);
            }
        }];
        [alertController addAction:cancelAction];
    }
    if (otherButtonTitle != nil) {
        for (int i = 0; i < otherButtonTitle.count; i++) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (handler != nil) {
                    handler(i + 1, action);
                }
            }];
            [alertController addAction:otherAction];
        }
    }
    
    [target presentViewController:alertController animated:true completion:nil];
}

#pragma mark - NSUserDefaults
+(void)setValueByKey:(NSString *)key andObject:(id)obj{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setValue:obj forKey:key];
}

/**
 * 如果没有值，默认返回nil
 */
+(id)getValueByKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

/**
 * 如果没有值，默认返回defaultValue
 */
+(id)getValueByKey:(NSString *)key andDefaultValue:(id)defaultValue{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userDefault objectForKey:key];
    if (value == nil || [value isEqual:@""]) {
        return defaultValue;
    }else{
        return value;
    }
}

+(void)removeValueByKey:(NSString *)key{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:key];
}

+(void)clearUserDefaultCache{
    //清空 NSUserDefaults
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    // 设置引导图标识  true：第一次运行，显示引导图    false：不显示引导图
    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"IsFirstStart"];
}

#pragma mark - SVProgressHUD
+(void)showWithStatus:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+(void)showInfoWithStatus:(NSString *)msg{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+(void)showSuccessWithStatus:(NSString *)msg{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+(void)showErrorWithStatus:(NSString *)msg{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showErrorWithStatus:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+(void)showProgress:(NSString *)msg andProgressValue:(float)progressValue{
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showProgress:progressValue status:msg];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}

@end
