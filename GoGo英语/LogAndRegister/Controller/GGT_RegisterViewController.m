//
//  GGT_RegisterViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_RegisterViewController.h"
#import "GGT_RegisterView.h"
#import "GGT_HomeViewController.h"
@interface GGT_RegisterViewController ()
@property(nonatomic, strong) GGT_RegisterView *registerView;
@end

@implementation GGT_RegisterViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    self.registerView = [GGT_RegisterView new];
    self.registerView.backgroundColor = [UIColor whiteColor];
    self.view = self.registerView;
    //返回按钮
    @weakify(self);
    [[self.registerView.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //注册
    [[self.registerView.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self registerLoadData];
    }];
}
#pragma mark 注册
-(void)registerLoadData
{
    [self.registerView.phoneAccountField resignFirstResponder];
    [self.registerView.passwordField resignFirstResponder];
    if(IsStrEmpty(self.registerView.phoneAccountField.text)){
        [MBProgressHUD showMessage:@"请输入手机号码" toView:self.view];
        return;
    }
    if([NSString xc_isMobilePhone:self.registerView.phoneAccountField.text]){
        [MBProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    if(IsStrEmpty(self.registerView.passwordField.text) || self.registerView.passwordField.text.length < 6 || self.registerView.passwordField.text.length > 12){
        [MBProgressHUD showMessage:@"请设置6-12位的登录密码" toView:self.view];
        return;
    }
    NSDictionary *postDic = @{@"UserNmae":self.registerView.phoneAccountField.text,@"Password":self.registerView.passwordField.text,@"OrgLink":IsStrEmpty([UserDefaults() objectForKey:K_registerID])?@"":[UserDefaults() objectForKey:K_registerID]};
    [[BaseService share] sendPostRequestWithPath:URL_Resigt parameters:postDic token:NO viewController:self success:^(id responseObject) {
        [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        [UserDefaults() setObject:responseObject[@"data"][@"userToken"] forKey:K_userToken];
        [UserDefaults() setObject:self.registerView.phoneAccountField.text forKey:@"phoneNumber"];
        [UserDefaults() synchronize];
        [self performSelector:@selector(turnToHomeClick) withObject:nil afterDelay:0.0f];
    } failure:^(NSError *error) {
        [MBProgressHUD showMessage:error.userInfo[@"msg"] toView:self.view];
    }];
}
-(void)turnToHomeClick
{
    [UserDefaults() setObject:@"yes" forKey:@"login"];
    [UserDefaults() synchronize];
    GGT_HomeViewController *homeVc = [GGT_HomeViewController new];
    [self.navigationController pushViewController:homeVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
