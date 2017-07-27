//
//  GGT_HomeLeftView.h
//  GoGo英语
//
//  Created by 何建新 on 2017/7/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^XCButtonClickBlock)(UIButton *button);
@interface GGT_HomeLeftView : UIView
@property(nonatomic, copy)XCButtonClickBlock buttonClickBlock;
//课表
@property(nonatomic, strong) UIView *optionsView;

@end
