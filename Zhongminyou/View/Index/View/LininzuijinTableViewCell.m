//
//  LininzuijinTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "LininzuijinTableViewCell.h"

#define CellHeight FH(110 + 70)

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
    UILabel *lininzuijinLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), FH(15), FW(60), FH(18))];
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
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lininzuijinLbl.frame) + FW(10), CGRectGetMinY(lininzuijinLbl.frame), FW(300), FH(18))];
    nameLbl.font = [UIFont systemFontOfSize:15];
    nameLbl.text = @"蒙山路加油站";
    [bgView addSubview:nameLbl];
    
    // moneyLbl
    NSString *priceStr = @"￥100";
    UIFont *priceFont = [UIFont systemFontOfSize:14];
    CGFloat priceWidth = [ToolKit getSizeWithString:priceStr andFont:priceFont].width;
    UILabel *moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(lininzuijinLbl.frame), CGRectGetMaxY(lininzuijinLbl.frame) + FH(10), priceWidth, FH(21))];
    moneyLbl.font = priceFont;
    moneyLbl.textColor = [UIColor redColor];
    moneyLbl.text = priceStr;
    [bgView addSubview:moneyLbl];
    
    // changeBgLeftLbl
    NSString *changeLeftStr = @"▾下降";
    UIFont *changeLeftFont = [UIFont systemFontOfSize:10];
    CGFloat changeLeftWidth = [ToolKit getSizeWithString:changeLeftStr andFont:changeLeftFont].width + FW(10);
    UILabel *changeBgLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(moneyLbl.frame) + FH(2), changeLeftWidth, FH(18))];
    changeBgLeftLbl.backgroundColor = [UIColor redColor];
    changeBgLeftLbl.font = [UIFont systemFontOfSize:10];
    changeBgLeftLbl.textColor = [UIColor whiteColor];
    changeBgLeftLbl.textAlignment = NSTextAlignmentCenter;
    changeBgLeftLbl.text = changeLeftStr;
    [bgView addSubview:changeBgLeftLbl];
    
    // changeBgRightLbl
    NSString *changeRightStr = @"3.4";
    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    UILabel *changeBgRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(moneyLbl.frame) + FH(2), changeRightWidth, FH(18))];
    changeBgRightLbl.layer.borderWidth = 1;
    changeBgRightLbl.layer.borderColor = [UIColor redColor].CGColor;
    changeBgRightLbl.backgroundColor = [UIColor whiteColor];
    changeBgRightLbl.font = [UIFont systemFontOfSize:10];
    changeBgRightLbl.textAlignment = NSTextAlignmentCenter;
    changeBgRightLbl.textColor = ColorRGB(100, 100, 100);
    changeBgRightLbl.text = changeRightStr;
    [bgView addSubview:changeBgRightLbl];
    
    // guobiaopriceLbl
    UILabel *guobiaopriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(changeBgRightLbl.frame), FW(150), FH(18))];
    guobiaopriceLbl.font = [UIFont systemFontOfSize:10];
    guobiaopriceLbl.textColor = [UIColor grayColor];
    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",@"4.12");
    [bgView addSubview:guobiaopriceLbl];
    
    // addressLbl
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(moneyLbl.frame) , CGRectGetMaxY(moneyLbl.frame) + FH(10), FW(300), FH(18))];
    addressLbl.font = [UIFont systemFontOfSize:10];
    addressLbl.textColor = [UIColor grayColor];
    addressLbl.text = @"山东省临沂市兰山区八一路304号";
    [bgView addSubview:addressLbl];
    
    // dingweiBtn
    UIButton *dingweiBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - FW(15+10+22), FH(30), FW(22), FW(22))];
    dingweiBtn.layer.masksToBounds = YES;
    dingweiBtn.layer.cornerRadius = FW(22) / 2;
    dingweiBtn.backgroundColor = [UIColor blueColor];
    [bgView addSubview:dingweiBtn];
    // dingweiIv
    UIImageView *dingweiIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(22-15) / 2, FW(22-15) / 2, FW(15), FW(15))];
    dingweiIv.contentMode = UIViewContentModeScaleAspectFit;
    dingweiIv.image = [UIImage imageNamed:@"dibiao"];
    [dingweiBtn addSubview:dingweiIv];
    // distanceLbl
    UILabel *distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - FW(15+10+22+10), CGRectGetMaxY(dingweiBtn.frame) + FH(10), FW(10+22+10), FH(18))];
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

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

#pragma mark - event
-(void)clickLijijiayouEvent{
    self.lijijiayouCallBack();
}

@end
