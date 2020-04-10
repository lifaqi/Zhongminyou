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


#define IndexLunbotuTableViewCellIdentifier @"IndexLunbotuTableViewCell"
#define IndexMenuTableViewCellIdentifier @"IndexMenuTableViewCell"
#define RecommendTitleTableViewCellIdentifier @"RecommendTitleTableViewCell"
#define RecommendItemTableViewCellIdentifier @"RecommendItemTableViewCell"

@interface IndexViewController ()<UITableViewDataSource, UITableViewDelegate>

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
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1 + 10;;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            IndexLunbotuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IndexLunbotuTableViewCellIdentifier forIndexPath:indexPath];
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

@end
