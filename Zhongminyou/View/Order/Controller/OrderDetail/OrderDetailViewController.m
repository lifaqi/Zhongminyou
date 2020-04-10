//
//  OrderDetailViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"

#define OrderDetailTableViewCellIdentifier @"OrderDetailTableViewCell"

@interface OrderDetailViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *titleStringArray;
    NSArray *valueStringArray;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    [self setNavTitle:@"订单详情"];
    
    [self initData];
    
    [self initView];
}

#pragma mark - initData
-(void)initData{
    if (_orderType == OrderTypePay) {
        titleStringArray = @[@"创建时间", @"支付时间", @"商户订单号", @"微信订单号", @"加油车牌号", @"加油站名称", @"油品", @"油号", @"金额"];
    }else{
        titleStringArray = @[@"创建时间", @"商户订单号",@"加油车牌号", @"加油站名称", @"油品", @"油号", @"金额"];
    }
    valueStringArray = @[@""];
}

#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[OrderDetailTableViewCell class] forCellReuseIdentifier:OrderDetailTableViewCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return titleStringArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.titleString = titleStringArray[indexPath.row];
        cell.valueString = valueStringArray[0];
    }else{
        if (_orderType == OrderTypePay) {
            cell.titleString = @"是否支付";
            cell.valueString = @"已支付";
        }else{
            cell.titleString = @"是否支付";
            cell.valueString = @"未支付";
        }
    }
    
    return cell;
}

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
    titleLbl.text = section == 0 ? @"订单详情" : @"订单状态";
    [headerView addSubview:titleLbl];
    
    return headerView;;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [OrderDetailTableViewCell getCellHeight];
}

@end
