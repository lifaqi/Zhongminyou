//
//  OrderViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "LeijixiaofeiViewController.h"
#import "OrderDetailViewController.h"

#define OrderTableViewCellIdentifier @"OrderTableViewCell"

@interface OrderViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIButton *preBtn;
    NSInteger selectIndex;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"订单"];
    
    [self initView];
}

#pragma mark - initView
-(void)initView{
    // bgIv
    UIImageView *bgIv = [[UIImageView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, FH(100))];
    bgIv.contentMode = UIViewContentModeScaleAspectFill;;
    bgIv.image = [UIImage imageNamed:@"order_top_bg"];
    [self.view addSubview:bgIv];
    
    // bgView
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(FW(20), HeaderHeight + FH(40), ScreenWidth - FW(20) * 2, FH(90))];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 12;
    bgView.layer.borderWidth = 1;
    bgView.layer.borderColor = ColorRGBA(200, 200, 200, 0.4).CGColor;
    [self.view addSubview:bgView];
    
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
    moneyTitle.text = @"累计消费（元）";
    [bgView addSubview:moneyTitle];
    
    // leijixiaofeiBtn
    UIButton *leijixiaofeiBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itemWidth, FH(90))];
    [leijixiaofeiBtn addTarget:self action:@selector(clickLeijixiaofeiEvent) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:leijixiaofeiBtn];
    
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
    oilTitle.text = @"累计加油升数（L）";
    [bgView addSubview:oilTitle];
    // lineView
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(itemWidth, FH(15), FW(1), CGRectGetHeight(bgView.frame) - FH(15) * 2)];
    lineView.backgroundColor = ColorRGB(100, 100, 100);
    [bgView addSubview:lineView];

    // allBtn
    CGFloat btnItemWidth = ScreenWidth * 0.75 / 3;
    UIButton *allBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth * 0.25 / 2, CGRectGetMaxY(bgView.frame) + FH(20), btnItemWidth, FH(35))];
    allBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    allBtn.layer.masksToBounds = YES;
    allBtn.layer.cornerRadius = 6;
    allBtn.backgroundColor = [UIColor blueColor];
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [allBtn addTarget:self action:@selector(clickItemEvent:) forControlEvents:UIControlEventTouchUpInside];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    allBtn.selected = YES;
    preBtn = allBtn;
    allBtn.tag = 0;
    selectIndex = 0;
    [self.view addSubview:allBtn];
    // noPayBtn
    UIButton *noPayBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(allBtn.frame), CGRectGetMaxY(bgView.frame) + FH(20), btnItemWidth, FH(35))];
    noPayBtn.backgroundColor = ColorRGB(230, 230, 230);
    noPayBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [noPayBtn setTitleColor:ColorRGB(20, 20, 20) forState:UIControlStateNormal];
    [noPayBtn addTarget:self action:@selector(clickItemEvent:) forControlEvents:UIControlEventTouchUpInside];
    [noPayBtn setTitle:@"未支付" forState:UIControlStateNormal];
    noPayBtn.tag = 1;
    [self.view addSubview:noPayBtn];
    // zhifuBtn
    UIButton *zhifuBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(noPayBtn.frame), CGRectGetMaxY(bgView.frame) + FH(20), btnItemWidth, FH(35))];
    zhifuBtn.backgroundColor = ColorRGB(230, 230, 230);
    zhifuBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [zhifuBtn setTitleColor:ColorRGB(20, 20, 20) forState:UIControlStateNormal];
    [zhifuBtn addTarget:self action:@selector(clickItemEvent:) forControlEvents:UIControlEventTouchUpInside];
    [zhifuBtn setTitle:@"已支付" forState:UIControlStateNormal];
    zhifuBtn.tag = 2;
    [self.view addSubview:zhifuBtn];
    
    // _mTableView
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(zhifuBtn.frame) + FH(10), ScreenWidth, ScreenHeight - (CGRectGetMaxY(zhifuBtn.frame) + FH(10)) - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.backgroundColor = BackGroundColor;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:OrderTableViewCellIdentifier];
}

#pragma mark - event
-(void)clickItemEvent:(UIButton *)sender{
    if (preBtn != nil) {
        preBtn.layer.masksToBounds = YES;
        preBtn.layer.cornerRadius = 0;
        preBtn.backgroundColor = ColorRGB(230, 230, 230);
        [preBtn setTitleColor:ColorRGB(20, 20, 20) forState:UIControlStateNormal];
    }
    preBtn = sender;
    preBtn.selected = NO;
    sender.selected = !sender.selected;
    selectIndex = sender.tag;
    if (sender.selected) {
        sender.layer.masksToBounds = YES;
        sender.layer.cornerRadius = 6;
        sender.backgroundColor = [UIColor blueColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        sender.layer.masksToBounds = YES;
        sender.layer.cornerRadius = 0;
        sender.backgroundColor = ColorRGB(230, 230, 230);
        [sender setTitleColor:ColorRGB(20, 20, 20) forState:UIControlStateNormal];
    }
}

-(void)clickLeijixiaofeiEvent{
    LeijixiaofeiViewController *leijixiaofeiVC = [[LeijixiaofeiViewController alloc] init];
    [self.navigationController pushViewController:leijixiaofeiVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderTableViewCellIdentifier forIndexPath:indexPath];
    
    
    
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
    return [OrderTableViewCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderDetalVC = [[OrderDetailViewController alloc] init];
    orderDetalVC.orderType = OrderTypePay;
    [self.navigationController pushViewController:orderDetalVC animated:YES];
}

@end
