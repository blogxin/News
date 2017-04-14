//
//  MainViewController.m
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableView.h"
#import "YYPhotoGroupView.h"
#import "YYFPSLabel.h"


@interface MainViewController ()<LXTableViewCellSelectDelegate>

@property(nonatomic,strong)MainTableView *tableView;
@property(nonatomic,strong)YYFPSLabel *fpsLable;

@end

@implementation MainViewController

- (NSMutableArray *)photoArr{
    if (!_photoArr) {
        _photoArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[MainTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.mydelegate = self;
    
    _fpsLable = [YYFPSLabel new];
    [_fpsLable sizeToFit];
    self.navigationItem.titleView = _fpsLable;
    
    
    [self.view addSubview:self.tableView];
}

- (void)didSelectCellWithModel:(MainModel *)model{
    if ([model.image0 isEqualToString:@""]) {
        return;
    }

    
    /*
    YYPhotoGroupItem *item = [YYPhotoGroupItem new];
    item.thumbView = _tableView.tableCell.contentImageView;
    item.largeImageURL = [NSURL URLWithString:model.image0];
    YYPhotoGroupView *view = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
    //view.blurEffectBackground = NO;
    [view presentFromImageView:_tableView.tableCell.contentImageView toContainer:self.navigationController.view animated:YES completion:nil];
     */
    /*
    self.browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    //设置当前要显示的图片
    [self.browser setCurrentPhotoIndex:1];
    
    self.mainModel = model;
    [self.navigationController pushViewController:self.browser animated:YES];
     */
}
/*
//返回图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:self.mainModel.image0]];
    return photo;
}
*/
@end
