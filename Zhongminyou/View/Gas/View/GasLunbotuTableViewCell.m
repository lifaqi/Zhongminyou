//
//  GasLunbotuTableViewCell.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/9.
//

#import "GasLunbotuTableViewCell.h"

#define CellHeight ScreenWidth / 3

@interface GasLunbotuTableViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation GasLunbotuTableViewCell

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
    // cycleScrollView
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, CellHeight) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder_img"]];
    _cycleScrollView.delegate = self;
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _cycleScrollView.currentPageDotColor = RedColor;
    [self.contentView addSubview:_cycleScrollView];
}

#pragma mark - func
+ (CGFloat)getCellHeight{
    return CellHeight;
}

#pragma mark - data source
-(void)setImagesURLStringsArray:(NSArray *)imagesURLStringsArray{
    _cycleScrollView.imageURLStringsGroup = imagesURLStringsArray;
}

-(void)setFrameHeight:(CGFloat)height{
    _cycleScrollView.frame = CGRectMake(0, 0, ScreenWidth, height);
}

-(void)setPageContolAliment:(SDCycleScrollViewPageContolAliment)pageContolAliment{
    _cycleScrollView.pageControlAliment = pageContolAliment;
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    self.gasLunbotuCallBack(index, self.tag);
}

@end
