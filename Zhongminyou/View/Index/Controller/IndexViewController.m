//
//  IndexViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/6.
//

#import "IndexViewController.h"
#import "IndexLunbotuTableViewCell.h"
#import "IndexMenuTableViewCell.h"
#import "RecommendTitleTableViewCell.h"
#import "RecommendItemTableViewCell.h"
#import "LininzuijinTableViewCell.h"
#import "LijijiayouView.h"
#import "SureOrderViewController.h"
#import "MJRefresh.h"
#import "SWYMapViewController.h"

#define IndexLunbotuTableViewCellIdentifier @"IndexLunbotuTableViewCell"
#define IndexMenuTableViewCellIdentifier @"IndexMenuTableViewCell"
#define RecommendTitleTableViewCellIdentifier @"RecommendTitleTableViewCell"
#define RecommendItemTableViewCellIdentifier @"RecommendItemTableViewCell"
#define LininzuijinTableViewCellIdentifier @"LininzuijinTableViewCell"

@interface IndexViewController ()<UITableViewDataSource, UITableViewDelegate>{
    // view
    LijijiayouView *lijijiayouView;
    NSMutableArray *gasDataArray;
    
    // data
}

@property (nonatomic, strong) UITableView *mTableView;
//@property (nonatomic, strong) NSString *selectYoupin;
@property (nonatomic, strong) NSString *selectYouhao;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.selectYoupin = @"汽油";
    self.selectYouhao = @"92#";
    
    [self initView];
    
}


#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[IndexLunbotuTableViewCell class] forCellReuseIdentifier:IndexLunbotuTableViewCellIdentifier];
    [_mTableView registerClass:[IndexMenuTableViewCell class] forCellReuseIdentifier:IndexMenuTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendTitleTableViewCell class] forCellReuseIdentifier:RecommendTitleTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendItemTableViewCell class] forCellReuseIdentifier:RecommendItemTableViewCellIdentifier];
    [_mTableView registerClass:[LininzuijinTableViewCell class] forCellReuseIdentifier:LininzuijinTableViewCellIdentifier];
    
    // lijijiayouView
    lijijiayouView = [[LijijiayouView alloc] initWithFrame:CGRectMake(0, HeaderHeight, ScreenWidth, ScreenHeight - HeaderHeight - TabBarHeight)];
    WEAKSELF;
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
    
    lijijiayouView.dingweiCallBack = ^(CGFloat lng, CGFloat lat, NSString * _Nonnull titleStr) {
        SWYMapViewController *mapVC = [[SWYMapViewController alloc] init];
        mapVC.hidesBottomBarWhenPushed = YES;
        mapVC.lng = lng;
        mapVC.lat = lat;
        mapVC.titleStr = titleStr;
        [weakSelf.navigationController pushViewController:mapVC animated:YES];
    };
    
    _mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [_mTableView.mj_header beginRefreshing];
}

#pragma mark - dataSource
-(void)refreshData{
    gasDataArray = [[NSMutableArray alloc] init];
    
    [self getDataSource];
}
    
-(void)getDataSource{
    [[DataProvider shareInstance] getCommentGasList:[ToolKit getLocationInfo].lng andLat:[ToolKit getLocationInfo].lat andOil:self.selectYouhao andCallBackBlock:^(id dict) {
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
        return gasDataArray.count > 0 ? 3 : 2;
    }else{
        return 1 + gasDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            IndexLunbotuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexLunbotuTableViewCellIdentifier forIndexPath:indexPath];
            cell.imagesURLStringsArray = @[@"timg", @"swiper"];
            cell.selectYouhaoCallBack = ^(NSString * _Nonnull youpin, NSString * _Nonnull youhao) {
                self.selectYouhao = youhao;
                [self refreshData];
            };
            return cell;
        }else{
            if (gasDataArray.count > 0) {
                if (indexPath.row == 1){
                    LininzuijinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LininzuijinTableViewCellIdentifier forIndexPath:indexPath];
                    if (gasDataArray.count > 0) {
                        cell.gasDict = gasDataArray[0];
                    }
                    cell.lijijiayouCallBack = ^{
                        lijijiayouView.youhao = self.selectYouhao;
                        [[DataProvider shareInstance] getGasDetail:gasDataArray[0][@"staticId"] andCallBackBlock:^(id dict) {
                            if ([dict[@"code"] intValue] == 0) {
                                lijijiayouView.gasDict = dict[@"data"];
                                [self.view addSubview:self->lijijiayouView];
                                [self->lijijiayouView show];
                            }else{
                                [ToolKit showErrorWithStatus:dict[@"msg"]];
                            }
                        }];
                    };
                    cell.dingweiCallBack = ^(CGFloat lng, CGFloat lat, NSString * _Nonnull titleStr) {
                        SWYMapViewController *mapVC = [[SWYMapViewController alloc] init];
                        mapVC.hidesBottomBarWhenPushed = YES;
                        mapVC.lng = lng;
                        mapVC.lat = lat;
                        mapVC.titleStr = titleStr;
                        [self.navigationController pushViewController:mapVC animated:YES];
                    };
                    return cell;
                }else{
                    IndexMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexMenuTableViewCellIdentifier forIndexPath:indexPath];
                    return cell;
                }
            }else{
                IndexMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexMenuTableViewCellIdentifier forIndexPath:indexPath];
                return cell;
            }
            
        }
    }else{
        if (indexPath.row == 0) {
            RecommendTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTitleTableViewCellIdentifier forIndexPath:indexPath];
            cell.titleStr = @"为你推荐";
            cell.recommendMoreCallBack = ^{
                self.tabBarController.selectedIndex = 1;
            };
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
    if (indexPath.section == 0) {
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
        }
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, ScreenWidth, 0, 0)];
        }
        
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            cell.preservesSuperviewLayoutMargins = false;
        }
    }else{
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsMake(0, FW(7), 0, 0)];
        }
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, FW(7), 0, 0)];
        }
        
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            cell.preservesSuperviewLayoutMargins = false;
        }
    }
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (gasDataArray.count == 0) {
            if (indexPath.row == 0) {
                return [IndexLunbotuTableViewCell getCellHeight];
            }else{
                return [IndexMenuTableViewCell getCellHeight];
            }
        }else{
            if (indexPath.row == 0) {
                return [IndexLunbotuTableViewCell getCellHeight];
            }else if (indexPath.row == 1){
                return [LininzuijinTableViewCell getCellHeight];
            }else{
                return [IndexMenuTableViewCell getCellHeight];
            }
        }
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
        lijijiayouView.youhao = self.selectYouhao;
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
