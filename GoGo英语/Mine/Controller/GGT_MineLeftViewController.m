//
//  GGT_MineLeftViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/8/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineLeftViewController.h"
#import "GGT_SelfInfoViewController.h"
#import "GGT_MineClassViewController.h"
#import "GGT_FeedbackViewController.h"
#import "GGT_TestReportViewController.h"
#import "GGT_SettingViewController.h"
#import "GGT_MineHeaderView.h"
#import "GGT_MineLeftModel.h"
#import "GGT_CourseDetailsViewController.h"

static BOOL isShowTestReportVc;
@interface GGT_MineLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *iconArray;
@property(nonatomic, strong) GGT_MineHeaderView *headerView;
@property(nonatomic, strong) GGT_MineLeftModel *model;
@end

@implementation GGT_MineLeftViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTestReportWithNotification:) name:@"testReport2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushChangeNameWithNotification:) name:@"changeNameStatus" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"testReport2" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeNameStatus" object:nil];
}
#pragma mark -- pushMessageAction
-(void)pushTestReportWithNotification:(NSNotification *)noti
{
    isShowTestReportVc = YES;
    [self getLoadData];
}
-(void)pushChangeNameWithNotification:(NSNotification *)noti
{
    [self getLoadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isShowTestReportVc = NO;
    self.splitViewController.maximumPrimaryColumnWidth = LineW(350);
    self.splitViewController.preferredPrimaryColumnWidthFraction = 0.48;
    [self getLeftName];
    [self initTableView];
    [self getLoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 获取左边的名称和icon
-(void)getLeftName
{
    [[BaseService share] sendGetRequestWithPath:URL_GetInfo token:YES viewController:self success:^(id responseObject) {
        _dataArray = [NSMutableArray array];
        _iconArray = [NSMutableArray array];
        NSArray *dataArr = responseObject[@"data"];
        for(NSDictionary *dic in dataArr){
            [_dataArray addObject:dic[@"name"]];
            [_iconArray addObject:dic[@"pic"]];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showMessage:error.userInfo[@"msg"] toView:self.view];
    }];
}
#pragma mark 获取网络请求，添加到view上
-(void)getLoadData
{
    [[BaseService share] sendGetRequestWithPath:URL_GetLessonStatistics token:YES viewController:self success:^(id responseObject) {
        self.model = [GGT_MineLeftModel yy_modelWithDictionary:responseObject[@"data"]];
        [_headerView getResultModel:self.model];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)initTableView{
    
}
@end
