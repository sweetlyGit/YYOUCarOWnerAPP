//
//  YYOUCarSettingViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarSettingViewController.h"
#import "YYOUCarSettingView.h"
#import "YYOUCarUserInfoManager.h"
#import "YYOUCarUIUtils.h"
@interface YYOUCarSettingViewController ()

@end

@implementation YYOUCarSettingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super naviGationBarColor:THEME_NAVCOLOR title:@"设置" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:nil];
    YYOUCarSettingView *settingView = [[YYOUCarSettingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    WEAK_SELF
    settingView.loginOut = ^{
        //清除用户信息
        [YYOUCarUserInfoManager loginOut];
        [YYOUCarUIUtils removeUserDefaultForKey:@"token"];
        if (weakSelf.loginOutSuccess) {
            weakSelf.loginOutSuccess();
        }
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:settingView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
