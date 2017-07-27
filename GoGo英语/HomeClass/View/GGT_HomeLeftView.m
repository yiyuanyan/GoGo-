//
//  GGT_HomeLeftView.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/26.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_HomeLeftView.h"

@implementation GGT_HomeLeftView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}
//设置按钮图片在上文字在下
-(void)initButton:(UIButton *)btn{
    //按钮文字颜色
    [btn setTitleColor:UICOLOR_FROM_HEX(0x777777) forState:UIControlStateNormal];
    [btn setTitleColor:UICOLOR_FROM_HEX(0xC40016) forState:UIControlStateSelected];
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    CGFloat totalHeight = LineH(55);
    btn.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - LineH(imageSize.height)), 0.0, 0.0, -LineW(titleSize.width));
    btn.titleEdgeInsets = UIEdgeInsetsMake(LineH(7), -LineW(imageSize.width), totalHeight-LineH(17), 0);
}


-(void)initView{
    //设置view背景色
    self.backgroundColor = UICOLOR_FROM_HEX(0x2C2C2C);
    //icon
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.image = UIIMAGE_FROM_NAME(@"logo_daohanglan");
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(LineY(32));
        make.size.mas_offset(CGSizeMake(LineW(68), LineH(21)));
    }];
    self.optionsView = [[UIView alloc] init];
    [self addSubview:self.optionsView];
    [self.optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(LineY(163));
        make.height.mas_offset(LineH(166));
    }];
}
@end
