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

#pragma mark - Main

#pragma mark - Classify

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

// 根据相册获取图片
-(void)getPicturesByFolderId:(NSString *)flderId andPage:(NSString *)page andRow:(NSString *)row andCallBackBlock:(CallBackBlock)callBackBlock{
    NSString *url = [NSString stringWithFormat:@"%@/pic/getPictures",BaseUrl];
    
    NSDictionary *params = [self handleParam:@[@"FFolderID",
                                               @"page",
                                               @"row"]
                                   andResult:@[flderId,
                                               page,
                                               row]];
    [self postRequest:url andParams:params andCallBackBlock:^(id dict) {
        callBackBlock(dict);
    }];
}

@end
