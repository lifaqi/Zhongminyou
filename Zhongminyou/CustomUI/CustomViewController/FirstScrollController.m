//
//  FirstScrollController.m
//  LanDouS
//
//  Created by Mao-MacPro on 15/1/20.
//  Copyright (c) 2015年 Mao-MacPro. All rights reserved.
//

#import "FirstScrollController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#define ImgNum 3

@interface FirstScrollController (){
    // view
    UIScrollView *scrollBg;
    UIPageControl *pageCol;
}

@end

@implementation FirstScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    scrollBg=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    scrollBg.delegate = self;
    scrollBg.showsHorizontalScrollIndicator = NO;
    scrollBg.contentSize=CGSizeMake(ScreenWidth * ImgNum, ScreenHeight);
    scrollBg.pagingEnabled = YES;
    [self.view addSubview:scrollBg];
    
    for (int i = 0; i < ImgNum; i++) {
        UIImageView *imgInfo=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * i,0,ScreenWidth,ScreenHeight)];
        imgInfo.image=[UIImage imageNamed:[NSString stringWithFormat:@"index%d.png",i + 1]];
        [scrollBg addSubview:imgInfo];
    }
    
    pageCol = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight - 30, 320, 20)];
    pageCol.numberOfPages = ImgNum;
    [self.view addSubview:pageCol];
    
    pageCol.hidden = YES;
    
    [ToolKit setValueByKey:@"PictureTishiInfo" andObject:@"1"];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender{
    
    int pageIndex = fabs(sender.contentOffset.x) / sender.frame.size.width;
    pageCol.currentPage = pageIndex;
    
    if (sender.contentOffset.x > (ScreenWidth * (ImgNum - 1) + 60)) {
        NSNumber *value = [NSNumber numberWithBool:false];
        [ToolKit setValueByKey:@"IsFirstLogin" andObject:value];
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *navLoginVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        navLoginVC.navigationBar.hidden = true;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.window.rootViewController = navLoginVC;
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
