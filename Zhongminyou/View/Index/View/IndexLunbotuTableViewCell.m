//
//  IndexLunbotuTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/8.
//

#import "IndexLunbotuTableViewCell.h"
#import "SDCycleScrollView.h"

@interface IndexLunbotuTableViewCell()<SDCycleScrollViewDelegate>{
    
}

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) DropDownMenu *typeMenu;
@property (nonatomic, strong) DropDownMenu *IDMenu;
@property (nonatomic, strong) NSString *selectYoupin;

@end

@implementation IndexLunbotuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
        
        self.selectYoupin = @"汽油";
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = BackGroundColor;
    }
    return self;
}

#pragma mark - setUpUI
-(void)setUpUI{
    // cycleScrollView
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth / 2.5) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _cycleScrollView.currentPageDotColor = RedColor;
    [self.contentView addSubview:_cycleScrollView];
    
    // bgView
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), CGRectGetMaxY(_cycleScrollView.frame) - FH(30), ScreenWidth - FW(15) * 2, FH(60))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 8;
    [self.contentView addSubview:bgView];
    
    // titleLbl
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), 0, FW(100), CGRectGetHeight(bgView.frame))];
    titleLbl.font = [UIFont systemFontOfSize:14];
    titleLbl.text = @"便捷加油";
    [bgView addSubview:titleLbl];
    
    // typeMenu
    _typeMenu = [[DropDownMenu alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bgView.frame) - FW(30+60+20+60), (CGRectGetHeight(bgView.frame) - FH(25)) / 2, FW(60), FH(25))];
    _typeMenu.selectIndex = 0;
    _typeMenu.itemArray = @[@"汽油", @"柴油"];
    WEAKSELF;
    _typeMenu.clickItemEvent = ^(NSInteger index) {
        if (index == 0) {
            weakSelf.selectYoupin = @"汽油";
            weakSelf.IDMenu.itemArray = @[@"92#",@"93#",@"95#",@"97#",@"98#"];
            weakSelf.selectYouhaoCallBack(weakSelf.selectYoupin, @"92#");
        }else{
            weakSelf.selectYoupin = @"柴油";
            weakSelf.IDMenu.itemArray = @[@"0#",@"-10#",@"-20#",@"-30#",@"-50#"];
            weakSelf.selectYouhaoCallBack(weakSelf.selectYoupin, @"0#");
        }
        weakSelf.typeMenu.selectIndex = index;
    };
    [bgView addSubview:_typeMenu];
    
    
    // IDMenu
    _IDMenu = [[DropDownMenu alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bgView.frame) - FW(30+60), (CGRectGetHeight(bgView.frame) - FH(25)) / 2, FW(60), FH(25))];
    _IDMenu.selectIndex = 0;
    _IDMenu.itemArray = @[@"92#",@"93#",@"95#",@"97#",@"98#"];
    _IDMenu.clickItemEvent = ^(NSInteger index) {
        weakSelf.IDMenu.selectIndex = index;
        
        weakSelf.selectYouhaoCallBack(weakSelf.selectYoupin, weakSelf.IDMenu.itemArray[index]);
    };
    [bgView addSubview:_IDMenu];
    
    _typeMenu.dropDownMenu = _IDMenu;
    _IDMenu.dropDownMenu = _typeMenu;
    
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return ScreenWidth / 2.5 + FH(30 + 10);
}

#pragma mark - data source
-(void)setImagesURLStringsArray:(NSArray *)imagesURLStringsArray{
    _cycleScrollView.localizationImageNamesGroup = imagesURLStringsArray;
}

-(void)setFrameHeight:(CGFloat)height{
    _cycleScrollView.frame = CGRectMake(0, 0, ScreenWidth, height);
}

-(void)setPageContolAliment:(SDCycleScrollViewPageContolAliment)pageContolAliment{
    _cycleScrollView.pageControlAliment = pageContolAliment;
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    self.indexLunbotuClickBlock(index, self.tag);
}

@end
