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

// 加油站详情
-(void)getGasDetail:(NSString *)gasId andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 首页

// 查询推荐加油站list  默认查询附近100公里内所有加油站 距离从小到大排序
-(void)getCommentGasList:(NSString *)lng andLat:(NSString *)lat andOil:(NSString *)oil andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 加油站

// 附近加油站
-(void)getFujinGasList:(NSString *)lng andLat:(NSString *)lat andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 订单

// 确认支付
-(void)surePay:(NSString *)staticId andMachineCode:(NSString *)machineCode andMachineNozzleCode:(NSString *)machineNozzleCode andMachineNozzleOilsType:(NSString *)machineNozzleOilsType andMachineNozzleOils:(NSString *)machineNozzleOils andOilsPrice:(NSString *)oilsPrice andLitre:(NSString *)litre andTotal:(NSString *)total andCallBackBlock:(CallBackBlock)callBackBlock;

// 获取全部订单
-(void)getAllOrder:(CallBackBlock)callBackBlock;

// 获取订单：1是未支付,2是已支付
-(void)getOrder:(NSString *)orderId andCallBackBlock:(CallBackBlock)callBackBlock;

#pragma mark - 我的

// 加油站详情
-(void)getUserInfo:(CallBackBlock)callBackBlock;

@end
