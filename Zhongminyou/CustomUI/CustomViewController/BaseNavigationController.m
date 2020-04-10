//
//  BaseNavigationController.m
//  WeiwaUser
//
//  Created by Rain on 16/7/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController (){
    UIView *headerView;
    UILabel *titleLbl;
    UIButton *leftBtn;
    UIButton *rightBtn;
}

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BackGroundColor;
    
    [self mainNavView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:true];
}

-(void)mainNavView{
    // headerView
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, HeaderHeight)];
    headerView.backgroundColor = NavigationBarColor;
    [self.view addSubview:headerView];
    // titleLbl
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(44, StatusBarHeight, ScreenWidth - 44 * 2, NavigationBarHeight)];
    titleLbl.textColor = TitleColor;
    titleLbl.font=[UIFont boldSystemFontOfSize:18];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    if (self.baseNavTitle != nil) {
        titleLbl.text = self.baseNavTitle;
    }
    [headerView addSubview:titleLbl];
    
    // leftBtn
    leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 40, NavigationBarHeight)];
    leftBtn.titleLabel.textColor = [UIColor darkGrayColor];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [leftBtn addTarget:self action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftBtn];
    
    // rightBtn
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 5 - 40, StatusBarHeight, 40, NavigationBarHeight)];
    rightBtn.titleLabel.textColor = TitleColor;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [rightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightBtn];
}

#pragma mark - public方法

// 获取headerView
-(UIView *)getHeaderView{
    return headerView;
}

/// 设置背景颜色
-(void)setHeaderViewBackground:(UIColor *)color{
    headerView.backgroundColor = color;
}

/**
 * 设置标题
 * @param navTitleString 文本(NSString)
 */
-(void)setNavTitle:(NSString *)navTitleString{
    titleLbl.text = navTitleString;
}

// 设置标题颜色
-(void)setNavTitleColor:(UIColor *)color{
    titleLbl.textColor = color;
}

/**
 * 设置左标题
 * @param leftTitleString NSString
 */
-(void)setLeftTitle:(NSString *)leftTitleString{
    [leftBtn setTitle:leftTitleString forState:UIControlStateNormal];
}

/**
 * 设置左图片
 * @param leftBtnImgString 图片(NSString)
 */
-(void)setLeftBtnImg:(NSString *)leftBtnImgString{
    [leftBtn setImage:[UIImage imageNamed:leftBtnImgString] forState:UIControlStateNormal];
}

/**
 * 设置右标题
 * @param rightTitleString NSString
 */
-(void)setRightTitle:(NSString *)rightTitleString{
    [rightBtn setTitle:rightTitleString forState:UIControlStateNormal];
}

/**
 * 设置右图片
 * @param rightBtnImgString 图片(NSString)
 */
-(void)setRightBtnImg:(NSString *)rightBtnImgString{
    [rightBtn setImage:[UIImage imageNamed:rightBtnImgString] forState:UIControlStateNormal];
}

/**
 * 左边点击事件
 * @param leftBtn UIButton
 */
-(void)clickLeftButton:(UIButton *)leftBtn{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

/**
 * 右边点击事件
 * @param rightBtn UIButton
 */
-(void)clickRightButton:(UIButton *)rightBtn{
    
}

@end
