//
//  MainViewController.h
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MWPhotoBrowser.h>
#import "MainModel.h"

@interface MainViewController : UIViewController

@property (nonatomic,strong)MWPhotoBrowser *browser;

@property (nonatomic,strong)NSMutableArray *photoArr;

@property (nonatomic,strong)MainModel *mainModel;

@end
