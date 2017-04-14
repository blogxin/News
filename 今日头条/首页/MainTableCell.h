//
//  MainTableCell.h
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef void(^CellClickBlock)();

@interface MainTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;

@property (nonatomic, strong) UILabel *gifLable;

@property (nonatomic, strong) UILabel *longPicLable;

@property (nonatomic,strong) MainModel *modelList;

@property (nonatomic,strong) NSMutableDictionary *cacheDictory;


@property (nonatomic ,assign) CGFloat resultHeight;

@property (nonatomic ,strong) UIButton *playBtn;

@property (nonatomic, copy) CellClickBlock cellBlock;

@end
