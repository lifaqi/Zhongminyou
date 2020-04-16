//
//  LininzuijinTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "LininzuijinTableViewCell.h"

#define CellHeight FH(110 + 70)

@interface LininzuijinTableViewCell(){
    // view
    UILabel *nameLbl;
    UILabel *moneyLbl;
    UILabel *changeBgRightLbl;
    UILabel *guobiaopriceLbl;
    UILabel *addressLbl;
    UILabel *distanceLbl;
    UILabel *changeBgLeftLbl;
}

@end

@implementation LininzuijinTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BackGroundColor;
        
        [self setUpUI];
    }
    return self;;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // bgView
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), 0, ScreenWidth - FW(15) * 2, CellHeight - FH(10))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self.contentView addSubview:bgView];
    
    // lininzuijinLbl
    UILabel *lininzuijinLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), FH(15), FW(70), FH(18))];
    lininzuijinLbl.layer.borderWidth = 1;
    lininzuijinLbl.layer.borderColor = ColorRGBA(200, 20, 20, 0.8).CGColor;
    lininzuijinLbl.layer.masksToBounds = YES;
    lininzuijinLbl.layer.cornerRadius = 2;
    lininzuijinLbl.textAlignment = NSTextAlignmentCenter;
    lininzuijinLbl.font = [UIFont systemFontOfSize:12];
    lininzuijinLbl.textColor = [UIColor grayColor];
    lininzuijinLbl.text = @"离您最近";
    [bgView addSubview:lininzuijinLbl];
    
    // nameLbl
    nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lininzuijinLbl.frame) + FW(10), CGRectGetMinY(lininzuijinLbl.frame), FW(300), FH(18))];
    nameLbl.font = [UIFont systemFontOfSize:15];
    nameLbl.text = @"蒙山路加油站";
    [bgView addSubview:nameLbl];
    
    // moneyLbl
    moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lininzuijinLbl.frame), CGRectGetMaxY(lininzuijinLbl.frame) + FH(10), 0, FH(21))];
    moneyLbl.font = [UIFont systemFontOfSize:14];
    moneyLbl.textColor = [UIColor redColor];
    [bgView addSubview:moneyLbl];
    
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
    [bgView addSubview:changeBgLeftLbl];
    
    // changeBgRightLbl
    changeBgRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(moneyLbl.frame) + FH(2), 0, FH(18))];
    changeBgRightLbl.layer.borderWidth = 1;
    changeBgRightLbl.layer.borderColor = [UIColor redColor].CGColor;
    changeBgRightLbl.backgroundColor = [UIColor whiteColor];
    changeBgRightLbl.font = [UIFont systemFontOfSize:10];
    changeBgRightLbl.textAlignment = NSTextAlignmentCenter;
    changeBgRightLbl.textColor = ColorRGB(100, 100, 100);
    [bgView addSubview:changeBgRightLbl];
    
    // guobiaopriceLbl
    guobiaopriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(changeBgRightLbl.frame), FW(150), FH(18))];
    guobiaopriceLbl.font = [UIFont systemFontOfSize:10];
    guobiaopriceLbl.textColor = [UIColor grayColor];
//    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",@"4.12");
    [bgView addSubview:guobiaopriceLbl];
    
    // addressLbl
    addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(moneyLbl.frame) , CGRectGetMaxY(moneyLbl.frame) + FH(10), FW(300), FH(18))];
    addressLbl.font = [UIFont systemFontOfSize:10];
    addressLbl.textColor = [UIColor grayColor];
//    addressLbl.text = @"山东省临沂市兰山区八一路304号";
    [bgView addSubview:addressLbl];
    
    // dingweiBtn
    UIButton *dingweiBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - FW(15+10+22), FH(30), FW(22), FW(22))];
    dingweiBtn.layer.masksToBounds = YES;
    dingweiBtn.layer.cornerRadius = FW(22) / 2;
    dingweiBtn.backgroundColor = [UIColor blueColor];
    [dingweiBtn addTarget:self action:@selector(clickDingweiEvent) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:dingweiBtn];
    // dingweiIv
    UIImageView *dingweiIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(22-15) / 2, FW(22-15) / 2, FW(15), FW(15))];
    dingweiIv.contentMode = UIViewContentModeScaleAspectFit;
    dingweiIv.image = [UIImage imageNamed:@"dibiao"];
    [dingweiBtn addSubview:dingweiIv];
    // distanceLbl
    distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - FW(15+10+22+10), CGRectGetMaxY(dingweiBtn.frame) + FH(10), FW(10+22+10), FH(18))];
    distanceLbl.textAlignment = NSTextAlignmentCenter;
    distanceLbl.font = [UIFont systemFontOfSize:10];
    distanceLbl.textColor = [UIColor grayColor];
    distanceLbl.text = @"0.06km";
    [bgView addSubview:distanceLbl];
    
    // lijijiayouBtn
    UIButton *lijijiayouBtn = [[UIButton alloc] initWithFrame:CGRectMake(FW(20), CGRectGetMaxY(distanceLbl.frame) + FH(20), CGRectGetWidth(bgView.frame) - FW(20) * 2, FH(40))];
    lijijiayouBtn.layer.masksToBounds = YES;
    lijijiayouBtn.layer.cornerRadius = CGRectGetHeight(lijijiayouBtn.frame) / 2;
    lijijiayouBtn.backgroundColor = ColorRGB(43, 123, 246);
    [lijijiayouBtn setTitle:@"立即加油" forState:UIControlStateNormal];
    [lijijiayouBtn addTarget:self action:@selector(clickLijijiayouEvent) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:lijijiayouBtn];
}

#pragma mark - property
-(void)setGasDict:(NSDictionary *)gasDict{
    nameLbl.text = gasDict[@"staticName"];
    
    // moneyLbl
    NSString *moneyStr = [ToolKit dealWithString:gasDict[@"machinePrice"]];
    moneyStr = moneyStr == nil ? @"0" : moneyStr;
    CGFloat priceWidth = [ToolKit getSizeWithString:SWYNSStringFromFormat(@"￥%@",moneyStr) andFont:[UIFont systemFontOfSize:14]].width + FW(5);
    moneyLbl.frame = CGRectMake(CGRectGetMinX(moneyLbl.frame), CGRectGetMinY(moneyLbl.frame), priceWidth, moneyLbl.frame.size.height);
    moneyLbl.text = SWYNSStringFromFormat(@"￥%@",moneyStr);
    
    // changeBgLeftLbl
    changeBgLeftLbl.frame = CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(changeBgLeftLbl.frame), changeBgLeftLbl.frame.size.width, changeBgLeftLbl.frame.size.height);
    
    // changeBgRightLbl
    NSString *changeRightStr = [ToolKit dealWithString:gasDict[@"cutPrice"]];
    changeRightStr = changeRightStr == nil ? @"0" : changeRightStr;
    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    changeBgRightLbl.frame = CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(changeBgRightLbl.frame), changeRightWidth, changeBgRightLbl.frame.size.height);
    changeBgRightLbl.text = changeRightStr;
    
    // guobiaopriceLbl
    guobiaopriceLbl.frame = CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(guobiaopriceLbl.frame), guobiaopriceLbl.frame.size.width, guobiaopriceLbl.frame.size.height);
    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",gasDict == nil ? @"0" : gasDict[@"internationalPrice"]);
    
    addressLbl.text = gasDict[@"staticAddress"];
    
    distanceLbl.text = SWYNSStringFromFormat(@"%.2fkm",[gasDict[@"range"] floatValue]);
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

#pragma mark - event
-(void)clickLijijiayouEvent{
    self.lijijiayouCallBack();
}

-(void)clickDingweiEvent{
    self.dingweiCallBack([_gasDict[@"staticLng"] floatValue], [_gasDict[@"staticLat"] floatValue], _gasDict[@"staticName"]);
}

@end
