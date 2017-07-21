//
//  BaseViewController.h
//  GoGo英语
//
//  Created by 何建新 on 2017/7/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
//左侧返回按钮
-(void)setLeftBackButton;
//导航左侧图片
-(void)setLeftItem:(NSString *)imageName;
//导航左侧，图片带文字
-(void)setLeftItem:(NSString *)imageName title:(NSString *)title;
//导航右侧文字
-(void)setRightBarButtonItemTitle:(NSString *)title;
//导航右侧图片
-(void)setRightButtonWithImg:(NSString *)imageName;
//左侧按钮点击事件
-(void)leftAction;
//右侧按钮的点击事件
-(void)rightAction;
@end
