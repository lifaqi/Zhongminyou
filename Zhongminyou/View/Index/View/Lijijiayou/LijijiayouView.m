//
//  LijijiayouView.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "LijijiayouView.h"

#define itemWidth FW(70)

@interface LijijiayouView(){
    // view
    UIButton *bgBtn;
    UIView *showView;
    UIView *allYouhaoView;
    UIButton *preYoupinBtn;
    UIButton *preYouhaoBtn;
    UILabel *titleLbl;
    UILabel *moneyLbl;
    UILabel *addressLbl;
    UILabel *distanceLbl;
    UILabel *changeBgLeftLbl;
    UILabel *changeBgRightLbl;
    UILabel *guobiaopriceLbl;
    UIView *bottonAmountView;
    UIView *allYoupinView;
    UITextField *amountTf;
    
    // data
    NSArray *allYoupinArray;
    NSArray *allQiYouYouhaoArray;
    NSArray *allChaiYouYouhaoArray;
    NSArray *allYouhaoArray;
    NSInteger selectYoupinIndex;
    NSInteger selectYouhaoIndex;
}

@end

@implementation LijijiayouView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setData];
        [self setUpUI];
    }
    return self;
}

#pragma mark - setData
-(void)setData{
    allYoupinArray = @[@"汽油", @"柴油"];
    
    selectYoupinIndex = 0;
    selectYouhaoIndex = 0;
    
//    allYouhaoArray = allQiYouYouhaoArray = @[@"92#", @"93#", @"95#", @"97#", @"98#"];
//    allChaiYouYouhaoArray = @[@"-10#", @"-20#"];
}

#pragma mark - setUpUI
-(void)setUpUI{
    // bgView
    bgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height)];
    bgBtn.backgroundColor = ColorRGB(100, 100, 100);
    [bgBtn addTarget:self action:@selector(clickBgEvent) forControlEvents:UIControlEventTouchUpInside];
    bgBtn.alpha = 0;
    [self addSubview:bgBtn];
    
    // showView
    CGFloat showViewHeight = bgBtn.frame.size.height * 0.65;
    showView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, showViewHeight + 20)];
    showView.layer.masksToBounds = YES;
    showView.layer.cornerRadius = 20;
    showView.backgroundColor = [UIColor whiteColor];
    showView.alpha = 0;
    [self addSubview:showView];
    
    // showIv
    UIImageView *showIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(15), FH(20), FH(90), FH(90))];
    showIv.layer.masksToBounds = YES;
    showIv.layer.cornerRadius = 5;
    [showIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"158330"]];
    [showView addSubview:showIv];
    // titleLbl
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showIv.frame) + FW(5), CGRectGetMinY(showIv.frame) + FH(5), ScreenWidth - (CGRectGetMaxX(showIv.frame) + FW(5) + FW(15+60+15)), FH(21))];
    titleLbl.text = @"蒙山路加油站";
    [showView addSubview:titleLbl];
    // moneyLbl
    NSString *priceStr = @"￥0";
    UIFont *priceFont = [UIFont systemFontOfSize:14];
    CGFloat priceWidth = [ToolKit getSizeWithString:priceStr andFont:priceFont].width;
    moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(titleLbl.frame) + FH(10), priceWidth, FH(21))];
    moneyLbl.font = priceFont;
    moneyLbl.textColor = [UIColor redColor];
    moneyLbl.text = priceStr;
    [showView addSubview:moneyLbl];
    // changeBgLeftLbl
    NSString *changeLeftStr = @"▾下降";
    UIFont *changeLeftFont = [UIFont systemFontOfSize:10];
    CGFloat changeLeftWidth = [ToolKit getSizeWithString:changeLeftStr andFont:changeLeftFont].width + FW(10);
    changeBgLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(moneyLbl.frame) + FH(2), changeLeftWidth, FH(18))];
    changeBgLeftLbl.backgroundColor = [UIColor redColor];
    changeBgLeftLbl.font = [UIFont systemFontOfSize:10];
    changeBgLeftLbl.textColor = [UIColor whiteColor];
    changeBgLeftLbl.textAlignment = NSTextAlignmentCenter;
    changeBgLeftLbl.text = changeLeftStr;
    [showView addSubview:changeBgLeftLbl];
    // changeBgRightLbl
    NSString *changeRightStr = @"0";
    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    changeBgRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(moneyLbl.frame) + FH(2), changeRightWidth, FH(18))];
    changeBgRightLbl.layer.borderWidth = 1;
    changeBgRightLbl.layer.borderColor = [UIColor redColor].CGColor;
    changeBgRightLbl.backgroundColor = [UIColor whiteColor];
    changeBgRightLbl.font = [UIFont systemFontOfSize:10];
    changeBgRightLbl.textAlignment = NSTextAlignmentCenter;
    changeBgRightLbl.textColor = ColorRGB(100, 100, 100);
    changeBgRightLbl.text = changeRightStr;
    [showView addSubview:changeBgRightLbl];
    // guobiaopriceLbl
    guobiaopriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(changeBgRightLbl.frame), FW(150), FH(18))];
    guobiaopriceLbl.font = [UIFont systemFontOfSize:10];
    guobiaopriceLbl.textColor = [UIColor grayColor];
//    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",@"0");
    [showView addSubview:guobiaopriceLbl];
    // addressLbl
    addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(moneyLbl.frame) + FW(2.5), CGRectGetMaxY(moneyLbl.frame) + FH(10), ScreenWidth - (CGRectGetMinX(moneyLbl.frame) + FW(2.5 + 60)), FH(30))];
    addressLbl.numberOfLines = 2;
    addressLbl.font = [UIFont systemFontOfSize:10];
    addressLbl.textColor = [UIColor grayColor];
    [showView addSubview:addressLbl];
    // dingweiBtn
    UIButton *dingweiBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+10+22), FH(40), FW(22), FW(22))];
    dingweiBtn.layer.masksToBounds = YES;
    dingweiBtn.layer.cornerRadius = FW(22) / 2;
    dingweiBtn.backgroundColor = [UIColor blueColor];
    [dingweiBtn addTarget:self action:@selector(clickDingweiEvent) forControlEvents:UIControlEventTouchUpInside];
    [showView addSubview:dingweiBtn];
    // dingweiIv
    UIImageView *dingweiIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(22-15) / 2, FW(22-15) / 2, FW(15), FW(15))];
    dingweiIv.contentMode = UIViewContentModeScaleAspectFit;
    dingweiIv.image = [UIImage imageNamed:@"dibiao"];
    [dingweiBtn addSubview:dingweiIv];
    // distanceLbl
    distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+10+22+10), CGRectGetMaxY(dingweiBtn.frame) + FH(10), FW(10+22+10), FH(18))];
    distanceLbl.textAlignment = NSTextAlignmentCenter;
    distanceLbl.font = [UIFont systemFontOfSize:10];
    distanceLbl.textColor = [UIColor grayColor];
    [showView addSubview:distanceLbl];
    
    // allYoupinTitleLbl
    UILabel *allYoupinTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(showIv.frame) + FH(20), FW(100), FH(21))];
    allYoupinTitleLbl.font = [UIFont systemFontOfSize:15];
    allYoupinTitleLbl.text = @"全部油品";
    [showView addSubview:allYoupinTitleLbl];
    
    // allYoupinView
    allYoupinView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(allYoupinTitleLbl.frame) + FH(15), showView.frame.size.width - FW(15) * 2, FH(30))];
    [showView addSubview:allYoupinView];
    
    [self initYoupinView];
    
    // allYouhaoTitleLbl
    UILabel *allYouhaoTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(allYoupinView.frame) + FH(15), FW(100), FH(21))];
    allYouhaoTitleLbl.font = [UIFont systemFontOfSize:15];
    allYouhaoTitleLbl.text = @"全部油号";
    [showView addSubview:allYouhaoTitleLbl];
    
    // allYouhaoView
    allYouhaoView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(allYouhaoTitleLbl.frame) + FH(15), showView.frame.size.width - FW(15) * 2, 0)];
    [showView addSubview:allYouhaoView];
    
    [self initYouhaoView];
    
    // bottonAmountView
    bottonAmountView = [[UIView alloc] initWithFrame:CGRectMake(FW(30), CGRectGetMaxY(allYouhaoView.frame) + FH(25), ScreenWidth, FH(30+25+40))];
    [showView addSubview:bottonAmountView];
    
    // amountLbl
    UILabel *amountLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, FW(60), FH(20))];
    amountLbl.font = [UIFont systemFontOfSize:14];
    amountLbl.text = @"加油金额";
    [bottonAmountView addSubview:amountLbl];
    // amountTf
    amountTf = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(amountLbl.frame) + FW(5), 0, FW(150), FH(30))];
    amountTf.layer.borderWidth = 1;
    amountTf.layer.borderColor = ColorRGBA(200, 200, 200, 0.5).CGColor;
    amountTf.leftPadding = FH(8);
    amountTf.font = [UIFont systemFontOfSize:14];
    amountTf.keyboardType = UIKeyboardTypeNumberPad;
    amountTf.placeholder = @"请输入消费金额";
    [bottonAmountView addSubview:amountTf];
    
    // lijiPayBtn
    UIButton *lijiPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(amountTf.frame) + FH(25), ScreenWidth - FW(30) * 2, FH(40))];
    lijiPayBtn.layer.masksToBounds = YES;
    lijiPayBtn.layer.cornerRadius = lijiPayBtn.frame.size.height / 2;
    lijiPayBtn.backgroundColor = ColorRGB(43, 123, 246);
    [lijiPayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [lijiPayBtn addTarget:self action:@selector(clickLijiPayEvent) forControlEvents:UIControlEventTouchUpInside];
    [bottonAmountView addSubview:lijiPayBtn];
}

-(void)initYoupinView{
    // 先清空以前的控件
    for (UIView *itemView in allYoupinView.subviews) {
        [itemView removeFromSuperview];
    }
    // youpinBtn
    for (int i = 0; i < allYoupinArray.count; i++) {
        UIButton *youpinBtn = [[UIButton alloc] initWithFrame:CGRectMake((itemWidth + FW(15)) * i, 0, itemWidth, FH(30))];
        youpinBtn.layer.borderWidth = 1;
        youpinBtn.layer.borderColor = [UIColor blackColor].CGColor;
        youpinBtn.layer.masksToBounds = YES;
        youpinBtn.layer.cornerRadius = 6;
        youpinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        youpinBtn.backgroundColor = [UIColor whiteColor];
        [youpinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [youpinBtn setTitle:allYoupinArray[i] forState:UIControlStateNormal];
        youpinBtn.tag = i;
        [youpinBtn addTarget:self action:@selector(clickYoupinEvent:) forControlEvents:UIControlEventTouchUpInside];
        [allYoupinView addSubview:youpinBtn];
        
        if (i == selectYoupinIndex) {
            youpinBtn.backgroundColor = [UIColor blackColor];
            [youpinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            youpinBtn.selected = YES;
            preYoupinBtn = youpinBtn;
        }
    }
}

-(void)initYouhaoView{
    // 先清空以前的控件
    for (UIView *itemView in allYouhaoView.subviews) {
        [itemView removeFromSuperview];
    }
    
    CGFloat leftX = 0;
    CGFloat topY = 0;
    if (allYouhaoArray.count == 0) {
        selectYouhaoIndex = -1;
        UIButton *youhaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftX, topY, FW(100), FH(30))];
        youhaoBtn.layer.borderWidth = 1;
        youhaoBtn.layer.borderColor = [UIColor blackColor].CGColor;
        youhaoBtn.layer.masksToBounds = YES;
        youhaoBtn.layer.cornerRadius = 6;
        youhaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        youhaoBtn.backgroundColor = [UIColor whiteColor];
        [youhaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [youhaoBtn setTitle:selectYoupinIndex == 0 ? @"暂无汽油信息" : @"暂无柴油信息" forState:UIControlStateNormal];
        [allYouhaoView addSubview:youhaoBtn];
    }else{
        for (int i = 0; i < allYouhaoArray.count; i++) {
            if (leftX + itemWidth > allYouhaoView.frame.size.width) {
                leftX = 0;
                topY = FH(30+15);
            }
            
            UIButton *youhaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftX, topY, itemWidth, FH(30))];
            youhaoBtn.layer.borderWidth = 1;
            youhaoBtn.layer.borderColor = [UIColor blackColor].CGColor;
            youhaoBtn.layer.masksToBounds = YES;
            youhaoBtn.layer.cornerRadius = 6;
            youhaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            youhaoBtn.backgroundColor = [UIColor whiteColor];
            [youhaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            youhaoBtn.tag = i;
            [youhaoBtn setTitle:allYouhaoArray[i][@"nozzleOils"] forState:UIControlStateNormal];
            [youhaoBtn addTarget:self action:@selector(clickYouhaoEvent:) forControlEvents:UIControlEventTouchUpInside];
            [allYouhaoView addSubview:youhaoBtn];
            
            if (i == selectYouhaoIndex) {
                youhaoBtn.backgroundColor = [UIColor blackColor];
                [youhaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                youhaoBtn.selected = YES;
                preYouhaoBtn = youhaoBtn;
            }
            
            leftX = leftX + itemWidth + FW(15);
        }
    }
    
    allYouhaoView.frame = CGRectMake(CGRectGetMinX(allYouhaoView.frame), CGRectGetMinY(allYouhaoView.frame), allYouhaoView.frame.size.width, topY + FH(30));
    
    bottonAmountView.frame = CGRectMake(CGRectGetMinX(bottonAmountView.frame), CGRectGetMaxY(allYouhaoView.frame) + FH(25), bottonAmountView.frame.size.width, bottonAmountView.frame.size.height);
    
    if (selectYouhaoIndex != -1) {
        [self updatePrice];
    }
}

-(void)updatePrice{
    // moneyLbl
    NSString *moneyStr = [ToolKit dealWithString:allYouhaoArray[selectYouhaoIndex][@"oilsPrice"]];
    moneyStr = moneyStr == nil ? @"0" : moneyStr;
    CGFloat priceWidth = [ToolKit getSizeWithString:SWYNSStringFromFormat(@"￥%@",moneyStr) andFont:[UIFont systemFontOfSize:14]].width + FW(10);
    moneyLbl.frame = CGRectMake(CGRectGetMinX(moneyLbl.frame), CGRectGetMinY(moneyLbl.frame), priceWidth, moneyLbl.frame.size.height);
    moneyLbl.text = SWYNSStringFromFormat(@"￥%@",moneyStr);
    
    // changeBgLeftLbl
    changeBgLeftLbl.frame = CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(changeBgLeftLbl.frame), changeBgLeftLbl.frame.size.width, changeBgLeftLbl.frame.size.height);
    
    // changeBgRightLbl
    NSString *changeRightStr = [ToolKit dealWithString:allYouhaoArray[selectYouhaoIndex][@"total"]];
    changeRightStr = changeRightStr == nil ? @"0" : changeRightStr;
    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    changeBgRightLbl.frame = CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(changeBgRightLbl.frame), changeRightWidth, changeBgRightLbl.frame.size.height);
    changeBgRightLbl.text = changeRightStr;
    
    // guobiaopriceLbl
    guobiaopriceLbl.frame = CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(guobiaopriceLbl.frame), guobiaopriceLbl.frame.size.width, guobiaopriceLbl.frame.size.height);
    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",allYouhaoArray == nil ? @"0" : allYouhaoArray[selectYouhaoIndex][@"internationalPrice"]);
}

#pragma mark - property
-(void)setGasDict:(NSDictionary *)gasDict{
    _gasDict = gasDict;
    // titleLbl
    titleLbl.text = gasDict[@"staticName"];
    // addressLbl
    addressLbl.text = gasDict[@"staticAddress"];
    // distanceLbl
    distanceLbl.text = _distance;
    
    allQiYouYouhaoArray = gasDict[@"fillingOilVo"][@"gasoline"];
    allChaiYouYouhaoArray = gasDict[@"fillingOilVo"][@"dieselOil"];
    
    NSArray *youhaoIDArray = [allQiYouYouhaoArray valueForKey:@"nozzleOils"];
    NSInteger index = [youhaoIDArray indexOfObject:_youhao];
    if (index == NSNotFound) {
        youhaoIDArray = [allChaiYouYouhaoArray valueForKey:@"nozzleOils"];
        index = [youhaoIDArray indexOfObject:_youhao];
        if (index != NSNotFound) {
            selectYoupinIndex = 1;
        }
    }else{
        selectYoupinIndex = 0;
    }
    
    if (index != NSNotFound) {
        selectYouhaoIndex = index;
    }
    
    if (selectYouhaoIndex != -1) {
        allYouhaoArray = selectYoupinIndex == 0 ? allQiYouYouhaoArray : allChaiYouYouhaoArray;
        [self initYoupinView];
        
        [self updatePrice];
    }
        
    [self initYouhaoView];
    
    
}

#pragma mark - func
-(void)show{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->bgBtn.alpha = 0.5;
        self->showView.alpha = 1;
        self->showView.frame = CGRectMake(0, self->bgBtn.frame.size.height * 0.35, self->showView.frame.size.width, self->showView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hidden{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->bgBtn.alpha = 0;
        self->showView.alpha = 0;
        self->showView.frame = CGRectMake(0, ScreenHeight, self->showView.frame.size.width, self->showView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    [self removeFromSuperview];
}

#pragma mark - event
-(void)clickYoupinEvent:(UIButton *)sender{
    if (preYoupinBtn != nil) {
        preYoupinBtn.backgroundColor = [UIColor whiteColor];
        [preYoupinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    preYoupinBtn = sender;
    preYoupinBtn.selected = NO;
    sender.selected = !sender.selected;
    selectYoupinIndex = sender.tag;
    if (sender.selected) {
        sender.backgroundColor = [UIColor blackColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    allYouhaoArray = selectYoupinIndex == 0 ? allQiYouYouhaoArray : allChaiYouYouhaoArray;
    
    selectYouhaoIndex = 0;
    [self initYouhaoView];
}

-(void)clickYouhaoEvent:(UIButton *)sender{
    if (preYouhaoBtn != nil) {
        preYouhaoBtn.backgroundColor = [UIColor whiteColor];
        [preYouhaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    preYouhaoBtn = sender;
    preYouhaoBtn.selected = NO;
    sender.selected = !sender.selected;
    selectYouhaoIndex = sender.tag;
    if (sender.selected) {
        sender.backgroundColor = [UIColor blackColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sender.backgroundColor = [UIColor whiteColor];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [self updatePrice];
}

-(void)clickBgEvent{
    [self hidden];
}

-(void)clickLijiPayEvent{
    if (selectYouhaoIndex == -1) {
        [ToolKit showErrorWithStatus:@"请选择油号"];
        return;
    }
    
    NSString *totalValue = [ToolKit dealWithString:amountTf.text];
    if ([totalValue isEqualToString:@""]) {
        [ToolKit showErrorWithStatus:@"请输入加油金额"];
        return;
    }
    
    [self hidden];
    
    self.lijiPayCallBack(_gasDict, allYoupinArray[selectYoupinIndex], allYouhaoArray[selectYouhaoIndex][@"nozzleOils"], totalValue, [ToolKit dealWithString:allYouhaoArray[selectYouhaoIndex][@"oilsPrice"]], [ToolKit dealWithString:allYouhaoArray[selectYouhaoIndex][@"machineCode"]], [ToolKit dealWithString:allYouhaoArray[selectYouhaoIndex][@"nozzleCode"]]);
}

-(void)clickDingweiEvent{
    self.dingweiCallBack([_gasDict[@"staticLng"] floatValue], [_gasDict[@"staticLat"] floatValue], _gasDict[@"staticName"]);
}

@end
