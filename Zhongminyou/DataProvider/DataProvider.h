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

#pragma mark - Main

#pragma mark - Classify

/// 根据主题获取相册
-(void)getFoldersByTheme:(NSString *)themeId andPage:(NSString *)page andRow:(NSString *)row andCallBackBlock:(CallBackBlock)callBackBlock;

/// 根据相册获取图片
-(void)getPicturesByFolderId:(NSString *)flderId andPage:(NSString *)page andRow:(NSString *)row andCallBackBlock:(CallBackBlock)callBackBlock;

@end
