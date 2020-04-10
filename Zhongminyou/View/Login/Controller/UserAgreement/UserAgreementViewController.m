//
//  UserAgreementViewController.m
//  Wenshen
//
//  Created by Rain on 17/10/9.
//  Copyright © 2017年 zykj. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavTitle:@"用户协议"];
    [self setLeftBtnImg:@"left"];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initView
-(void)initView{
    // webView
    [self.view addSubview:self.webView];
}

#pragma mark - property
-(UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight)];
        [_webView loadRequest:[NSURLRequest requestWithURL:_url]];
    }
    return _webView;
}

@end
