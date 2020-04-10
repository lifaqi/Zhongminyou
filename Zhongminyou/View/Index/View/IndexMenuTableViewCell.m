//
//  IndexMenuTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/8.
//

#import "IndexMenuTableViewCell.h"

@implementation IndexMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BackGroundColor;
    }
    return self;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // bgView
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), 0, ScreenWidth - FW(15) * 2, FH(120))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self.contentView addSubview:bgView];
    
    // 计算宽度和高度
    CGFloat itemWidth = CGRectGetWidth(bgView.frame) / 4;
    CGFloat imageWidth = CGRectGetHeight(bgView.frame) / 1.3;
    UIFont *titleFont = [UIFont systemFontOfSize:13];
    
    // myCarBtn
    CustomButton *myCarBtn = [[CustomButton alloc] initWithFrame:CGRectMake((itemWidth - imageWidth) / 2, FH(20), imageWidth, imageWidth)];
    myCarBtn.titleLabel.font = titleFont;
    [myCarBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [myCarBtn setImage:[UIImage imageNamed:@"wodac"] forState:UIControlStateNormal];
    [myCarBtn setTitle:@"我的爱车" forState:UIControlStateNormal];
    [bgView addSubview:myCarBtn];
    
    // baoyangmeirongBtn
    CustomButton *baoyangmeirongBtn = [[CustomButton alloc] initWithFrame:CGRectMake(itemWidth + (itemWidth - imageWidth) / 2, FH(20), imageWidth, imageWidth)];
    baoyangmeirongBtn.titleLabel.font = titleFont;
    [baoyangmeirongBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [baoyangmeirongBtn setImage:[UIImage imageNamed:@"wodad"] forState:UIControlStateNormal];
    [baoyangmeirongBtn setTitle:@"保养美容" forState:UIControlStateNormal];
    [bgView addSubview:baoyangmeirongBtn];
    
    // myCarBtn
    CustomButton *myCarBtn2 = [[CustomButton alloc] initWithFrame:CGRectMake(itemWidth * 2 + (itemWidth - imageWidth) / 2, FH(20), imageWidth, imageWidth)];
    myCarBtn2.titleLabel.font = titleFont;
    [myCarBtn2 setTitleColor:TitleColor forState:UIControlStateNormal];
    [myCarBtn2 setImage:[UIImage imageNamed:@"wodae"] forState:UIControlStateNormal];
    [myCarBtn2 setTitle:@"我的爱车" forState:UIControlStateNormal];
    [bgView addSubview:myCarBtn2];
    
    // myCarBtn
    CustomButton *myCarBtn3 = [[CustomButton alloc] initWithFrame:CGRectMake(itemWidth * 3 + (itemWidth - imageWidth) / 2, FH(20), imageWidth, imageWidth)];
    myCarBtn3.titleLabel.font = titleFont;
    [myCarBtn3 setTitleColor:TitleColor forState:UIControlStateNormal];
    [myCarBtn3 setImage:[UIImage imageNamed:@"wodaf"] forState:UIControlStateNormal];
    [myCarBtn3 setTitle:@"我的爱车" forState:UIControlStateNormal];
    [bgView addSubview:myCarBtn3];
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return FH(120 + 10);
}

@end
