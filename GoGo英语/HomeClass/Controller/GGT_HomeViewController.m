//
//  GGT_HomeViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_HomeViewController.h"
#import "GGT_HomeLeftView.h"
#import "GGT_ScheduleViewController.h"
#import "GGT_MineSplitViewController.h"
#import "GGT_CheckDevicePopViewController.h"
//#import "GGT_PreviewCourseAlertView.h"
#import "BaseNavigationController.h"
@interface GGT_HomeViewController ()<UIPopoverPresentationControllerDelegate>
@property(nonatomic, strong) GGT_HomeLeftView *xc_leftView;
@property(nonatomic, strong) GGT_ScheduleViewController *scheduleVc;
@property(nonatomic, strong) GGT_MineSplitViewController *mineVc;
@property(nonatomic, strong) BaseNavigationController *xc_nav;
@property(nonatomic, strong) UIViewController *currentVc;
@end

@implementation GGT_HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushKebiaoWithNotification:) name:@"kebiao" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushMineWithNotification:) name:@"mine" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTestReportWithNotification:) name:@"testReportl" object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"kebiao" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"mine" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"testReportl" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    [self setUpNewController];
}
-(void)setUpNewController
{
    self.scheduleVc = [GGT_ScheduleViewController new];
    self.xc_nav = [[BaseNavigationController alloc] initWithRootViewController:self.scheduleVc];
    [self.xc_nav.view setFrame:CGRectMake(self.xc_leftView.width, 0, SCREEN_WIDTH()-self.xc_leftView.width, SCREEN_HEIGHT())];
    [self addChildViewController:self.xc_nav];
    self.mineVc = [[GGT_MineSplitViewController alloc] init];
    [self.mineVc.view setFrame:CGRectMake(self.xc_leftView.width, 0, SCREEN_WIDTH()-self.xc_leftView.width, SCREEN_HEIGHT())];
    [self.view addSubview:self.xc_nav.view];
    self.currentVc = self.xc_nav;
}
#pragma mark --- pushMessageAction
-(void)pushKebiaoWithNotification:(NSNotification *)noti{
    NSLog(@"--%@",noti.userInfo);
    UIButton *button1 = [self.xc_leftView viewWithTag:100];
    button1.selected = YES;
    UIButton *button2 = [self.xc_leftView viewWithTag:101];
    button2.selected = NO;
    if(self.currentVc == self.xc_nav){
        return;
    }else{
        [self replaceController:self.currentVc newController:self.xc_nav];
    }
}
-(void)pushMineWithNotification:(NSNotification *)noti{
    UIButton *button = [self.xc_leftView viewWithTag:101];
    button.selected = YES;
    UIButton *button1 = [self.xc_leftView viewWithTag:100];
    button1.selected = NO;
    if(self.currentVc == self.mineVc){
        return;
    }else{
        [self replaceController:self.currentVc newController:self.mineVc];
    }
}
-(void)pushTestReportWithNotification:(NSNotification *)noti{
    UIButton *button = [self.xc_leftView viewWithTag:101];
    button.selected = YES;
    UIButton *button1 = [self.xc_leftView viewWithTag:100];
    button1.selected = NO;
    if(self.currentVc == self.mineVc){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testReport2" object:self userInfo:noti.userInfo];
        return;
    }else{
        [self replaceController:self.currentVc newController:self.mineVc];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testReport2" object:self userInfo:noti.userInfo];
    }
}
//切换各个标签内容
-(void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.3f options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        if(finished){
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVc = newController;
        }else{
            self.currentVc = oldController;
        }
    }];
}
-(void)initView{
    @weakify(self);
    self.xc_leftView = [GGT_HomeLeftView new];
    self.xc_leftView = [[GGT_HomeLeftView alloc] initWithFrame:CGRectMake(0, 0, LineW(home_leftView_width), SCREEN_HEIGHT())];
    [self.view addSubview:self.xc_leftView];
    self.xc_leftView.buttonClickBlock = ^(UIButton *button) {
        @strongify(self);
        switch (button.tag) {
            case 100:
                {
                    if(self.currentVc == self.xc_nav){
                        return ;
                    }else{
                        [self replaceController:self.currentVc newController:self.xc_nav];
                    }
                }
                break;
            case 101:
                {
                    if(self.currentVc == self.mineVc){
                        return;
                    }else{
                        [self replaceController:self.currentVc newController:self.mineVc];
                    }
                }
                break;
            case 102:
                {
                    GGT_CheckDevicePopViewController *vc = [GGT_CheckDevicePopViewController new];
                    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
                    nav.modalPresentationStyle = UIModalPresentationFormSheet;
                    nav.popoverPresentationController.delegate = self;
                    [self presentViewController:nav animated:YES completion:nil];
                }
                break;
            case 103:
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"联系客服" message:@"请拨打电话：400-8787-276" preferredStyle:UIAlertControllerStyleAlert];
                    alert.titleColor = UICOLOR_FROM_HEX(0x000000);
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
                    cancelAction.textColor = UICOLOR_FROM_HEX(ColorC40016);
                    [alert addAction:cancelAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                break;
            default:
                break;
        }
    };
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
