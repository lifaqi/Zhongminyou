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

// 查询推荐加油站list  默认查询附近100公里内所有加油站 距离从小到大排序
-(void)getCommentGasList:(NSString *)lng andLat:(NSString *)lat andOil:(NSString *)oil andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/static/recommend/list?lng=%@&lat=%@&oil=%@",BaseUrl, lng, lat, oil];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

#pragma mark - 加油站

// 附近加油站
-(void)getFujinGasList:(NSString *)lng andLat:(NSString *)lat andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/static/nearby/list?lng=%@&lat=%@",BaseUrl, lng, lat];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

// 加油站详情
-(void)getGasDetail:(NSString *)gasId andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/static/get/%@",BaseUrl, gasId];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

#pragma mark - 订单

// 确认支付
-(void)surePay:(NSString *)staticId andMachineCode:(NSString *)machineCode andMachineNozzleCode:(NSString *)machineNozzleCode andMachineNozzleOilsType:(NSString *)machineNozzleOilsType andMachineNozzleOils:(NSString *)machineNozzleOils andOilsPrice:(NSString *)oilsPrice andLitre:(NSString *)litre andTotal:(NSString *)total andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/wx/filling/order/doUnifiedOrder",BaseUrl];
    
    NSDictionary *params = [self handleParam:@[@"staticId",
                                               @"machineCode",
                                               @"machineNozzleCode",
                                               @"machineNozzleOilsType",
                                               @"machineNozzleOils",
                                               @"oilsPrice",
                                               @"litre",
                                               @"total"]
                                   andResult:@[staticId,
                                               machineCode,
                                               machineNozzleCode,
                                               machineNozzleOilsType,
                                               machineNozzleOils,
                                               oilsPrice,
                                               litre,
                                               total]];
    
    [self postRequest:url andParams:params andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
    
//    [self getRequest:url andCallBackBlock:^(id dict) {
//        callBackBlock(dict);
//    }];
}

// 获取全部订单
-(void)getAllOrder:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/order/list",BaseUrl];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

// 获取订单：1是未支付,2是已支付
-(void)getOrder:(NSString *)orderId andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/order/paystatus/get/%@",BaseUrl, orderId];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

#pragma mark - 我的

// 加油站详情
-(void)getUserInfo:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/api/v1/filling/member/info/get",BaseUrl];
    
    [self getRequest:url andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}



@end
