//
//  RegisterViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/7.
//

#import "RegisterViewController.h"
#import "TTTAttributedLabel.h"
#import "UserAgreementViewController.h"

@interface RegisterViewController ()<TTTAttributedLabelDelegate>{
    UIButton *checkBtn;
}

@property (nonatomic, strong) TTTAttributedLabel *fuwutiaokuanLbl;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    [self setNavTitle:@"用户注册"];
    
    [self initView];
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
    
    // nickNameTf
    UITextField *nickNameTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(logoBgView.frame) + FH(50), ScreenWidth - FW(30) * 2, FH(45))];
    nickNameTf.backgroundColor = [UIColor whiteColor];
    nickNameTf.layer.borderWidth = 0.5;
    nickNameTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    nickNameTf.layer.cornerRadius = CGRectGetHeight(nickNameTf.frame) / 2;
    nickNameTf.leftPadding = 20;
    nickNameTf.placeholder = @"昵称";
    [self.view addSubview:nickNameTf];
    
    // phoneTf
    UITextField *phoneTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(nickNameTf.frame) + FH(30), ScreenWidth - FW(30) * 2, FH(45))];
    phoneTf.backgroundColor = [UIColor whiteColor];
    phoneTf.layer.borderWidth = 0.5;
    phoneTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    phoneTf.layer.cornerRadius = CGRectGetHeight(phoneTf.frame) / 2;
    phoneTf.leftPadding = 20;
    phoneTf.placeholder = @"手机号";
    [self.view addSubview:phoneTf];
    
    // passwordTf
    UITextField *passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(phoneTf.frame) + FH(30), ScreenWidth - FW(30) * 2, FH(45))];
    passwordTf.backgroundColor = [UIColor whiteColor];
    passwordTf.layer.borderWidth = 0.5;
    passwordTf.layer.borderColor = ColorRGBA(244, 244, 244, 0.3).CGColor;
    passwordTf.layer.cornerRadius = CGRectGetHeight(passwordTf.frame) / 2;
    passwordTf.leftPadding = 20;
    passwordTf.placeholder = @"密码";
    [self.view addSubview:passwordTf];
    // kejianBtn
    UIButton *kejianBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, FH(17), FH(17))];
    kejianBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [kejianBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
    [kejianBtn setImage:[UIImage imageNamed:@"kejian"] forState:UIControlStateNormal];
    [kejianBtn setImage:[UIImage imageNamed:@"bukejian"] forState:UIControlStateSelected];
    [kejianBtn addTarget:self action:@selector(kejianEvent:) forControlEvents:UIControlEventTouchUpInside];
    passwordTf.rightView = kejianBtn;
    passwordTf.rightViewMode = UITextFieldViewModeAlways;
    
    // registerBtn
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(passwordTf.frame), CGRectGetMaxY(passwordTf.frame) + FH(50), ScreenWidth - CGRectGetMinX(passwordTf.frame) * 2, FH(48))];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = CGRectGetHeight(registerBtn.frame) / 2;
    [registerBtn addTarget:self action:@selector(registerEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    CAGradientLayer *gradientLayer = [ToolKit getGradientColor:registerBtn.bounds andColorArray:@[(__bridge id)ColorRGBA(0, 0, 0, 0.7).CGColor, (__bridge id)ColorRGBA(0, 0, 0, 0.6).CGColor]];
    [registerBtn.layer addSublayer:gradientLayer];
    
    // checkBtn
    checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(registerBtn.frame) + FW(10), CGRectGetMaxY(registerBtn.frame) + FH(15), FH(17), FH(17))];
    [checkBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    checkBtn.selected = YES;
    [checkBtn addTarget:self action:@selector(clickCheckEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    // fuwutiaokuanLbl
    [self.fuwutiaokuanLbl setText:@"我已看过并接受《用户协议》" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor colorWithRed:0.71 green:0.03 blue:0.13 alpha:1.00] range:NSMakeRange(7, 6)];
        return mutableAttributedString;
    }];
    [self.fuwutiaokuanLbl addLinkToURL:[NSURL URLWithString:@"http://www.lynongjing.com/privacypolicy"] withRange:NSMakeRange(7, 6)];
    [self.view addSubview:self.fuwutiaokuanLbl];
}

#pragma mark - property
-(TTTAttributedLabel *)fuwutiaokuanLbl{
    if (_fuwutiaokuanLbl == nil) {
        _fuwutiaokuanLbl = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(checkBtn.frame) + FW(5), CGRectGetMinY(checkBtn.frame), FW(250), FH(17))];
        _fuwutiaokuanLbl.delegate = self;
        _fuwutiaokuanLbl.enabledTextCheckingTypes = NSTextCheckingTypeLink;
        _fuwutiaokuanLbl.numberOfLines = 0;
        _fuwutiaokuanLbl.textAlignment = NSTextAlignmentLeft;
        _fuwutiaokuanLbl.font = [UIFont systemFontOfSize:13];
        //        _fuwutiaokuanLbl.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    }
    return _fuwutiaokuanLbl;
}

#pragma mark - event
-(void)kejianEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)registerEvent{
    
}

-(void)clickCheckEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mrak - TTTAttributedLabelDelegate
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    UserAgreementViewController *userAgreementVC = [[UserAgreementViewController alloc] init];
    userAgreementVC.url = url;
    [self.navigationController pushViewController:userAgreementVC animated:true];
}

@end
