//
//  RecommendItemTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import "RecommendItemTableViewCell.h"

#define CellHeight FH(100)

@interface RecommendItemTableViewCell(){
    UIImageView *showIv;
    UILabel *titleLbl;
    UILabel *moneyLbl;
    UILabel *changeBgLeftLbl;
    UILabel *changeBgRightLbl;
    UILabel *guobiaopriceLbl;
    UILabel *addressLbl;
    UILabel *distanceLbl;
}

@end

@implementation RecommendItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // showIv
    showIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(15), FH(5), CellHeight - FH(5) * 2, CellHeight - FH(5) * 2)];
    showIv.layer.masksToBounds = YES;
    showIv.layer.cornerRadius = 5;
    [showIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"158330"]];
    [self.contentView addSubview:showIv];
    // titleLbl
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showIv.frame) + FW(5), CGRectGetMinY(showIv.frame) + FH(5), ScreenWidth - (CGRectGetMaxX(showIv.frame) + FW(5) + FW(50)), FH(21))];
    titleLbl.font = [UIFont systemFontOfSize:15];
    titleLbl.numberOfLines = 2;
//    titleLbl.text = @"蒙山路加油站";
    [self.contentView addSubview:titleLbl];
    // moneyLbl
//    NSString *priceStr = @"￥100";
    UIFont *priceFont = [UIFont systemFontOfSize:14];
//    CGFloat priceWidth = [ToolKit getSizeWithString:priceStr andFont:priceFont].width;
    moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(titleLbl.frame) + FH(10), 0, FH(21))];
    moneyLbl.font = priceFont;
    moneyLbl.textColor = [UIColor redColor];
//    moneyLbl.text = priceStr;
    [self.contentView addSubview:moneyLbl];
    // changeBgLeftLbl
//    NSString *changeLeftStr = @"▾下降";
    UIFont *changeLeftFont = [UIFont systemFontOfSize:10];
    //    CGFloat priceWidth = [ToolKit getSizeWithString:changeLeftStr andFont:changeLeftFont].width + FW(10);
    changeBgLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(moneyLbl.frame) + FH(2), FW(30), FH(18))];
    changeBgLeftLbl.hidden = YES;
    changeBgLeftLbl.backgroundColor = [UIColor redColor];
    changeBgLeftLbl.font = changeLeftFont;
    changeBgLeftLbl.textColor = [UIColor whiteColor];
    changeBgLeftLbl.textAlignment = NSTextAlignmentCenter;
//    changeBgLeftLbl.text = changeLeftStr;
    [self.contentView addSubview:changeBgLeftLbl];
    // changeBgRightLbl
//    NSString *changeRightStr = @"3.4";
//    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
//    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    changeBgRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(moneyLbl.frame) + FH(2), 0, FH(18))];
    changeBgRightLbl.layer.borderWidth = 1;
    changeBgRightLbl.layer.borderColor = [UIColor redColor].CGColor;
    changeBgRightLbl.backgroundColor = [UIColor whiteColor];
    changeBgRightLbl.font = [UIFont systemFontOfSize:10];
    changeBgRightLbl.textAlignment = NSTextAlignmentCenter;
    changeBgRightLbl.textColor = ColorRGB(100, 100, 100);
//    changeBgRightLbl.text = changeRightStr;
    [self.contentView addSubview:changeBgRightLbl];
    // guobiaopriceLbl
    guobiaopriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(changeBgRightLbl.frame), FW(150), FH(18))];
    guobiaopriceLbl.font = [UIFont systemFontOfSize:10];
    guobiaopriceLbl.textColor = [UIColor grayColor];
//    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",@"4.12");
    [self.contentView addSubview:guobiaopriceLbl];
    // addressLbl
    addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(moneyLbl.frame) + FW(2.5), CGRectGetMaxY(moneyLbl.frame) + FH(10), ScreenWidth - (CGRectGetMinX(moneyLbl.frame) + FW(2.5) + FW(50)), FH(18))];
    addressLbl.font = [UIFont systemFontOfSize:10];
    addressLbl.textColor = [UIColor grayColor];
//    addressLbl.text = @"山东省临沂市兰山区八一路304号";
    [self.contentView addSubview:addressLbl];
    // dingweiBtn
    UIButton *dingweiBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+10+22), FH(30), FW(25), FW(25))];
    dingweiBtn.layer.masksToBounds = YES;
    dingweiBtn.layer.cornerRadius = FW(25) / 2;
    dingweiBtn.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:dingweiBtn];
    // dingweiIv
    UIImageView *dingweiIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(25-15) / 2, FW(25-15) / 2, FW(15), FW(15))];
    dingweiIv.contentMode = UIViewContentModeScaleAspectFit;
    dingweiIv.image = [UIImage imageNamed:@"dibiao"];
    [dingweiBtn addSubview:dingweiIv];
    // distanceLbl
    distanceLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+10+30+10), CGRectGetMaxY(dingweiBtn.frame) + FH(10), FW(10+30+10), FH(18))];
    distanceLbl.textAlignment = NSTextAlignmentCenter;
    distanceLbl.font = [UIFont systemFontOfSize:10];
    distanceLbl.textColor = [UIColor grayColor];
//    distanceLbl.text = @"0.06km";
    [self.contentView addSubview:distanceLbl];
    // dingweiBgBtn
    UIButton *dingweiBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(dingweiBtn.frame) - FW(5), CGRectGetMinY(dingweiBtn.frame) - FH(5), dingweiBtn.frame.size.width + FW(50), FH(50))];
    [dingweiBgBtn addTarget:self action:@selector(clickDingweiEvent)];
    [self.contentView addSubview:dingweiBgBtn];
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

- (void)setGasDataDict:(NSDictionary *)gasDataDict{
    _gasDataDict = gasDataDict;
//    [showIv sd_setImageWithURL:[NSURL URLWithString:gasDataDict[@""]] placeholderImage:[UIImage imageNamed:@"158330"]];
    
    // titleLbl
    CGFloat titleHeight = [ToolKit getHeightWithString:gasDataDict[@"staticName"] fontSize:15 width:titleLbl.frame.size.width];
    titleLbl.frame = CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMinY(titleLbl.frame), titleLbl.frame.size.width, titleHeight);
    titleLbl.text = gasDataDict[@"staticName"];
    
    addressLbl.text = gasDataDict[@"staticAddress"];
    
    distanceLbl.text = SWYNSStringFromFormat(@"%.2fkm",[gasDataDict[@"range"] floatValue]);
    
    if (![[ToolKit dealWithString:gasDataDict[@"machinePrice"]] isEqualToString:@""]) {
        [self updatePrice];
    }
}

-(void)updatePrice{
    // moneyLbl
    NSString *moneyStr = [ToolKit dealWithString:_gasDataDict[@"machinePrice"]];
    moneyStr = moneyStr == nil ? @"0" : moneyStr;
    CGFloat priceWidth = [ToolKit getSizeWithString:SWYNSStringFromFormat(@"￥%@",moneyStr) andFont:[UIFont systemFontOfSize:14]].width + FW(5);
    moneyLbl.frame = CGRectMake(CGRectGetMinX(moneyLbl.frame), CGRectGetMinY(moneyLbl.frame), priceWidth, moneyLbl.frame.size.height);
    moneyLbl.text = SWYNSStringFromFormat(@"￥%@",moneyStr);
    
    // changeBgLeftLbl
    changeBgLeftLbl.hidden = NO;
    changeBgLeftLbl.text = @"▾下降";
    changeBgLeftLbl.frame = CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(5), CGRectGetMinY(changeBgLeftLbl.frame), changeBgLeftLbl.frame.size.width, changeBgLeftLbl.frame.size.height);
    
    // changeBgRightLbl
    NSString *changeRightStr = [ToolKit dealWithString:_gasDataDict[@"cutPrice"]];
    changeRightStr = changeRightStr == nil ? @"0" : changeRightStr;
    UIFont *changeRightFont = [UIFont systemFontOfSize:10];
    CGFloat changeRightWidth = [ToolKit getSizeWithString:changeRightStr andFont:changeRightFont].width + FW(10);
    changeBgRightLbl.frame = CGRectMake(CGRectGetMaxX(changeBgLeftLbl.frame), CGRectGetMinY(changeBgRightLbl.frame), changeRightWidth, changeBgRightLbl.frame.size.height);
    changeBgRightLbl.text = changeRightStr;
    
    // guobiaopriceLbl
    guobiaopriceLbl.frame = CGRectMake(CGRectGetMaxX(changeBgRightLbl.frame) + FW(5), CGRectGetMinY(guobiaopriceLbl.frame), guobiaopriceLbl.frame.size.width, guobiaopriceLbl.frame.size.height);
    guobiaopriceLbl.text = SWYNSStringFromFormat(@"国标价￥%@",_gasDataDict == nil ? @"0" : _gasDataDict[@"internationalPrice"]);
}

#pragma mark - event
-(void)clickDingweiEvent{
    self.dingweiCallBack([_gasDataDict[@"staticLng"] floatValue], [_gasDataDict[@"staticLat"] floatValue], _gasDataDict[@"staticName"]);
}

@end
