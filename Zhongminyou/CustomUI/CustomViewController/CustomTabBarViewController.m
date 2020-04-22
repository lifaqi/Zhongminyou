//
//  CustomTabBarViewController.m
//  WeiwaUser
//
//  Created by Rain on 16/7/19.
//  Copyright © 2016年 zykj. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "LoginViewController.h"
#import "IndexViewController.h"
#import "GasViewController.h"
#import "OrderViewController.h"
#import "MineViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self mainTabBarItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setDefaultSelectTabBarItem:) name:@"setDefaultSelectTabBarItem" object:nil];
}

- (void)mainTabBarItem{
    
    // indexVC
    IndexViewController *indexVC = [[IndexViewController alloc] init];
    indexVC.tabBarItem.tag = 0;
    [self setUpOneChildViewController:indexVC andImageStr:@"index" andSelectImageStr:@"index1" andTitle:@"首页"];
    
    // gasVC
    GasViewController *gasVC = [[GasViewController alloc] init];
    gasVC.tabBarItem.tag = 1;
    [self setUpOneChildViewController:gasVC andImageStr:@"type" andSelectImageStr:@"type1" andTitle:@"加油站"];
    
    // orderVC
    OrderViewController *orderVC = [[OrderViewController alloc] init];
    orderVC.tabBarItem.tag = 2;
    [self setUpOneChildViewController:orderVC andImageStr:@"cart" andSelectImageStr:@"cart1" andTitle:@"  订单"];
    
    // mineVC
    MineViewController *mineVC = [[MineViewController alloc] init];
    mineVC.tabBarItem.tag = 3;
    [self setUpOneChildViewController:mineVC andImageStr:@"mine" andSelectImageStr:@"mine1" andTitle:@"我的"];
}

-(void)setUpOneChildViewController:(UIViewController *)viewController andImageStr:(NSString *)imageStr andSelectImageStr:(NSString *)selectImageStr andTitle:(NSString *)title{
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:viewController];
    navVC.navigationBar.hidden = true;
    navVC.title = title;
    navVC.tabBarItem.image = [UIImage imageNamed:imageStr];
    navVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:navVC];
    
    //选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RedColor} forState:UIControlStateSelected];
}

// 设置默认选中tabBar
-(void)setDefaultSelectTabBarItem:(id)sender{
    int index = [[sender userInfo][@"index"] intValue];
    self.selectedIndex = index;
}

@end
