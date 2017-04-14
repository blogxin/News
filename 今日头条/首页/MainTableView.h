//
//  MainTableView.h
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableCell.h"
#import <YYKit.h>
#import "LXHttpRequest.h"
#import "MainModel.h"
#import <ZFPlayer.h>

@protocol LXTableViewCellSelectDelegate <NSObject>

- (void)didSelectCellWithModel:(MainModel *)model;

@end

@interface MainTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) MainTableCell *tableCell;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) MainModel *model;

@property (nonatomic,strong) NSArray *arry;

@property (nonatomic,strong) ZFPlayerView *playerView;

@property (nonatomic,weak) id <LXTableViewCellSelectDelegate>mydelegate;

@end
