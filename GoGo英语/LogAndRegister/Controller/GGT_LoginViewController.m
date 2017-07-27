//
//  GGT_LoginViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_LoginViewController.h"
#import "GGT_ForgotPasswordViewController.h"
#import "GGT_RegisterViewController.h"
#import "GGT_LoginView.h"
#import "GGT_HomeViewController.h"
@interface GGT_LoginViewController ()
@property(nonatomic, strong) GGT_LoginView *loginView;
@end

@implementation GGT_LoginViewController
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
    self.loginView = [[GGT_LoginView alloc] init];
    self.loginView.backgroundColor = [UIColor whiteColor];
    self.view = self.loginView;
    //存储手机号码
    if(!IsStrEmpty([UserDefaults() objectForKey:@"phoneNumber"])){
        self.loginView.phoneAccountField.text = [UserDefaults() objectForKey:@"phoneNumber"];
    }
    //忘记密码按钮
    @weakify(self);
    [[self.loginView.forgetPasswordButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        GGT_ForgotPasswordViewController *vc = [[GGT_ForgotPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //注册按钮
    [[self.loginView.registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        GGT_RegisterViewController *vc = [GGT_RegisterViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //登录
    [[self.loginView.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self loginLoadData];
    }];
}
-(void)loginLoadData{
    //需要先对文本放弃第一响应者
    [self.loginView.phoneAccountField resignFirstResponder];
    [self.loginView.passwordField resignFirstResponder];
    
    
    if(IsStrEmpty(self.loginView.phoneAccountField.text)) {
        [MBProgressHUD showMessage:@"请输入手机号码" toView:self.view];
        return;
    }
    
    
    BOOL isPhoneNum =   [NSString xc_isMobilePhone:self.loginView.phoneAccountField.text];
    //判断手机号是否合法
    if (isPhoneNum == NO) {
        [MBProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
        return;
    }
    
    
    //密码验证
    if(IsStrEmpty(self.loginView.passwordField.text) || self.loginView.passwordField.text.length <6 || self.loginView.passwordField.text.length >12) {
        [MBProgressHUD showMessage:@"请输入正确的登录密码（6-12位）" toView:self.view];
        return;
    }
    
    
    NSDictionary *postDic = @{@"UserName":self.loginView.phoneAccountField.text,@"PassWord":self.loginView.passwordField.text,@"OrgLink":IsStrEmpty([UserDefaults() objectForKey:K_registerID])?@"":[UserDefaults() objectForKey:K_registerID]};
    
    
    [[BaseService share] sendPostRequestWithPath:URL_Login parameters:postDic token:NO viewController:self success:^(id responseObject) {
        
        [UserDefaults() setObject:responseObject[@"data"][@"dicRes"][@"userToken"] forKey:K_userToken];
        [UserDefaults() setObject:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"dicRes"][@"studentName"]] forKey:K_studentName];
        [UserDefaults() setObject:self.loginView.phoneAccountField.text forKey:@"phoneNumber"];
        [UserDefaults() setObject:self.loginView.passwordField.text forKey:@"password"];
        [UserDefaults() synchronize];
        
        [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        
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
