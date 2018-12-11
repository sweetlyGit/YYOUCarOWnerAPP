//
//  YYOUCarUserCenterViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/31.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarUserCenterViewController.h"
#import "UIImageView+YYOUCarImageView.h"
#import "YYOUCarLoginViewController.h"
#import "YYOUCarSettingViewController.h"
#import "YYOUCarUserInfoManager.h"
#import "NSString+YYOUCarString.h"
#import "YYOUCarUserInfoViewController.h"
@interface YYOUCarUserCenterViewController ()
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIImageView *headerImage;
@end

@implementation YYOUCarUserCenterViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    if ([YYOUCarUserInfoManager shareUserInfo].userId) {
        //用户登录
        [self.loginBtn setTitle:[NSString nullToString:[YYOUCarUserInfoManager shareUserInfo].nickname] forState:UIControlStateNormal];
        self.rightBtn.hidden = NO;
        self.loginBtn.enabled = NO;
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString nullToString:[YYOUCarUserInfoManager shareUserInfo].avatar]] placeholderImage:[UIImage imageNamed:@"user_head.png"]];
    }else{
        //用户未登录
        [self.loginBtn setTitle:@"登录 / 注册" forState:UIControlStateNormal];
        self.rightBtn.hidden = YES;
        self.loginBtn.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViewInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)createViewInfo{
    
    UIImageView *backImge = [[UIImageView alloc] init];
    backImge.userInteractionEnabled = YES;
    backImge.image = [UIImage imageNamed:@"img_me"];
    [self.view addSubview:backImge];
    [backImge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self.view);
        make.height.equalTo(@150);
    }];
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"me_setting"] forState:UIControlStateNormal];
    settingBtn.tag = 100;
    [settingBtn addTarget:self action:@selector(userClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImge addSubview:settingBtn];
    
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backImge.mas_right).offset(-15);
        make.top.equalTo(backImge.mas_top).offset(40);
        make.width.and.height.equalTo(@15);
    }];
    
    self.headerImage = [[UIImageView alloc] init];
    self.headerImage.image =[UIImage imageNamed:@"user_head.png"];
    self.headerImage.contentMode = UIViewContentModeScaleAspectFill;
    [backImge addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImge.mas_left).offset(20);
        make.bottom.equalTo(backImge.mas_bottom).offset(-30);
        make.width.and.height.equalTo(@50);
    }];
    self.headerImage.layer.masksToBounds = YES;
    self.headerImage.layer.cornerRadius = 25.0f;
    WEAK_SELF
    self.loginBtn = [UIButton buttonWithText:@"登录 / 注册" normalColor:[UIColor whiteColor] backGroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:14]];
    self.loginBtn.tag = 101;
    [self.loginBtn addTarget:self action:@selector(userClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [backImge addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.headerImage.mas_right).offset(10);
        make.height.equalTo(@20);
        make.centerY.equalTo(weakSelf.headerImage.mas_centerY);
        make.right.equalTo(backImge.mas_right).offset(-30);
    }];
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"user_next"] forState:UIControlStateNormal];
    self.rightBtn.tag = 102;
    [self.rightBtn addTarget:self action:@selector(userClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImge addSubview:self.rightBtn];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backImge.mas_right).offset(-15);
        make.centerY.equalTo(weakSelf.loginBtn.mas_centerY);
        make.width.equalTo(@10);
        make.height.equalTo(@14);
    }];
}
-(void)userClick:(UIButton *)button{
    WEAK_SELF
    if (button.tag == 101) {
        YYOUCarLoginViewController *login = [[YYOUCarLoginViewController alloc] init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else if (button.tag == 100){
        YYOUCarSettingViewController *settViewControl = [[YYOUCarSettingViewController alloc] init];
        settViewControl.hidesBottomBarWhenPushed = YES;
        settViewControl.loginOutSuccess = ^{
            [weakSelf.loginBtn setTitle:@"登录 / 注册" forState:UIControlStateNormal];
            weakSelf.loginBtn.enabled = YES;
            weakSelf.rightBtn.hidden = NO;
        };
        [self.navigationController pushViewController:settViewControl animated:YES];
    }else{
        YYOUCarUserInfoViewController *userInfo = [[YYOUCarUserInfoViewController alloc] init];
        userInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userInfo animated:YES];
    }
}

@end
