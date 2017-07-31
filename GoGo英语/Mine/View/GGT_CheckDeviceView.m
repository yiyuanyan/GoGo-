//
//  GGT_CheckDeviceView.m
//  GoGo英语
//
//  Created by 何建新 on 2017/7/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import "GGT_CheckDeviceView.h"
#import <AVFoundation/AVFoundation.h>
@implementation GGT_CheckDeviceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}
-(void)initView{
    //照相机
    _cameraBigImgView = [UIImageView new];
    [self addSubview:_cameraBigImgView];
    [_cameraBigImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LineX(60));
        make.top.equalTo(self.mas_top).with.offset(LineY(40));
        make.size.mas_offset(CGSizeMake(LineW(60), LineW(60)));
    }];
    _camerasmallImgView = [[UIImageView alloc] init];
    _camerasmallImgView.image = UIIMAGE_FROM_NAME(@"camera_Inthetest");
    [_cameraBigImgView addSubview:_camerasmallImgView];
    [_camerasmallImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_cameraBigImgView.mas_centerX);
        make.centerY.equalTo(_cameraBigImgView.mas_centerY);
        make.size.mas_offset(CGSizeMake(LineW(32), LineW(26)));
    }];
    //麦克风
    _microphoneBigImgView = [UIImageView new];
    _microphoneBigImgView.image = UIIMAGE_FROM_NAME(@"voice_Waiting_for_the");
    [self addSubview:_microphoneBigImgView];
    [_microphoneBigImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(LineY(40));
        make.size.mas_offset(CGSizeMake(LineH(60), LineW(60)));
    }];
    _microphonesmallImgView = [UIImageView new];
    _microphonesmallImgView.image = UIIMAGE_FROM_NAME(@"voice_In_the_test");
    [_microphoneBigImgView addSubview:_microphonesmallImgView];
    _microphonesmallImgView.hidden = YES;
    [_microphonesmallImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_microphoneBigImgView.mas_centerX);
        make.centerY.equalTo(_microphoneBigImgView.mas_centerY);
        make.size.mas_offset(CGSizeMake(LineW(23), LineH(32)));
    }];
}
@end
