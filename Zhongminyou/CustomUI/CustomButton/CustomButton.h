//
//  CustomButton.h
//  Moyu
//
//  Created by Rain on 5/2/17.
//  Copyright © 2017 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

#pragma mark - 属性
@property (nonatomic, strong) UIImageView *showIv;
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UILabel *detailLbl;

#pragma mark - 属性

/// 左右，图片左，文字右
-(instancetype)initWithFrameLeftRight:(CGRect)rect;

// 左右。图片右，文字左
-(instancetype)initWithFrameLeftRight:(CGRect)rect andIsLeft:(BOOL)isLeft;

/// 左右。图片左，title、detail右边上下显示
-(instancetype)initWithFrameTitleDetail:(CGRect)rect andImageUrlString:(NSString *)imageUrlString andTitle:(NSString *)title andDetail:(NSString *)detail;

/// 左右。图片左，title、detail右边上下显示
-(instancetype)initWithFrameTitleDetail:(CGRect)rect andImageName:(NSString *)imageName andTitle:(NSString *)title andDetail:(NSString *)detail;

@end
