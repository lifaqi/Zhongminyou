//
//  RecommendTitleTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import "RecommendTitleTableViewCell.h"

#define CellHeight FH(44)

@interface RecommendTitleTableViewCell(){
    UILabel *titleLbl;
    UIButton *moreBtn;
}

@end

@implementation RecommendTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // lineView
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), FH(10), FW(2), CellHeight - FH(10) * 2)];
    lineView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:lineView];
    
    // titleLbl
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + FH(5), 0, FW(100), CGRectGetHeight(self.frame))];
    titleLbl.font = [UIFont boldSystemFontOfSize:15];
    titleLbl.text = _titleStr;
    [self.contentView addSubview:titleLbl];
    
    // moreBtn
    moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - FW(5+60), 0, FW(60), CellHeight)];
    [moreBtn addTarget:self action:@selector(clickMoreEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    // moreLbl
    UILabel *moreLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FW(60), CellHeight)];
    moreLbl.font = [UIFont systemFontOfSize:12];
    moreLbl.textColor = ColorRGBA(200, 200, 200, 1);
    moreLbl.text = @"更多>>";
    [moreBtn addSubview:moreLbl];
}

#pragma mark - property
- (void)setTitleStr:(NSString *)titleStr{
    titleLbl.text = titleStr;
}

-(void)setHiddenMore:(BOOL)hiddenMore{
    moreBtn.hidden = hiddenMore;
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

#pragma mark - event
-(void)clickMoreEvent{
    self.recommendMoreCallBack();
}

@end
