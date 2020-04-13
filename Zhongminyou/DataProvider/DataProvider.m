//
//  DataProvider.m
//  ProjectFrame
//
//  Created by Rain on 17/9/5.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import "DataProvider.h"

@implementation DataProvider

// 创建单例对象
+(DataProvider *)shareInstance{
    static DataProvider *dataProvider = nil;
    if (dataProvider == nil) {
        dataProvider = [[DataProvider alloc] init];
    }
    return dataProvider;
}

#pragma mark - 登录&注册
-(void)login:(NSString *)phone andPassword:(NSString *)password andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = SWYNSStringFromFormat(@"%@/v1/login",BaseUrl);
    
    NSDictionary *params = [self handleParam:@[@"phone",
                                               @"password"]
                                   andResult:@[phone,
                                               password]];
    
    [self postRequest:url andParams:params andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

-(void)registerAccount:(NSString *)phone andPassword:(NSString *)password andNickName:(NSString *)nickName andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = SWYNSStringFromFormat(@"%@/v1/register",BaseUrl);
    
    NSDictionary *params = [self handleParam:@[@"phone",
                                               @"password",
                                               @"nickname",
                                               @"memberType"]
                                   andResult:@[phone,
                                               password,
                                               nickName,
                                               @"3"]];
    
    [self postRequest:url andParams:params andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

#pragma mark - 首页

// 根据主题获取相册
-(void)getFoldersByTheme:(NSString *)themeId andPage:(NSString *)page andRow:(NSString *)row andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/fol/getFoldersByTheme",BaseUrl];
    
    NSDictionary *params = [self handleParam:@[@"FThemeID",
                                               @"page",
                                               @"row"]
                                   andResult:@[themeId,
                                               page,
                                               row]];
    [self postRequest:url andParams:params andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

#pragma mark - 加油站

#pragma mark - 订单

#pragma mark - 我的



@end
