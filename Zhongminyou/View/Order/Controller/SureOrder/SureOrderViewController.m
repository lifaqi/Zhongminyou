//
//  SureOrderViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/11.
//

#import "SureOrderViewController.h"
#import "OrderDetailTableViewCell.h"

#define OrderDetailTableViewCellIdentifier @"OrderDetailTableViewCell"
#define CellIdentifier @"CellIdentifier"

@interface SureOrderViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *titleStringArray;
    NSArray *valueStringArray;
    NSArray *payTypeArray;
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
    titleStringArray = @[@"加油站名称", @"油品", @"油号", @"升数", @"金额", @"车牌号"];
    valueStringArray = @[@""];
    
    payTypeArray = @[@"微信"];
}

#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - FH(50))];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[OrderDetailTableViewCell class] forCellReuseIdentifier:OrderDetailTableViewCellIdentifier];
    [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, FH(50))];
    footerView.backgroundColor = ColorRGB(225, 225, 225);
    [self.view addSubview:footerView];
    
    // titleLbl
    NSString *moneyStr = @"44";
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:SWYNSStringFromFormat(@"合计待支付金额：￥%@",moneyStr)];
    [moneyAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(9, moneyStr.length)];
    [moneyAttr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(9, moneyStr.length)];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FH(15), 0, FW(160), CGRectGetHeight(footerView.frame))];
    titleLbl.font = [UIFont boldSystemFontOfSize:14];
    titleLbl.textColor = TitleColor;
    titleLbl.attributedText = moneyAttr;
    [footerView addSubview:titleLbl];
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
    if (indexPath.section == 0) {
        OrderDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailTableViewCellIdentifier forIndexPath:indexPath];
        cell.titleString = titleStringArray[indexPath.row];
        cell.valueString = valueStringArray[0];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        for (UIView *itemView in cell.contentView.subviews) {
            [itemView removeFromSuperview];
        }
        
        // titleLbl
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(FW(15), 0, FW(100), cell.frame.size.height)];
        titleLbl.font = [UIFont systemFontOfSize:14];
        titleLbl.textColor = TitleColor;
        titleLbl.text = payTypeArray[indexPath.row];
        [cell.contentView addSubview:titleLbl];
        
        // checkBtn
//        check
        
        
        return cell;
    }
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
    return [OrderDetailTableViewCell getCellHeight];
}

@end
