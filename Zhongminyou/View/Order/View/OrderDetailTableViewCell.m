//
//  OrderDetailTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "OrderDetailTableViewCell.h"

#define CellHeight FH(60)

@interface OrderDetailTableViewCell(){
    UILabel *titleLbl;
    UILabel *valueLbl;
}

@end

@implementation OrderDetailTableViewCell

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
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), 0, FW(80), CellHeight)];
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:titleLbl];
    
    // valueLbl
    valueLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - FW(15+300), 0, FW(300), CellHeight)];
    valueLbl.textAlignment = NSTextAlignmentRight;
    valueLbl.font = [UIFont systemFontOfSize:14];
    valueLbl.textColor = TitleColor;
    [self.contentView addSubview:valueLbl];
}

#pragma mark - property
- (void)setTitleString:(NSString *)titleString{
    titleLbl.text = titleString;
}

- (void)setValueString:(NSString *)valueString{
    valueLbl.text = valueString;
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

@end
