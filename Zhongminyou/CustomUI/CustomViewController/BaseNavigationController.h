//
//  BaseNavigationController.h
//  WeiwaUser
//
//  Created by Rain on 16/7/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UIViewController

@property (nonatomic, strong) NSString *baseNavTitle;

/// 获取headerView
-(UIView *)getHeaderView;

/// 设置背景颜色
-(void)setHeaderViewBackground:(UIColor *)color;

/// 设置标题
-(void)setNavTitle:(NSString *)navTitle;

/// 设置标题颜色
-(void)setNavTitleColor:(UIColor *)color;

/// 设置左标题
-(void)setLeftTitle:(NSString *)leftTitle;

/// 设置左图片
-(void)setLeftBtnImg:(NSString *)leftBtnImg;

/// 设置右标题
-(void)setRightTitle:(NSString *)rightTitle;

/// 设置右图片
-(void)setRightBtnImg:(NSString *)rightBtnImg;

/// 设置左button内容
-(void)clickLeftButton:(UIButton *)leftBtn;

/// 设置右button内容
-(void)clickRightButton:(UIButton *)rightBtn;

@end
