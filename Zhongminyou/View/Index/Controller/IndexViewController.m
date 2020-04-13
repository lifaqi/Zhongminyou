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

#define IndexLunbotuTableViewCellIdentifier @"IndexLunbotuTableViewCell"
#define IndexMenuTableViewCellIdentifier @"IndexMenuTableViewCell"
#define RecommendTitleTableViewCellIdentifier @"RecommendTitleTableViewCell"
#define RecommendItemTableViewCellIdentifier @"RecommendItemTableViewCell"
#define LininzuijinTableViewCellIdentifier @"LininzuijinTableViewCell"

@interface IndexViewController ()<UITableViewDataSource, UITableViewDelegate>{
    // view
    LijijiayouView *lijijiayouView;
}

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
}


#pragma mark - initView
-(void)initView{
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TabBarHeight)];
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
    lijijiayouView.lijiPayCallBack = ^{
        SureOrderViewController *sureOrderVC = [[SureOrderViewController alloc] init];
        sureOrderVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:sureOrderVC animated:YES];
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else{
        return 1 + 10;;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            IndexLunbotuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexLunbotuTableViewCellIdentifier forIndexPath:indexPath];
            return cell;
        }else if (indexPath.row == 1){
            LininzuijinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LininzuijinTableViewCellIdentifier forIndexPath:indexPath];
            cell.lijijiayouCallBack = ^{
                [self.view addSubview:self->lijijiayouView];
                [self->lijijiayouView show];
            };
            return cell;
        }else{
            IndexMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexMenuTableViewCellIdentifier forIndexPath:indexPath];
            return cell;
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
        if (indexPath.row == 0) {
            return [IndexLunbotuTableViewCell getCellHeight];
        }else if (indexPath.row == 1){
            return [LininzuijinTableViewCell getCellHeight];
        }else{
            return [IndexMenuTableViewCell getCellHeight];
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
        [self.view addSubview:self->lijijiayouView];
        [self->lijijiayouView show];
    }
}

@end
