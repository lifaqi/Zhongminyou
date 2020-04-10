//
//  MineViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "MineViewController.h"
#import "CustomButton.h"

#define CellIdentifier @"CellIdentifier"

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"我的"];
    
    [self initView];
}

#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = BackGroundColor;
    for (UIView *itemView in cell.contentView.subviews) {
        [itemView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        // bgIv
        UIImageView *bgIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FH(120))];
        bgIv.contentMode = UIViewContentModeScaleAspectFill;;
        bgIv.image = [UIImage imageNamed:@"my_top_bg"];
        [cell.contentView addSubview:bgIv];
        
        // photoIv
        UIImageView *photoIv = [[UIImageView alloc] initWithFrame:CGRectMake(FW(20), FH(20), FH(60), FH(60))];
        photoIv.contentMode = UIViewContentModeScaleToFill;
        photoIv.layer.masksToBounds = YES;
        photoIv.layer.cornerRadius = CGRectGetWidth(photoIv.frame) / 2;
        [photoIv sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"headimg"]];
        [bgIv addSubview:photoIv];
        
        // nameLbl
        UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoIv.frame) + FW(12), CGRectGetMinY(photoIv.frame) + FH(5), FW(200), FH(21))];
        nameLbl.textColor = [UIColor whiteColor];
        nameLbl.font = [UIFont systemFontOfSize:17];
        nameLbl.text = @"路人甲";
        [bgIv addSubview:nameLbl];
        
        // sexLbl
        UILabel *sexLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLbl.frame) - FW(3), CGRectGetMaxY(nameLbl.frame) + FH(10), FW(60), FH(18))];
        sexLbl.layer.masksToBounds = YES;
        sexLbl.layer.cornerRadius = CGRectGetHeight(sexLbl.frame) / 2;
        sexLbl.textAlignment = NSTextAlignmentCenter;
        sexLbl.backgroundColor = ColorRGBA(100, 100, 100, 0.4);
        sexLbl.textColor = [UIColor whiteColor];
        sexLbl.font = [UIFont systemFontOfSize:10];
        sexLbl.text = SWYNSStringFromFormat(@"性别：%@",@"男");
        [bgIv addSubview:sexLbl];
        
        // bgView
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(FW(20), FH(100), ScreenWidth - FW(20) * 2, FH(90))];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 12;
        bgView.layer.borderWidth = 1;
        bgView.layer.borderColor = ColorRGBA(200, 200, 200, 0.4).CGColor;
        [cell.contentView addSubview:bgView];
        // moneyLbl
        CGFloat itemWidth = (CGRectGetWidth(bgView.frame) - FW(1)) / 2;
        UILabel *moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, FH(15), itemWidth, FH(21))];
        moneyLbl.textAlignment = NSTextAlignmentCenter;
        moneyLbl.font = [UIFont systemFontOfSize:16];
        moneyLbl.text = @"0";
        [bgView addSubview:moneyLbl];
        // moneyTitle
        UILabel *moneyTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyLbl.frame) + FH(15), itemWidth, FH(21))];
        moneyTitle.textAlignment = NSTextAlignmentCenter;
        moneyTitle.font = [UIFont systemFontOfSize:12];
        moneyTitle.textColor = ColorRGB(125, 125, 125);
        moneyTitle.text = @"加油余额（元）";
        [bgView addSubview:moneyTitle];
        // oilLbl
        UILabel *oilLbl = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth, FH(15), itemWidth, FH(21))];
        oilLbl.textAlignment = NSTextAlignmentCenter;
        oilLbl.font = [UIFont systemFontOfSize:16];
        oilLbl.text = @"0";
        [bgView addSubview:oilLbl];
        // oilTitle
        UILabel *oilTitle = [[UILabel alloc] initWithFrame:CGRectMake(itemWidth, CGRectGetMaxY(oilLbl.frame) + FH(15), itemWidth, FH(21))];
        oilTitle.textAlignment = NSTextAlignmentCenter;
        oilTitle.font = [UIFont systemFontOfSize:12];
        oilTitle.textColor = ColorRGB(125, 125, 125);
        oilTitle.text = @"优惠券";
        [bgView addSubview:oilTitle];
        // lineView
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, FH(15), FW(1), CGRectGetHeight(bgView.frame) - FH(15) * 2)];
        lineView.backgroundColor = ColorRGB(100, 100, 100);
        [bgView addSubview:lineView];
    }else if (indexPath.section == 1){
        CustomButton *youhuiquanBtn = [[CustomButton alloc] initWithFrameLeftRight:CGRectMake(FW(15), FH(10+8), ScreenWidth - FW(15), FH(44))];
        [youhuiquanBtn setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
        [youhuiquanBtn setTitle:@"优惠券" forState:UIControlStateNormal];
        [cell.contentView addSubview:youhuiquanBtn];
        // footerView
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youhuiquanBtn.frame) + FH(8), ScreenWidth, FH(10))];
        footerView.backgroundColor = BackGroundColor;
        [cell.contentView addSubview:footerView];
    }else{
        CustomButton *youhuiquanBtn = [[CustomButton alloc] initWithFrameLeftRight:CGRectMake(FW(15), FH(60 - 44) / 2, ScreenWidth - FW(15), FH(44))];
        [youhuiquanBtn setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
        [youhuiquanBtn setTitle:@"在线客服" forState:UIControlStateNormal];
        [cell.contentView addSubview:youhuiquanBtn];
        // footerView
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(youhuiquanBtn.frame) + FH(8), ScreenWidth, FH(10))];
        footerView.backgroundColor = BackGroundColor;
        [cell.contentView addSubview:footerView];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        cell.preservesSuperviewLayoutMargins = false;
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FH(200);
    }else if (indexPath.section == 1){
        return FH(10 + 60 + 10);
    }else{
        return FH(60 + 10);
    }
}

@end
