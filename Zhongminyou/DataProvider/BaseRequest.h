//
//  BaseRequest.h
//  Yingrui
//
//  Created by Rain on 16/10/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"
#import "AFHTTPSessionManager.h"

@interface BaseRequest : NSObject

typedef void (^CallBackBlock)(id dict);      // 请求回调block

#pragma mark - func
-(NSDictionary *)handleParam:(NSArray *)params andResult:(NSArray *)results;

#pragma mark - request
-(void)getRequest:(NSString *)url andCallBackBlock:(CallBackBlock)callBackBlock;

-(void)postRequest:(NSString *)url andParams:(NSDictionary *)params andCallBackBlock:(CallBackBlock)callBackBlock;

-(void)uploadImg:(NSString *)url andPrm:(NSDictionary *)prm andFileData:(NSArray *)fileData andName:(NSString *)name andCallBackBlock:(CallBackBlock)callBackBlock;

@end
