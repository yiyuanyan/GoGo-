//
//  GGT_LoginView.h
//  GoGo英语
//
//  Created by 何建新 on 2017/7/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGT_LoginView : UIView<UITextFieldDelegate>
//手机账号view
@property(nonatomic, strong) UIView *phoneAccountView;
//手机icon
@property(nonatomic, strong) UIImageView *phoneImageView;
//手机输入框
@property(nonatomic, strong) UITextField *phoneAccountField;
//手机号的分割线
@property(nonatomic, strong) UIView *phonelineView;

//密码view
@property(nonatomic, strong) UIView *passwordView;
//密码icon
@property(nonatomic, strong) UIImageView *passwordImageView;
//密码输入框
@property(nonatomic, strong) UITextField *passwordField;
//密码分割线
@property(nonatomic, strong) UIView *passwordlineView;
//忘记密码
@property(nonatomic, strong) UIButton *forgetPasswordButton;
//登录
@property(nonatomic, strong) UIButton *loginButton;
//注册
@property(nonatomic, strong) UIButton *registerButton;
@end
