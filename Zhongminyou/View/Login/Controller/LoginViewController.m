//
//  LoginViewController.m
//  ProjectFrameOC
//
//  Created by 淘翼购 on 2019/12/25.
//  Copyright © 2019 shenwuyue. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTabBarViewController.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"

@interface LoginViewController (){
    // view
    UITextField *accountTf;
    UITextField *passwordTf;
}

@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"中民油"];
    
    [self initView];
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCallBackSetting:) name:@"loginCallBackSetting" object:nil];
}

#pragma mark - initView
-(void)initView{
    // logoBgView
    UIView *logoBgView = [[UIView alloc] initWithFrame:CGRectMake((ScreenWidth - FW(130)) / 2, FH(200), FW(130), FW(130))];
    logoBgView.backgroundColor = [UIColor blackColor];
    logoBgView.layer.cornerRadius = CGRectGetWidth(logoBgView.frame) / 2.;
    [self.view addSubview:logoBgView];
    // logoIv
    UIImageView *logoIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(15), FW(15), CGRectGetWidth(logoBgView.frame) - FW(15) * 2, CGRectGetHeight(logoBgView.frame) - FW(15) * 2)];
    logoIv.image = [UIImage imageNamed:@"logo"];
    [logoBgView addSubview:logoIv];
    
    // accountTf
    accountTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(logoBgView.frame) + FH(50), ScreenWidth - FW(30) * 2, FH(45))];
    accountTf.backgroundColor = [UIColor whiteColor];
    accountTf.layer.borderWidth = 0.5;
    accountTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    accountTf.layer.cornerRadius = CGRectGetHeight(accountTf.frame) / 2;
    accountTf.leftPadding = 20;
    accountTf.placeholder = @"手机号";
    accountTf.text = @"123";
    [self.view addSubview:accountTf];
    
    // passwordTf
    passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(accountTf.frame) + FH(30), ScreenWidth - FW(30) * 2, FH(45))];
    passwordTf.backgroundColor = [UIColor whiteColor];
    passwordTf.layer.borderWidth = 0.5;
    passwordTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    passwordTf.layer.cornerRadius = CGRectGetHeight(passwordTf.frame) / 2;
    passwordTf.leftPadding = 20;
    passwordTf.secureTextEntry = YES;
    passwordTf.placeholder = @"密码";
    passwordTf.text = @"123";
    [self.view addSubview:passwordTf];
    
    // loginBtn
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(accountTf.frame), CGRectGetMaxY(passwordTf.frame) + FH(50), ScreenWidth - CGRectGetMinX(accountTf.frame) * 2, FH(48))];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = CGRectGetHeight(loginBtn.frame) / 2;
    [loginBtn addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    CAGradientLayer *gradientLayer = [ToolKit getGradientColor:loginBtn.bounds andColorArray:@[(__bridge id)ColorRGBA(0, 0, 0, 0.7).CGColor, (__bridge id)ColorRGBA(0, 0, 0, 0.6).CGColor]];
    [loginBtn.layer addSublayer:gradientLayer];
    
    // registerBtn
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - FW(100)) / 2, CGRectGetMaxY(loginBtn.frame) + FH(20), FW(100), FH(44))];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    // forgetBtn
//    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(loginBtn.frame) - FW(100) - FW(10), CGRectGetMaxY(loginBtn.frame) + FH(20), FW(100), FH(44))];
//    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgetBtn addTarget:self action:@selector(forgetEvent) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:forgetBtn];
}

#pragma mark - property


#pragma mark - event
-(void)loginEvent{
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"loginCallBackSetting" object:nil userInfo:nil];
//
//    return;

    NSString *accountValue = [ToolKit dealWithString:accountTf.text];
    NSString *passwordValue = [ToolKit dealWithString:passwordTf.text];
    
    if ([accountValue isEqualToString:@""]) {
        [ToolKit showErrorWithStatus:@"请输入账号"];
        return;
    }
    
    if ([passwordValue isEqualToString:@""]) {
        [ToolKit showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [ToolKit showWithStatus:@"登录中..."];
    [[DataProvider shareInstance] login:accountValue andPassword:passwordValue andCallBackBlock:^(id dict) {
        if ([dict[@"code"] intValue] == 0) {
            [ToolKit dismiss];
            
            SWYLog(@"%@",dict[@"data"]);
            
            [ToolKit setAccountInfo:[AccountInfoModel AccountInfoWithDict:accountValue andPassword:passwordValue]];
            [ToolKit setUserInfo:[UserInfoModel UserInfoWithDict:dict]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginCallBackSetting" object:nil userInfo:nil];
        }else{
            [ToolKit showErrorWithStatus:dict[@"msg"]];
        }
    }];
}

-(void)registerEvent{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)forgetEvent{
    ForgetViewController *forgetVC = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forgetVC animated:YES];
}

#pragma mark - 登录回调
-(void)loginCallBackSetting:(id)dataParam{
    CustomTabBarViewController *customTabBarVC = [[CustomTabBarViewController alloc] init];
    UINavigationController *navCustomTabBarVC = [[UINavigationController alloc] initWithRootViewController:customTabBarVC];
    navCustomTabBarVC.navigationBar.hidden = YES;
    [ToolKit getAppDelegate].window.rootViewController = navCustomTabBarVC;
}

@end
