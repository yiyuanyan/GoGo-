//
//  BaseViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航颜色
    self.navigationController.navigationBar.barTintColor = UICOLOR_FROM_HEX(ColorC40016);
    //设置导航不透明
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Font(20),NSFontAttributeName,UICOLOR_FROM_HEX(ColorFFFFFF),NSForegroundColorAttributeName, nil]];
}
#pragma mark 左侧返回按钮
-(void)setLeftBackButton
{
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width =  0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,imageItem];
}
#pragma mark 导航左侧图片
-(void)setLeftItem:(NSString *)imageName
{
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    negativeSpacer.width = 0;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,imageItem];
}
#pragma mark 导航左侧，图片带文字
-(void)setLeftItem:(NSString *)imageName title:(NSString *)title
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:title forState:UIControlStateNormal];
    [leftBtn setImage:UIIMAGE_FROM_NAME(imageName) forState:UIControlStateNormal];
    [leftBtn setImage:UIIMAGE_FROM_NAME(imageName) forState:UIControlStateHighlighted];
    [leftBtn setTitleColor:UICOLOR_FROM_HEX(ColorFFFFFF) forState:UIControlStateNormal];
    [leftBtn setTitleColor:UICOLOR_FROM_HEX(ColorFFFFFF) forState:UIControlStateHighlighted];
    leftBtn.frame = CGRectMake(0, 0, LineW(86), LineH(44));
    leftBtn.titleLabel.font = Font(16);
    //设置图片位置
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    //设置文字位置
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, LineW(11), 0, -LineW(11));
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = rightItem;
}
#pragma mark 导航右侧文字
-(void)setRightBarButtonItemTitle:(NSString *)title
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn setTitleColor:UICOLOR_FROM_HEX(ColorFFFFFF) forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, LineW(44), LineH(44));
    rightBtn.titleLabel.font = Font(16);
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = -LineX(5);
    self.navigationItem.rightBarButtonItems = @[spacer,rightItem];
}
#pragma mark 导航右侧图片
-(void)setRightButtonWithImg:(NSString *)imageName
{
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    UIBarButtonItem *navSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    navSpace.width = -LineX(5);
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:navSpace,imageItem, nil];
}
#pragma mark 左侧按钮点击事件
-(void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 右侧按钮点击事件
-(void)rightAction{
    
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(void)dealloc
{
    NSLog(@"控制器---%@---销毁了",[self class]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
