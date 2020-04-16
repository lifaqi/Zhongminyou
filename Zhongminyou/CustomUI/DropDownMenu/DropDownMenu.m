//
//  DropDownMenu.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/8.
//

#import "DropDownMenu.h"

@interface DropDownMenu(){
    UILabel *titleLbl;
    UIImageView *iconIv;
    UIButton *showBgBtn;
    UIView *itemView;
    UIImageView *selectIv;
    UIView *topView;
    UIButton *bgBtn;
    NSMutableArray *saveImage;
}

@end

@implementation DropDownMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        saveImage = [[NSMutableArray alloc] init];
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // bgView
    bgBtn = [[UIButton alloc] initWithFrame:self.bounds];
    bgBtn.backgroundColor = ColorRGB(220, 220, 220);
    bgBtn.layer.masksToBounds = YES;
    bgBtn.layer.cornerRadius = CGRectGetHeight(bgBtn.frame) / 2;
    [bgBtn addTarget:self action:@selector(clickBgEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    // titleLbl
    titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(10), 0, CGRectGetWidth(bgBtn.frame), CGRectGetHeight(bgBtn.frame))];
    titleLbl.font = [UIFont systemFontOfSize:12];
    titleLbl.textColor = ColorRGB(120, 120, 120);
    [bgBtn addSubview:titleLbl];
    // iconIv
    iconIv = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgBtn.frame) - FW(8+14), 0, FW(14), FH(25))];
    iconIv.contentMode = UIViewContentModeScaleAspectFit;
    iconIv.image = [UIImage imageNamed:@"jiantou_down"];
    [bgBtn addSubview:iconIv];
    
    
}

#pragma mark - property
-(void)setItemArray:(NSArray *)itemArray{
    _itemArray = itemArray;
    // showBgBtn
    CGFloat topValue = ScreenWidth / 2 + FH(30) - FH(60-25) / 2 + FH(10);
    showBgBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, topValue, ScreenWidth, ScreenHeight - topValue - TabBarHeight - FH(1))];
    showBgBtn.hidden = YES;
    showBgBtn.alpha = 0.3;
    showBgBtn.tag = 1;
    showBgBtn.backgroundColor = ColorRGBA(100, 100, 100, 0.4);
    [showBgBtn addTarget:self action:@selector(clickShowBgEvent) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:showBgBtn];
    // itemView
    itemView = [[UIView alloc] initWithFrame:CGRectMake(0, topValue, ScreenWidth, 0)];
    itemView.hidden = YES;
    itemView.alpha = 0.3;
    itemView.tag = 1;
    itemView.backgroundColor = [UIColor whiteColor];
    [topView addSubview:itemView];
    // selectIv
    selectIv = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(itemView.frame) - FH(20+20), FH(44-20) / 2, FH(20), FH(20))];
    selectIv.alpha = 0;
    selectIv.contentMode = UIViewContentModeScaleAspectFit;
    selectIv.image = [UIImage imageNamed:@"duihao"];
    [itemView addSubview:selectIv];
    
    
    for (int i = 0; i < itemArray.count; i++) {
        UIButton *itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(FW(15), i * FH(44+1), ScreenWidth - FW(15) * 2, FH(44))];
        itemBtn.tag = i;
        itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [itemBtn setTitleColor:ColorRGB(150, 150, 150) forState:UIControlStateNormal];
        [itemBtn setTitle:itemArray[i] forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(clickItemEvent:) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:itemBtn];
        
        if (i != itemArray.count - 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(itemBtn.frame), ScreenWidth, 1)];
            lineView.backgroundColor = ColorRGBA(200, 200, 200, 0.7);
            [itemView addSubview:lineView];
        }
    }
    
    // 初始化值
    titleLbl.text = itemArray.count > _selectIndex ? itemArray[_selectIndex] : @"";
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    selectIv.frame = CGRectMake(CGRectGetMinX(selectIv.frame), selectIndex * FH(44) + selectIndex + FH(44-20) / 2, CGRectGetWidth(selectIv.frame), CGRectGetHeight(selectIv.frame));
}

#pragma mark - event
-(void)clickBgEvent{
    if (topView == nil) {
        topView = [ToolKit getTopView];
    }
    if (showBgBtn.hidden) {
        [self show];
    }else{
        [self hidden];
    }
}

-(void)show{
    for (UIView *view in topView.subviews) {
        if (view.tag == 1) {
            view.hidden = YES;
        }
    }
    
    UIButton *preButton = (_dropDownMenu.subviews)[0];
    for (UIView *view in preButton.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *preIv = (UIImageView *)view;
            preIv.image = [UIImage imageNamed:@"jiantou_down"];
        }
    }
    
    
    [topView addSubview:showBgBtn];
    [topView addSubview:itemView];
    
    showBgBtn.hidden = NO;
    itemView.hidden = NO;
    iconIv.image = [UIImage imageNamed:@"jiantou_up"];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->showBgBtn.alpha = 1;
        self->itemView.alpha = 1;
        self->selectIv.alpha = 1;
        self->itemView.frame = CGRectMake(0, CGRectGetMinY(self->itemView.frame),CGRectGetWidth(self->itemView.frame), FH(44)*self.itemArray.count + self.itemArray.count - 1);
    } completion:^(BOOL finished) {
    }];
}

-(void)hidden{
    selectIv.alpha = 0;
    iconIv.image = [UIImage imageNamed:@"jiantou_down"];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->showBgBtn.alpha = 0.3;
        self->itemView.alpha = 0.3;
        self->itemView.frame = CGRectMake(0, CGRectGetMinY(self->itemView.frame),CGRectGetWidth(self->itemView.frame), 0);
    } completion:^(BOOL finished) {
        self->showBgBtn.hidden = YES;
        self->itemView.hidden = YES;
    }];
}

-(void)clickItemEvent:(UIButton *)sender{
    self.clickItemEvent(sender.tag);
    titleLbl.text = _itemArray[sender.tag];

//    if ([[ToolKit dealWithString:titleLbl.text] isEqualToString:@"汽油"]) {
//        self.itemArray = @[@"92#",@"93#",@"95#",@"97#",@"98#"];
//
//    }else if ([[ToolKit dealWithString:titleLbl.text] isEqualToString:@"柴油"]){
//        self.itemArray = @[@"0#",@"-10#",@"-20#",@"-30#",@"-50#"];
//    }
    
    [self hidden];
}

-(void)clickShowBgEvent{
    [self hidden];
}

@end
