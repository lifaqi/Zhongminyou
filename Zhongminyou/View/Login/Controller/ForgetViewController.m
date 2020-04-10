//
//  ForgetViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/7.
//

#import "ForgetViewController.h"
#import "CountDown.h"

@interface ForgetViewController ()<CountDownDelegate>

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    [self setNavTitle:@"找回密码"];
    
    [self initView];
}

#pragma mark - mainView
-(void)initView{
    // tipLbl
    UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(50), FH(120), ScreenWidth - FW(50), FH(44))];
    tipLbl.textColor = ColorRGBA(0, 0, 0, 0.8);
    tipLbl.font = [UIFont systemFontOfSize:14];
    tipLbl.text = @"如果你忘记了密码，可在此重置密码。";
    [self.view addSubview:tipLbl];
    // phoneTf
    UITextField *phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(tipLbl.frame) + FH(10), ScreenWidth - FW(30) * 2, FH(45))];
    phoneTf.backgroundColor = [UIColor whiteColor];
    phoneTf.layer.borderWidth = 0.5;
    phoneTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    phoneTf.layer.cornerRadius = CGRectGetHeight(phoneTf.frame) / 2;
    phoneTf.leftPadding = 20;
    phoneTf.placeholder = @"请输入手机号码";
    [self.view addSubview:phoneTf];
    
    // passwordTf
    UITextField *passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(phoneTf.frame) + FH(30), ScreenWidth - FW(30) * 2, FH(45))];
    passwordTf.backgroundColor = [UIColor whiteColor];
    passwordTf.layer.borderWidth = 0.5;
    passwordTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    passwordTf.layer.cornerRadius = CGRectGetHeight(passwordTf.frame) / 2;
    passwordTf.leftPadding = 20;
    passwordTf.rightPadding = 20;
    passwordTf.placeholder = @"请输入新密码";
    [self.view addSubview:passwordTf];
    // kejianBtn
    UIButton *kejianBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FH(15), FH(15))];
    kejianBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [kejianBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
    [kejianBtn setImage:[UIImage imageNamed:@"kejian"] forState:UIControlStateNormal];
    [kejianBtn setImage:[UIImage imageNamed:@"bukejian"] forState:UIControlStateSelected];
    [kejianBtn addTarget:self action:@selector(kejianEvent:) forControlEvents:UIControlEventTouchUpInside];
    passwordTf.rightView = kejianBtn;
    passwordTf.rightViewMode = UITextFieldViewModeAlways;
    
    // verificationCodeView
    UIView *verificationCodeView = [[UIView alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(passwordTf.frame) + FH(30), ScreenWidth - FW(30) * 2, FH(45))];
    verificationCodeView.backgroundColor = [UIColor whiteColor];
    verificationCodeView.layer.borderWidth = 0.5;
    verificationCodeView.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    verificationCodeView.layer.cornerRadius = CGRectGetHeight(passwordTf.frame) / 2;
    [self.view addSubview:verificationCodeView];
    // verifivationCodeTf
    UITextField *verificationCodeTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(verificationCodeView.frame), CGRectGetHeight(verificationCodeView.frame))];
    verificationCodeTf.leftPadding = 20;
    verificationCodeTf.placeholder = @"验证码";
    [verificationCodeView addSubview:verificationCodeTf];
    // daojishiBtn
    CountDown *daojishiBtn = [[CountDown alloc] initWithFrame:CGRectMake(CGRectGetWidth(verificationCodeView.frame) - FW(10 + 80), CGRectGetMinY(verificationCodeTf.frame) + FH(50 - 30) / 2, FW(80), FH(30)) andCountDownState:CountDownNormal];
    daojishiBtn.delegate = self;
    [verificationCodeView addSubview:daojishiBtn];
    
    // resetPwdBtn
    UIButton *resetPwdBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(verificationCodeView.frame), CGRectGetMaxY(verificationCodeView.frame) + FH(50), ScreenWidth - CGRectGetMinX(verificationCodeView.frame) * 2, FH(48))];
    [resetPwdBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    resetPwdBtn.layer.masksToBounds = YES;
    resetPwdBtn.layer.cornerRadius = CGRectGetHeight(resetPwdBtn.frame) / 2;
    [resetPwdBtn addTarget:self action:@selector(resetPwdEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPwdBtn];
    CAGradientLayer *gradientLayer = [ToolKit getGradientColor:resetPwdBtn.bounds andColorArray:@[(__bridge id)ColorRGBA(0, 0, 0, 0.7).CGColor, (__bridge id)ColorRGBA(0, 0, 0, 0.6).CGColor]];
    [resetPwdBtn.layer addSublayer:gradientLayer];
}

#pragma mark - event
-(void)kejianEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)resetPwdEvent{
    
}

#pragma mark - CountDownDelegate
-(BOOL)sendVerificationCode{
//    [[DataProvider shareInstance] send_mobile_code:^(id dict) {
//        if ([dict[@"error"] intValue] == 0) {
//            [ToolKit showSuccessWithStatus:dict[@"content"]];
//        }else{
//            [ToolKit showErrorWithStatus:dict[@"message"]];
//        }
//    }];
    
    return YES;
}

@end
