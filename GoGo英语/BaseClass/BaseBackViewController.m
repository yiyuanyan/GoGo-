//
//  BaseBackViewController.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "BaseBackViewController.h"

@interface BaseBackViewController ()

@end

@implementation BaseBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBackButton];
}
-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

@end
