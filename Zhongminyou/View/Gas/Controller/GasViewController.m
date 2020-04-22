//
//  GasViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "GasViewController.h"
#import "GasLunbotuTableViewCell.h"
#import "RecommendTitleTableViewCell.h"
#import "RecommendItemTableViewCell.h"
#import "MJRefresh.h"
#import "SWYMapViewController.h"
#import "LijijiayouView.h"
#import "SureOrderViewController.h"

#define GasLunbotuTableViewCellIdentifier @"GasLunbotuTableViewCell"
#define RecommendTitleTableViewCellIdentifier @"RecommendTitleTableViewCell"
#define RecommendItemTableViewCellIdentifier @"RecommendItemTableViewCell"

@interface GasViewController ()<UITableViewDataSource, UITableViewDelegate>{
    // view
    LijijiayouView *lijijiayouView;
    // data
    NSMutableArray *gasDataArray;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation GasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavTitle:@"加油站"];
    
    [self initView];
}

#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[GasLunbotuTableViewCell class] forCellReuseIdentifier:GasLunbotuTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendTitleTableViewCell class] forCellReuseIdentifier:RecommendTitleTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendItemTableViewCell class] forCellReuseIdentifier:RecommendItemTableViewCellIdentifier];
    
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [_mTableView.mj_header beginRefreshing];
    
    // lijijiayouView
    lijijiayouView = [[LijijiayouView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - TabBarHeight)];
    WEAKSELF;
    lijijiayouView.dingweiCallBack = ^(CGFloat lng, CGFloat lat, NSString * _Nonnull titleStr) {
        SWYMapViewController *mapVC = [[SWYMapViewController alloc] init];
        mapVC.hidesBottomBarWhenPushed = YES;
        mapVC.lng = lng;
        mapVC.lat = lat;
        mapVC.titleStr = titleStr;
        [weakSelf.navigationController pushViewController:mapVC animated:YES];

    };
    
    lijijiayouView.lijiPayCallBack = ^(NSDictionary * _Nonnull dict, NSString * _Nonnull youpin, NSString * _Nonnull youhao, NSString * _Nonnull amount, NSString *price, NSString *youji, NSString *youqiang) {
        SureOrderViewController *sureOrderVC = [[SureOrderViewController alloc] init];
        sureOrderVC.hidesBottomBarWhenPushed = YES;
        OrderInfoModel *orderInfoModel = [[OrderInfoModel alloc] init];
        orderInfoModel.gasId = [ToolKit dealWithString:dict[@"staticId"]];
        orderInfoModel.gasName = [ToolKit dealWithString:dict[@"staticName"]];
        orderInfoModel.youpin = youpin;
        orderInfoModel.youhao = youhao;
        orderInfoModel.shengshu = SWYNSStringFromFormat(@"%.2f",[amount floatValue] / [price floatValue]);
        orderInfoModel.price = price;
        orderInfoModel.youji = youji;
        orderInfoModel.youqiang = youqiang;
        orderInfoModel.total = amount;
        sureOrderVC.orderInfoModel = orderInfoModel;
        [weakSelf.navigationController pushViewController:sureOrderVC animated:YES];
    };
}

#pragma mark - dataSource
-(void)refreshData{
    gasDataArray = [[NSMutableArray alloc] init];
    
    [self getDataSource];
}

-(void)getDataSource{
    [[DataProvider shareInstance] getFujinGasList:[ToolKit getLocationInfo].lng andLat:[ToolKit getLocationInfo].lat andCallBackBlock:^(id dict) {
        [_mTableView.mj_header endRefreshing];
        if ([dict[@"code"] intValue] == 0) {
            [ToolKit dismiss];
            
            SWYLog(@"%@",dict);
            
            gasDataArray = dict[@"data"];
            
            [_mTableView reloadData];
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
        return 1;
    }else{
        return 1 + gasDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GasLunbotuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GasLunbotuTableViewCellIdentifier forIndexPath:indexPath];
        cell.imagesURLStringsArray = @[@"timg", @"swiper"];
        return cell;
    }else{
        if (indexPath.row == 0) {
            RecommendTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTitleTableViewCellIdentifier forIndexPath:indexPath];
            cell.titleStr = @"附近加油站";
            cell.hiddenMore = YES;
            return cell;
        }else{
            RecommendItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendItemTableViewCellIdentifier forIndexPath:indexPath];
            cell.gasDataDict = gasDataArray[indexPath.row - 1];
            cell.dingweiCallBack = ^(CGFloat lng, CGFloat lat, NSString *titleStr) {
                SWYMapViewController *mapVC = [[SWYMapViewController alloc] init];
                mapVC.hidesBottomBarWhenPushed = YES;
                mapVC.lng = lng;
                mapVC.lat = lat;
                mapVC.titleStr = titleStr;
                [self.navigationController pushViewController:mapVC animated:YES];
            };
            return cell;
        }
    }
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
        return [GasLunbotuTableViewCell getCellHeight];
    }else{
        if (indexPath.row == 0) {
            return [RecommendTitleTableViewCell getCellHeight];
        }else{
            return [RecommendItemTableViewCell getCellHeight];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row > 0) {
        lijijiayouView.distance = SWYNSStringFromFormat(@"%.2fkm",[gasDataArray[indexPath.row - 1][@"range"] floatValue]);
        [[DataProvider shareInstance] getGasDetail:gasDataArray[indexPath.row - 1][@"staticId"] andCallBackBlock:^(id dict) {
            if ([dict[@"code"] intValue] == 0) {
                lijijiayouView.gasDict = dict[@"data"];
                [self.view addSubview:self->lijijiayouView];
                [self->lijijiayouView show];
            }else{
                [ToolKit showErrorWithStatus:dict[@"msg"]];
            }
        }];
    }
}

@end
