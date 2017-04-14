//
//  MainTableCell.m
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import "MainTableCell.h"
#import "YYPhotoGroupView.h"
#import <Masonry.h>
#import <YYKit.h>

#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"] || [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)?YES:NO

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@implementation MainTableCell
- (NSMutableDictionary *)cacheDictory{
    if (!_cacheDictory) {
        _cacheDictory = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _cacheDictory;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    
    _gifLable = [[UILabel alloc] init];
    _gifLable.textColor = [UIColor whiteColor];
    _gifLable.textAlignment = NSTextAlignmentCenter;
    _gifLable.font = [UIFont fontWithName:@"Arial"  size:14];
    _gifLable.backgroundColor = RGBACOLOR(115, 149, 189, 1);
    [_contentImageView addSubview:_gifLable];
    
    _longPicLable = [[UILabel alloc] init];
    _longPicLable.textColor = [UIColor whiteColor];
    _longPicLable.textAlignment = NSTextAlignmentCenter;
    _longPicLable.font = [UIFont fontWithName:@"Arial"  size:14];
    _longPicLable.backgroundColor = RGBACOLOR(115, 149, 189, 1);
    [_contentImageView addSubview:_longPicLable];
    
    _contentImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_contentImageView addGestureRecognizer:tap];
    
    self.playBtn = [[UIButton alloc] init];
    [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
    [self.playBtn addTarget:self action:@selector(playBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentImageView addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentImageView);
        make.width.height.mas_equalTo(50);
    }];
}

- (void)playBtnAction{
    self.cellBlock();
}

- (void)tapAction{
    
    if (STRING_ISNIL(_modelList.videouri)) {
        
    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
    item.thumbView         = _contentImageView;
    item.largeImageURL     = [NSURL URLWithString:_modelList.image0];
    YYPhotoGroupView *view = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
    UIView *toView         = [UIApplication sharedApplication].keyWindow.rootViewController.view;
    [view presentFromImageView:_contentImageView
                   toContainer:toView
                      animated:YES completion:nil];
        
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setModelList:(MainModel *)modelList{
    _modelList = modelList;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:modelList.profile_image] placeholderImage:[UIImage imageNamed:@"hold"]];
    
    _nameLable.text = modelList.name;
    
    _timeLable.text = modelList.created_at;

    self.contentLable.text = modelList.text;
    
    self.contentLable.font = [UIFont fontWithName:@"Arial" size:16];

    NSDictionary *attrs = @{NSFontAttributeName:_contentLable.font};
        
    CGSize maxSize = CGSizeMake(Width - 35 , MAXFLOAT);
    
    CGSize size = [_contentLable.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    NSLog(@"%f ->%f",size.height,size.width);

    self.contentLable.frame = CGRectMake(_contentLable.frame.origin.x, _contentLable.frame.origin.y, Width - 35, size.height);
    
    
    CGFloat sum = [modelList.width floatValue] / [modelList.height floatValue];
    CGFloat scale = 12.0 / 9.0;
    
    if ([modelList.width isEqualToString:@"0"]) {
        _imageViewHeight.constant = 0;
    }else{
    if (sum > 1.0) {
        if (![modelList.videouri isEqualToString:@""]) {
            _imageViewWidth.constant = Width - 30;
        }else{
            _imageViewWidth.constant = (Width - 10) / 2 * scale;
        }
        _imageViewHeight.constant = (Width - 10) / 2 + 15;
    }else{
        _imageViewWidth.constant = (Width - 10) / 2;
        _imageViewHeight.constant = (Width - 10) / 2 * scale;
        }
    }

    if ([modelList.is_gif boolValue]) {
        _gifLable.hidden = NO;
        _gifLable.text = @"GIF";
        _gifLable.frame = CGRectMake(_imageViewWidth.constant - 30, _imageViewHeight.constant - 17, 30, 17);
    }else{
        _gifLable.hidden = YES;
    }

    if (!_modelList.image0) {
        [_contentImageView setHidden:YES];
    }else{
        [_contentImageView setHidden:NO];

         if ([_modelList.height floatValue] > 1500) {
         
         NSURL *url = [NSURL URLWithString:_modelList.image0];
         
         __weak typeof(self) myself = self;

         [_contentImageView sd_setImageWithURL:url
         placeholderImage:[UIImage imageNamed:@"hold"]
         options:SDWebImageAvoidAutoSetImage
         completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             
         UIImage *resultImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, 0, Height , Height))];
         myself.contentImageView.image = resultImage;
             
         }];
         
         _longPicLable.hidden = NO;
         _longPicLable.text = @"长图";
         _longPicLable.frame = CGRectMake(_imageViewWidth.constant - 30, _imageViewHeight.constant - 17, 30, 17);
         
         }else{
         
         _longPicLable.hidden = YES;
         if (STRING_ISNIL(modelList.gifFistFrame)) {
             [_contentImageView sd_setImageWithURL:[NSURL URLWithString:modelList.image0] placeholderImage:[UIImage imageNamed:@"hold"]];
         }else{
             [_contentImageView sd_setImageWithURL:[NSURL URLWithString:modelList.gifFistFrame] placeholderImage:[UIImage imageNamed:@"hold"]];
             }
         }
      }

        if ([modelList.videouri isEqualToString:@""]) {
            self.playBtn.hidden = YES;
        }else{
            self.playBtn.hidden = NO;
        }

}


- (UIImage *)compressImage:(UIImage *)sourceImage toTargetScale:(CGFloat)scale {
    CGSize imageSize = sourceImage.size;
    CGFloat width    = imageSize.width;
    CGFloat height   = imageSize.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(width * scale, height * scale));
    [sourceImage drawInRect:CGRectMake(0, 0, width * scale, height * scale)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
- (UIImage *)cutImage:(UIImage *)image{
    CGRect rect = CGRectMake(0, 0, 768, 1024);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //设置当前绘图环境到矩形框
    CGContextClipToRect(currentContext, rect);
    
    CGContextDrawImage(currentContext, rect, image.CGImage);//绘图
    
    UIImage *
}
 */

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
