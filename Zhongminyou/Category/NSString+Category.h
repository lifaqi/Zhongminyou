//
//  NSString+Category.h
//  Wenshen
//
//  Created by Rain on 17/9/15.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/// 判断字符串是否存在特殊字符
+ (BOOL)stringContainsEmoji:(NSString *)string;

/// 去除特殊字符
+ (NSString*)disable_EmojiString:(NSString *)text;

@end
