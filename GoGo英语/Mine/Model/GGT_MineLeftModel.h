//
//  GGT_MineLeftModel.h
//  GoGo英语
//
//  Created by 何建新 on 2017/8/1.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGT_MineLeftModel : NSObject
//迟到
@property(nonatomic, assign) NSInteger chi;
//已说
@property(nonatomic, assign) NSInteger que;
//缺席
@property(nonatomic, assign) NSInteger shuo;
//lv
@property(nonatomic, assign) NSInteger lv;
//isVIP
@property(nonatomic, assign) NSInteger isVip;
//剩余课时
@property(nonatomic, assign) NSInteger totalCount;
//姓名
@property(nonatomic, copy) NSString *Name;
//头像
@property(nonatomic, copy) NSString *ImageUrl;
@end
