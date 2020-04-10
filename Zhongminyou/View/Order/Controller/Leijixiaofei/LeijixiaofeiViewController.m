//
//  LeijixiaofeiViewController.m
//  Zhongminyou
//
//  Created by 李发起 on 2020/4/10.
//

#import "LeijixiaofeiViewController.h"
#import "LeijixiaofeiTableViewCell.h"

#define LeijixiaofeiTableViewCellIdentifier @"LeijixiaofeiTableViewCell"

@interface LeijixiaofeiViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation LeijixiaofeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLeftBtnImg:@"left"];
    
    [self setNavTitle:@"累计消费"];
    
    [self initView];
}

#pragma mark - initView
-(void)initView{
    // moenyLbl
    UILabel *moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, HeaderHeight + FH(20), ScreenWidth, FH(21))];
    moneyLbl.textAlignment = NSTextAlignmentCenter;
    moneyLbl.font = [UIFont boldSystemFontOfSize:18];
    moneyLbl.text = SWYNSStringFromFormat(@"￥%@",@"0.06");
    [self.view addSubview:moneyLbl];
    
    // moneyTitleLbl
    UILabel *moneyTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyLbl.frame) + FH(5), ScreenWidth, FH(21))];
    moneyTitleLbl.textAlignment = NSTextAlignmentCenter;
    moneyTitleLbl.font = [UIFont systemFontOfSize:14];
    moneyTitleLbl.textColor = TitleColor;
    moneyTitleLbl.text = @"累计消费（元）";
    [self.view addSubview:moneyTitleLbl];
    
    // _mTableView
    _mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyTitleLbl.frame) + FH(15), ScreenWidth, ScreenHeight - (CGRectGetMaxY(moneyTitleLbl.frame) + FH(15)) - TabBarHeight)];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_mTableView];
    
    [_mTableView registerClass:[LeijixiaofeiTableViewCell class] forCellReuseIdentifier:LeijixiaofeiTableViewCellIdentifier];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeijixiaofeiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LeijixiaofeiTableViewCellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LeijixiaofeiTableViewCell getCellHeight];
}

@end
