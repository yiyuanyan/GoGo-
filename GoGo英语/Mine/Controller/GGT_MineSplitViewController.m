//
//  GGT_MineSplitViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_MineSplitViewController.h"
#import "GGT_MineLeftViewController.h"
#import "GGT_MineRightViewController.h"
@interface GGT_MineSplitViewController ()<UISplitViewControllerDelegate>

@end

@implementation GGT_MineSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(ColorFFFFFF);
    GGT_MineLeftViewController *mineLeftVc = [GGT_MineLeftViewController new];
    GGT_MineRightViewController *mineRightVc = [GGT_MineRightViewController new];
    BaseNavigationController *detailNav = [[BaseNavigationController alloc] initWithRootViewController:mineRightVc];
    self.viewControllers = @[mineLeftVc,detailNav];
    //使用UISplitViewController前，第一步设置viewControllers数组，然后在设置其他属性
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
