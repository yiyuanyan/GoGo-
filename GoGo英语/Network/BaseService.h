//
//  BaseService.h
//  GoGo英语
//
//  Created by 何建新 on 2017/7/20.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "GGT_LoginViewController.h"
typedef void(^AFNSuccessResponse) (id responseObject);
typedef void(^AFNFailureResponse) (NSError *error);
typedef void(^AFNBOOLResponse) (BOOL result);

typedef NS_ENUM(NSInteger,HttpRequestType) {
    XCHttpRequestGet,
    XCHttpRequestPost,
    XCHttpRequestDelete,
    XCHttpRequestPut,
};

@interface BaseService : NSObject
/**
 *网络状态
 */
@property(nonatomic, assign) AFNetworkReachabilityStatus netWorkStatus;
//请求管理者
@property(nonatomic, strong) AFHTTPSessionManager *manager;
+(instancetype)share;

-(void)requestWithPath:(NSString *)url
                method:(NSInteger)method
            parameters:(id)parameters
                 token:(BOOL)isLoadToken
        viewController:(UIViewController *)viewController
               success:(AFNSuccessResponse)success
               failure:(AFNFailureResponse)failure;
//POST 带MBP
-(void)sendPostRequestWithPath:(NSString *)url
                    parameters:(NSDictionary *)parameters
                         token:(BOOL)isLoadToken
                viewController:(UIViewController *)viewController
                       success:(AFNSuccessResponse)success
                       failure:(AFNFailureResponse)failure;
//GET 带MBP
-(void)sendGetRequestWithPath:(NSString *)url
                        token:(BOOL)isLoadToken
               viewController:(UIViewController *)viewController
                      success:(AFNSuccessResponse)success
                      failure:(AFNFailureResponse)failure;
//POST 不带MBP
-(void)sendPostRequestWithPath:(NSString *)url
                    parameters:(NSDictionary *)parameters
                         token:(BOOL)isLoadToken
                viewController:(UIViewController *)viewController
                showMBProgress:(BOOL)isShow
                       success:(AFNSuccessResponse)success
                       failure:(AFNFailureResponse)failure;
//GET 不带MBP
-(void)sendGetRequestWithPath:(NSString *)url token:(BOOL)isLoadToken viewController:(UIViewController *)viewController showMBProgress:(BOOL)isShow success:(AFNSuccessResponse)success failure:(AFNFailureResponse)failure;
@end
