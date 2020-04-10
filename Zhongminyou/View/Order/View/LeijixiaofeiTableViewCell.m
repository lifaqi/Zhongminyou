//
//  LeijixiaofeiTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "LeijixiaofeiTableViewCell.h"

#define CellHeight FH(62)

@implementation LeijixiaofeiTableViewCell

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
    // titleLbl
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), FH(5), FW(300), FH(21))];
    titleLbl.text = @"蒙山路加油站";
    [self.contentView addSubview:titleLbl];
    
    // timeLbl
    UILabel *timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(titleLbl.frame) + FH(10), FW(300), FH(21))];
    timeLbl.font = [UIFont systemFontOfSize:12];
    timeLbl.textColor = ColorRGB(200, 200, 200);
    timeLbl.text = @"2020-04-04 11:33:33";
    [self.contentView addSubview:timeLbl];
    
    // priceLbl
    UILabel *priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+80), 0, FW(80), CellHeight)];
    priceLbl.textAlignment = NSTextAlignmentCenter | NSTextAlignmentRight;
    priceLbl.font = [UIFont systemFontOfSize:21];
    priceLbl.textColor = [UIColor redColor];
    priceLbl.text = @"-0.01";
    [self.contentView addSubview:priceLbl];
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

@end
