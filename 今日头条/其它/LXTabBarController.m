//
//  LXTabBarController.m
//  今日头条
//
//  Created by MyOS on 17/3/15.
//  Copyright © 2017年 XXXX. All rights reserved.
//

#import "LXTabBarController.h"
#import "MainViewController.h"
#import "OtherViewController.h"

@interface LXTabBarController ()

@end

@implementation LXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTabBarWithController:[[MainViewController alloc] init] Title:@"首页" Image:@"tab_home_icon_nor" selectImage:@"tab_home_icon"];
    [self addTabBarWithController:[[OtherViewController alloc] init] Title:@"我的" Image:@"tab_mine_icon_nor" selectImage:@"tab_mine_icon"];
    
}

- (void)addTabBarWithController:(UIViewController *)vc Title:(NSString *)title Image:(NSString *)image selectImage:(NSString *)selectImage{
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
