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

#define GasLunbotuTableViewCellIdentifier @"GasLunbotuTableViewCell"
#define RecommendTitleTableViewCellIdentifier @"RecommendTitleTableViewCell"
#define RecommendItemTableViewCellIdentifier @"RecommendItemTableViewCell"

@interface GasViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation GasViewController

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
    
    [_mTableView registerClass:[GasLunbotuTableViewCell class] forCellReuseIdentifier:GasLunbotuTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendTitleTableViewCell class] forCellReuseIdentifier:RecommendTitleTableViewCellIdentifier];
    [_mTableView registerClass:[RecommendItemTableViewCell class] forCellReuseIdentifier:RecommendItemTableViewCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1 + 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        GasLunbotuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GasLunbotuTableViewCellIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        if (indexPath.row == 0) {
            RecommendTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendTitleTableViewCellIdentifier forIndexPath:indexPath];
            cell.titleStr = @"附近加油站";
            cell.hiddenMore = YES;
            return cell;
        }else{
            RecommendItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecommendItemTableViewCellIdentifier forIndexPath:indexPath];
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

@end
