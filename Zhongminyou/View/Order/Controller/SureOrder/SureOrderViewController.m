//
//  SureOrderViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "SureOrderViewController.h"

#define CellIdentifier @"CellIdentifier"

@interface SureOrderViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *titleStringArray;
    NSArray *valueStringArray;
    NSArray *payTypeArray;
    
    // value
    NSInteger selectPayTypeIndex;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    [self setNavTitle:@"确认订单"];
    
    [self initData];
    [self initView];
}

#pragma mark - initData
-(void)initData{
    SWYLog(@"%@",_orderInfoModel);
    titleStringArray = @[@"加油站名称", @"油品", @"油号", @"升数", @"金额", @"车牌号"];
    valueStringArray = @[_orderInfoModel.gasName, _orderInfoModel.youpin, _orderInfoModel.youhao, SWYNSStringFromFormat(@"约%@L",_orderInfoModel.shengshu), SWYNSStringFromFormat(@"￥%@  单价%@/L",_orderInfoModel.total,_orderInfoModel.price), @""];
    
    payTypeArray = @[@"微信"];
}

#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - FH(50))];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.bounces = NO;
    _mTableView.backgroundColor = BackGroundColor;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - FH(50), ScreenWidth, FH(50))];
    footerView.backgroundColor = ColorRGB(225, 225, 225);
    [self.view addSubview:footerView];
    
    // titleLbl
    NSString *moneyStr = _orderInfoModel.total;
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:SWYNSStringFromFormat(@"合计待支付金额：￥%@",moneyStr)];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(8, moneyStr.length + 1)];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(8, moneyStr.length + 1)];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FH(15), 0, FW(200), CGRectGetHeight(footerView.frame))];
    titleLbl.font = [UIFont boldSystemFontOfSize:14];
    titleLbl.textColor = TitleColor;
    titleLbl.attributedText = moneyAttr;
    [footerView addSubview:titleLbl];
    
    // surePayBtn
    UIButton *surePayBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - FW(70), 0, FW(70), footerView.frame.size.height)];
    surePayBtn.backgroundColor = [UIColor redColor];
    surePayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [surePayBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    [surePayBtn addTarget:self
                   action:@selector(clickSurePayEvent) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:surePayBtn];
}

#pragma mark - event
-(void)clickPayTypeEvent:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    selectPayTypeIndex = sender.tag;
}

-(void)clickSurePayEvent{
    [[DataProvider shareInstance] surePay:_orderInfoModel.gasId andMachineCode:_orderInfoModel.youji andMachineNozzleCode:_orderInfoModel.youqiang andMachineNozzleOilsType:_orderInfoModel.youpin andMachineNozzleOils:_orderInfoModel.youhao andOilsPrice:_orderInfoModel.price andLitre:_orderInfoModel.shengshu andTotal:_orderInfoModel.total andCallBackBlock:^(id dict) {
        if ([dict[@"code"] intValue] == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [ToolKit showErrorWithStatus:dict[@"msg"]];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return titleStringArray.count;
    }else{
        return payTypeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *itemView in cell.contentView.subviews) {
        [itemView removeFromSuperview];
    }
    
    if (indexPath.section == 0) {
        // titleLbl
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), 0, FW(100), cell.frame.size.height)];
        titleLbl.font = [UIFont systemFontOfSize:14];
        titleLbl.textColor = [UIColor darkGrayColor];;
        titleLbl.text = titleStringArray[indexPath.row];
        [cell.contentView addSubview:titleLbl];
        
        if (indexPath.row == 5) {
            // valueTf
            UITextField *valueTf = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth -  FW(15+300), 0, ScreenWidth - (ScreenWidth -  FW(15+300)) - FW(15), cell.frame.size.height)];
            valueTf.font = [UIFont systemFontOfSize:14];
            valueTf.textColor = TitleColor;
            valueTf.textAlignment = NSTextAlignmentRight;
            valueTf.placeholder = @"选填";
            [cell.contentView addSubview:valueTf];
        }else{
            // valueLbl
            UILabel *valueLbl = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth -  FW(15+300), 0, ScreenWidth - (ScreenWidth -  FW(15+300)) - FW(15), cell.frame.size.height)];
            valueLbl.font = [UIFont systemFontOfSize:14];
            valueLbl.textColor = TitleColor;
            valueLbl.textAlignment = NSTextAlignmentRight;
            valueLbl.text = valueStringArray[indexPath.row];
            [cell.contentView addSubview:valueLbl];
        }
    }else{
        // titleLbl
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), 0, FW(100), cell.frame.size.height)];
        titleLbl.font = [UIFont systemFontOfSize:14];
        titleLbl.textColor = [UIColor darkGrayColor];;
        titleLbl.text = @"微信";
        [cell.contentView addSubview:titleLbl];
        // checkBtn
        UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth -  FW(15) - FH(20), (cell.frame.size.height - FH(20)) / 2, FH(20), FH(20))];
        checkBtn.selected = YES;
        checkBtn.tag = indexPath.row;
        [checkBtn setImage:[UIImage imageNamed:@"radio_no_select"] forState:UIControlStateNormal];
        [checkBtn setImage:[UIImage imageNamed:@"radio_select"] forState:UIControlStateSelected];
        [checkBtn addTarget:self action:@selector(clickPayTypeEvent:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkBtn];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FH(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FH(50))];
    headerView.backgroundColor = ColorRGB(225, 225, 225);
    
    // lineView
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(FW(15), FH(10), FW(2), FH(50) - FH(10) * 2)];
    lineView.backgroundColor = [UIColor blueColor];
    [headerView addSubview:lineView];
    
    // titleLbl
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame) + FH(5), 0, FW(100), CGRectGetHeight(headerView.frame))];
    titleLbl.font = [UIFont boldSystemFontOfSize:15];
    titleLbl.text = section == 0 ? @"订单详情" : @"支付方式";
    [headerView addSubview:titleLbl];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FH(60);
}

@end
