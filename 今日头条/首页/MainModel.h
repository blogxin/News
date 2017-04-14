//
//  MainModel.h
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MainModel : NSObject

//用户名
@property (nonatomic,copy)NSString *name;

//文字内容
@property (nonatomic,copy)NSString *text;

//创建时间
@property (nonatomic,copy)NSString *created_at;

//图片
@property (nonatomic,copy)NSString *image0;

@property (nonatomic,copy)NSString *gifFistFrame;

//头像
@property (nonatomic,copy)NSString *profile_image;

//视频链接
@property (nonatomic,copy)NSString *videouri;

@property (nonatomic,copy)NSString *height;

@property (nonatomic,copy)NSString *width;

@property (nonatomic,copy)NSString *list;

@property (nonatomic,copy)NSString *is_gif;

@property (nonatomic,copy)NSString *id;





@end
