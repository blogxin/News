//
//  MainTableView.m
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import "MainTableView.h"
#import "UITableView+FDTemplateLayoutCell.h"


#define HOST @"http://api.budejie.com/api/api_open.php"

@implementation MainTableView

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [ZFPlayerView sharedPlayerView];
        //_playerView.delegate = self;
        // 当cell播放视频由全屏变为小屏时候，不回到中间位置
        _playerView.cellPlayerOnCenter = NO;
        
        // 当cell划出屏幕的时候停止播放
        //_playerView.stopPlayWhileCellNotVisable = YES;
        //（可选设置）可以设置视频的填充模式，默认为（等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
        // 静音
        // _playerView.mute = YES;
    }
    return _playerView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
       
        [self registerNib:[UINib nibWithNibName:@"MainTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        
        [self PostRequest];
    }
    return self;
}

-(void)PostRequest{
    NSDictionary *pragram = @{@"a":@"list",@"c":@"data",@"type":@"1"};
    [LXHttpRequest postWithURLString:HOST parameters:pragram success:^(id responseObject) {
        
        NSArray *resultArr = [responseObject objectForKey:@"list"];
         
        for (NSDictionary *dic in resultArr) {
            [self.dataArr addObject:[MainModel modelWithJSON:dic]];
        }
        
        [self reloadData];
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableCell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    _tableCell.modelList = self.dataArr[indexPath.row];
    
    _tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) myself = self;
    __block MainTableCell *weakcell = _tableCell;
    __block NSIndexPath *weakIndexPath = indexPath;
    _tableCell.cellBlock = ^(){
        if (![weakcell.modelList.videouri isEqualToString:@""]) {
        
        ZFPlayerModel *playerModle = [[ZFPlayerModel alloc] init];
        //playerModle.title = @"这是我的标题";
        playerModle.videoURL = [NSURL URLWithString:weakcell.modelList.videouri];
        playerModle.placeholderImageURLString = weakcell.modelList.image0;
        playerModle.tableView = myself;
        playerModle.indexPath = weakIndexPath;
        playerModle.fatherView = weakcell.contentImageView;
        
        [myself.playerView playerControlView:nil playerModel:playerModle];
        [myself.playerView autoPlayTheVideo];
        }
    };
    
    
    return _tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.mydelegate respondsToSelector:@selector(didSelectCellWithModel:)]) {
        [self.mydelegate didSelectCellWithModel:_dataArr[indexPath.row]];
    }
}

//设置每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CGFloat resultHeight = _tableCell.contentLable.frame.size.height + _tableCell.imageViewHeight.constant + _tableCell.resultHeight + 100;
    if (_tableCell.imageViewHeight.constant == 0 && _tableCell.resultHeight == 0) {
        return resultHeight - 10;
    }return resultHeight;
}


@end
