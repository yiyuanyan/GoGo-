//
//  GGT_ForgotPasswordViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_ForgotPasswordViewController.h"
#import "GGT_ForgetPasswordView.h"
#import "UIButton+timer.h"
@interface GGT_ForgotPasswordViewController ()
@property(nonatomic, strong) GGT_ForgetPasswordView *forgetPasswordView;
@end

@implementation GGT_ForgotPasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
    self.navigationItem.title = @"忘记密码";
    self.forgetPasswordView = [GGT_ForgetPasswordView new];
    self.forgetPasswordView.backgroundColor = [UIColor whiteColor];
    self.view = self.forgetPasswordView;
    //获取验证码
    @weakify(self);
    [[self.forgetPasswordView.getCodeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self getCodeLoadData];
    }];
    //确认按钮
    [[self.forgetPasswordView.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self confirmLoadData];
    }];
}
-(void)confirmLoadData
{
    //放弃第一响应者
    [self.forgetPasswordView.phoneAccountField resignFirstResponder];
    [self.forgetPasswordView.verificationCodeField resignFirstResponder];
    [self.forgetPasswordView.passwordField resignFirstResponder];
    if(IsStrEmpty(self.forgetPasswordView.phoneAccountField.text)){
        [MBProgressHUD showMessage:@"请输入手机号码" toView:self.view];
        return ;
    }
    BOOL isPhoneNum = [NSString xc_isMobilePhone:self.forgetPasswordView.phoneAccountField.text];
    if(isPhoneNum == NO){
        [MBProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
        return ;
    }
    //验证码
    if(IsStrEmpty(self.forgetPasswordView.verificationCodeField.text)){
        [MBProgressHUD showMessage:@"验证码不能为空" toView:self.view];
        return;
    }
    //密码验证
    if(IsStrEmpty(self.forgetPasswordView.passwordField.text) || self.forgetPasswordView.passwordField.text.length < 6 || self.forgetPasswordView.passwordField.text.length > 12){
        [MBProgressHUD showMessage:@"请设置6-12位的登录密码" toView:self.view];
        return;
    }
    NSDictionary *postDic = @{@"cell":self.forgetPasswordView.phoneAccountField.text,@"code":self.forgetPasswordView.verificationCodeField.text,@"newPsw":self.forgetPasswordView.passwordField.text};
    [[BaseService share] sendPostRequestWithPath:URL_ChangePwdByCode parameters:postDic token:NO viewController:self success:^(id responseObject) {
        [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
        [self performSelector:@selector(turnToHomeClick) withObject:nil afterDelay:0.0f];
    } failure:^(NSError *error) {
        [MBProgressHUD showMessage:error.userInfo[@"msg"] toView:self.view];
    }];
}
-(void)turnToHomeClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 获取验证码
-(void)getCodeLoadData
{
    if(IsStrEmpty(self.forgetPasswordView.phoneAccountField.text)){
        [MBProgressHUD showMessage:@"请输入手机号码" toView:self.view];
        return ;
    }
    BOOL isPhoneNum = [NSString xc_isMobilePhone:self.forgetPasswordView.phoneAccountField.text];
    if(isPhoneNum == NO){
        [MBProgressHUD showMessage:@"请输入正确的手机号码" toView:self.view];
        return ;
    }
    //拼接地址
    NSString *cellStr = [NSString stringWithFormat:@"cell=%@",self.forgetPasswordView.phoneAccountField.text];
    NSString *urlStr = [NSString stringWithFormat:@"%@?%@",URL_GetChangePasswordSMS,cellStr];
    [[BaseService share] sendGetRequestWithPath:urlStr token:NO viewController:self success:^(id responseObject) {
        [self.forgetPasswordView.getCodeButton addTimer];
        [MBProgressHUD showMessage:responseObject[@"msg"] toView:self.view];
    } failure:^(NSError *error) {
        [MBProgressHUD showMessage:error.userInfo[@"msg"] toView:self.view];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
