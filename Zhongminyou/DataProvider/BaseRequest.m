//
//  BaseRequest.m
//  Yingrui
//
//  Created by Rain on 16/10/17.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseRequest.h"

@interface BaseRequest(){
    NSURLSessionDataTask *dataTask;
}

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BaseRequest

#pragma mark - property
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        
        // 最大请求并发任务数
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        
        // 请求格式
        // AFHTTPRequestSerializer            二进制格式
        // AFJSONRequestSerializer            JSON
        // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        // 超时时间
        _manager.requestSerializer.timeoutInterval = 15;
        
        // 设置接收的类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", nil];
        
        // 返回格式
        // AFHTTPResponseSerializer           二进制格式
        // AFJSONResponseSerializer           JSON
        // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
        // AFXMLDocumentResponseSerializer (Mac OS X)
        // AFPropertyListResponseSerializer   PList
        // AFImageResponseSerializer          Image
        // AFCompoundResponseSerializer       组合
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    return _manager;
}

#pragma mark - func
- (NSDictionary *)handleParam:(NSArray *)params andResult:(NSArray *)results {
    NSString *json = @"";
    @try {
        if (params && results && params.count == results.count) {
            json = @"";
            for (int i = 0; i < params.count ; i++) {
                if (i == 0) {
                    json = [NSString stringWithFormat:@"\"%@\":\"%@\"",params[i],[ToolKit handleSpecialCharacters:results[i]]];
                }else{
                    json = [NSString stringWithFormat:@"%@,\"%@\":\"%@\"",json,params[i],[ToolKit handleSpecialCharacters:results[i]]];
                }
            }
            json = [NSString stringWithFormat:@"{%@}",json];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return [ToolKit dictionaryWithJsonString:json];
}

#pragma mark - request
- (void)getRequest:(NSString *)url andCallBackBlock:(CallBackBlock)callBackBlock {
    
    // 设置请求头
    [_manager.requestSerializer setValue:[ToolKit getUserInfo].access_token forHTTPHeaderField:@"access_token"];
    
    dataTask = [self.manager GET:[ToolKit handleSpecialCharacters:url] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress){
        // 进度条
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        // 请求服务器成功
//        NSData *resultData = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
        id dataDict = responseObject; // [NSJSONSerialization JSONObjectWithData:resultData options:0 error:nil];
        
        callBackBlock(dataDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        // 请求服务器失败
        callBackBlock(nil);
        [ToolKit showErrorWithStatus:@"请求服务器失败"];
    }];
}

- (void)postRequest:(NSString *)url andParams:(NSDictionary *)params andCallBackBlock:(CallBackBlock)callBackBlock {
    
    // 设置请求头
    [_manager.requestSerializer setValue:[ToolKit getUserInfo].access_token forHTTPHeaderField:@"access_token"];
    
    dataTask = [self.manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress){
        // 进度条
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        // 请求服务器成功
//        NSData *resultData = [[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
        id dataDict = responseObject;//[NSJSONSerialization JSONObjectWithData:resultData options:0 error:nil];
        
        callBackBlock(dataDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        // 请求服务器失败
        callBackBlock(nil);
        [ToolKit showErrorWithStatus:@"请求服务器失败"];
    }];
}

- (void)uploadImg:(NSString *)url andPrm:(NSDictionary *)prm andFileData:(NSArray *)fileData andName:(NSString *)name andCallBackBlock:(CallBackBlock)callBackBlock {
    
    // 设置请求头
    [_manager.requestSerializer setValue:[ToolKit getUserInfo].access_token forHTTPHeaderField:@"access_token"];
    
    dataTask = [self.manager POST:url parameters:prm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (fileData.count > 0) {
            for (int i = 0; i < fileData.count; i++) {
                NSString *fileName = [NSString  stringWithFormat:@"%@.png", [ToolKit getCurrentDate:@"yyyyMMddHHmmss"]];
                [formData appendPartWithFileData:fileData[i] name:name fileName:fileName mimeType:@"image/png"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (fileData.count > 1){
            [ToolKit showProgress:@"上传图片中..." andProgressValue:uploadProgress.fractionCompleted];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求服务器成功
        NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data =[str dataUsingEncoding:NSUTF8StringEncoding];
        id dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        callBackBlock(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求服务器失败
        callBackBlock(nil);
        [ToolKit showErrorWithStatus:@"请求服务器失败"];
    }];
}

@end
