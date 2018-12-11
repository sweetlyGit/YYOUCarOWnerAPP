//
//  YYOUTabBarViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUTabBarViewController.h"
#import "YYOUCarHomeViewController.h"
#import "YYOUCarControlViewController.h"
#import "YYOUCarUserCenterViewController.h"
#import "YYOUServiceViewController.h"
#import "YYOUCommonHeader.h"
@interface YYOUTabBarViewController ()

@end

@implementation YYOUTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBarTintColor:RGB(249, 249, 249)];
    YYOUCarHomeViewController *homeViewController = [[YYOUCarHomeViewController alloc] init];
    [self createVC:homeViewController Title:@"首页" imageName:@"icon_home"];
    
    YYOUCarControlViewController *carControlViewController = [[YYOUCarControlViewController alloc] init];
    [self createVC:carControlViewController Title:@"车辆" imageName:@"tabbar_car"];
    
    YYOUServiceViewController *serviceControlViewController = [[YYOUServiceViewController alloc] init];
    [self createVC:serviceControlViewController Title:@"服务" imageName:@"icon_service"];
    
    YYOUCarUserCenterViewController *userCenterViewController = [[YYOUCarUserCenterViewController alloc] init];
    [self createVC:userCenterViewController Title:@"我的" imageName:@"icon_my"];
}
- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName
{
    vc.title = title;
    self.tabBar.tintColor = [UIColor colorWithRed:56/255.0 green:139/255.0 blue:250/255.0 alpha:1];
    self.tabBar.translucent = NO;
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",imageName]];
    NSString *imageSelect = [NSString stringWithFormat:@"%@_selected",imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:vc]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
