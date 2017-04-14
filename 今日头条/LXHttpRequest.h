//
//  LXHttpRequest.h
//  海安中学
//
//  Created by MyOS on 16/11/22.
//  Copyright © 2016年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXHttpRequest : NSObject

//GET请求
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


//POST请求
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

@end
