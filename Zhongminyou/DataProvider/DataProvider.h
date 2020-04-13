//
//  DataProvider.h
//  ProjectFrame
//
//  Created by Rain on 17/9/5.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import "BaseRequest.h"

@interface DataProvider : BaseRequest

/// 创建单例对象
+(DataProvider *)shareInstance;

#pragma mark - 登录&注册
-(void)login:(NSString *)phone andPassword:(NSString *)password andCallBackBlock:(CallBackBlock)callBackBlock;

-(void)registerAccount:(NSString *)phone andPassword:(NSString *)password andNickName:(NSString *)nickName andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 首页

/// 根据主题获取相册
-(void)getFoldersByTheme:(NSString *)themeId andPage:(NSString *)page andRow:(NSString *)row andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 加油站

#pragma mark - 订单

#pragma mark - 我的

@end
