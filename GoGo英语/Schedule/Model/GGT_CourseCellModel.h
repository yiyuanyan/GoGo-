//
//  GGT_CourseCellModel.h
//  GoGo英语
//
//  Created by 何建新 on 2017/7/21.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGT_CourseCellModel : NSObject
@property (nonatomic, strong) NSString *FilePath;
@property (nonatomic, assign) NSInteger IsDemo;
@property (nonatomic, strong) NSString *LessonId;
@property (nonatomic, strong) NSString *LessonName;
@property (nonatomic, strong) NSString *StartTime;
@property (nonatomic, strong) NSString *StartTimeStamp;
@property (nonatomic, strong) NSString *Status;
@property (nonatomic, strong) NSString *TeacherName;

@property (nonatomic, assign) NSInteger CountDown; // 倒计时
@property (nonatomic, strong) NSString *Remark;     // 学生评价内容
@property (nonatomic, assign) NSInteger StuLikeTchStar; //学生对老师的好评
@property (nonatomic, assign) NSInteger SturememberStar;    // 学生对上课的记忆程度
@property (nonatomic, assign) NSInteger StuScore;       //老师对学生的评价
@property (nonatomic, strong) NSString *ImageUrl;   // 老师头像
@property (nonatomic, strong) NSString *LateTime;

@property (nonatomic, strong) NSString *Age;
@property (nonatomic, strong) NSString *Gender;

@property (nonatomic, assign) NSInteger IsComment;
@property (nonatomic, assign) NSInteger IsStuComment;
@end
