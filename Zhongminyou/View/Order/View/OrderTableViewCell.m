//
//  OrderTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "OrderTableViewCell.h"

#define CellHeight FH(130)

@implementation OrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // showIv
    UIImageView *showIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(15), FH(10), CellHeight - FH(10) * 2, CellHeight - FH(10) * 2)];
    showIv.layer.masksToBounds = YES;
    showIv.layer.cornerRadius = 5;
    [showIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"158330"]];
    [self.contentView addSubview:showIv];
    
    // titleLbl
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(showIv.frame) + FW(10), CGRectGetMinY(showIv.frame) + FH(3), ScreenWidth - (CGRectGetMaxX(showIv.frame) + FW(10)), FH(21))];
    titleLbl.text = @"蒙山路加油站";
    [self.contentView addSubview:titleLbl];
    
    // orderIDLbl
    UILabel *orderIDLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(titleLbl.frame) + FH(3), ScreenWidth - CGRectGetMinX(titleLbl.frame), FH(12))];
    orderIDLbl.font = [UIFont systemFontOfSize:12];
    orderIDLbl.textColor = [UIColor grayColor];
    orderIDLbl.text = SWYNSStringFromFormat(@"订单编号：%@",@"1234567890");
    [self.contentView addSubview:orderIDLbl];
    
    // oilTypeLbl
    UILabel *oilTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(orderIDLbl.frame) + FH(3), CGRectGetWidth(orderIDLbl.frame), FH(12))];
    oilTypeLbl.font = [UIFont systemFontOfSize:12];
    oilTypeLbl.textColor = [UIColor grayColor];
    oilTypeLbl.text = SWYNSStringFromFormat(@"油品：%@          油号：%@",@"1234567890", @"93#");
    [self.contentView addSubview:oilTypeLbl];
    
    // jiayoujiIDLbl
    UILabel *jiayoujiIDLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(oilTypeLbl.frame) + FH(3), CGRectGetWidth(orderIDLbl.frame), FH(12))];
    jiayoujiIDLbl.font = [UIFont systemFontOfSize:12];
    jiayoujiIDLbl.textColor = [UIColor grayColor];
    jiayoujiIDLbl.text = SWYNSStringFromFormat(@"加油机编号：%@",@"14");
    [self.contentView addSubview:jiayoujiIDLbl];
    
    // orderTimeLbl
    UILabel *orderTimeLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLbl.frame), CGRectGetMaxY(jiayoujiIDLbl.frame) + FH(3), CGRectGetWidth(orderIDLbl.frame), FH(12))];
    orderTimeLbl.font = [UIFont systemFontOfSize:12];
    orderTimeLbl.textColor = [UIColor grayColor];
    orderTimeLbl.text = SWYNSStringFromFormat(@"订单时间：%@",@"2020-04-10 10:33:22");
    [self.contentView addSubview:orderTimeLbl];
    
    // moneyLbl
    NSString *moneyStr = SWYNSStringFromFormat(@"消费金额：%@",@"100");
    UIFont *moneyFont = [UIFont systemFontOfSize:13];
    CGFloat moneyWidth = [ToolKit getSizeWithString:moneyStr andFont:moneyFont].width + FW(5) * 2;
    UILabel *moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(orderTimeLbl.frame), CGRectGetMaxY(orderTimeLbl.frame) + FH(3), moneyWidth, FH(25))];
    moneyLbl.layer.masksToBounds = YES;
    moneyLbl.layer.cornerRadius = 6;
    moneyLbl.layer.borderWidth = 1;
    moneyLbl.layer.borderColor = ColorRGBA(200, 200, 200, 0.8).CGColor;
    moneyLbl.textAlignment = NSTextAlignmentCenter;
    moneyLbl.backgroundColor = [UIColor whiteColor];
    moneyLbl.textColor = TitleColor;
    moneyLbl.font = moneyFont;
    moneyLbl.text = moneyStr;
    [self.contentView addSubview:moneyLbl];
    
    // statusLbl
    UILabel *statusLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(moneyLbl.frame) + FW(20), CGRectGetMaxY(orderTimeLbl.frame) + FH(3), FW(60), FH(25))];
    statusLbl.layer.masksToBounds = YES;
    statusLbl.layer.cornerRadius = 6;
    statusLbl.layer.borderWidth = 1;
    statusLbl.textAlignment = NSTextAlignmentCenter;
    statusLbl.layer.borderColor = ColorRGBA(200, 200, 200, 0.8).CGColor;
    statusLbl.backgroundColor = [UIColor whiteColor];
    statusLbl.textColor = ColorRGB(200, 20, 20);
    statusLbl.font = moneyFont;
    statusLbl.text = @"未支付";
    [self.contentView addSubview:statusLbl];
    
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

@end
