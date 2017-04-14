//
//  LXHttpRequest.m
//  海安中学
//
//  Created by MyOS on 16/11/22.
//  Copyright © 2016年 XXXX. All rights reserved.
//

#import "LXHttpRequest.h"
#import <AFNetworking.h>


@implementation LXHttpRequest

+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer.timeoutInterval = 5;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",nil];
    [manger GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer.timeoutInterval = 5;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",nil];
    [manger POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSData *)data
                    success:(void (^)())success
                    failure:(void (^)(NSError *))failure {
    /*
     需要先设置AFSecurityPolicy类，AFSecurityPolicy封装了对证书的校验过程
     AFSecurityPolicy分为三种验证模式：
     AFSSLPinningModeNone:只是验证证书是否在信任列表中
     AFSSLPinningModeCertificate:该模式会验证证书是否在信任列表中，然后再对比服务端证书和客户端证书是否一致
     AFSSLPinningModePublicKey:只验证服务端证书与客户端证书公钥是否一致
     */
    AFHTTPSessionManager *mannger = [AFHTTPSessionManager manager];
    mannger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //设置证书模式
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    mannger.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData,nil]];
    
    //客户端是否信任非法证书
    mannger.securityPolicy.allowInvalidCertificates = YES;
    
    //是否在证书域字段中验证域名
    [mannger.securityPolicy setValidatesDomainName:NO];
    
    
    }






















@end
