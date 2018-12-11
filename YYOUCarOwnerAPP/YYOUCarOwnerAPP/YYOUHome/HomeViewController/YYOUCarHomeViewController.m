//
//  YYOUCarHomeViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/30.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarHomeViewController.h"
#import "YYOUCarHomeView.h"
#import <YYOUCarUserInfoManager.h>
#import <UIImageView+YYOUCarImageView.h>
#import <YYOUCarUIUtils.h>
#import "NSString+YYOUCarString.h"
#import <BANetManager/BANetManager.h>
#import <BANetManager/BADataEntity.h>
#import <ActivityLib/YYOUCarActivityViewController.h>
@interface YYOUCarHomeViewController ()

@end

@implementation YYOUCarHomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createHomeInfo];
    
    /*YYOUCarHomeView *carBaseView = [[YYOUCarHomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT)];
    [self.view addSubview:carBaseView];*/
}
-(void)navigationClick:(UIButton *)button{
}
-(void)createHomeInfo{
    WEAK_SELF
    UIScrollView *backScrollerView = [[UIScrollView alloc] init];
        if (@available(iOS 11.0, *)) {
            backScrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
    backScrollerView.alwaysBounceVertical = NO;
    backScrollerView.showsVerticalScrollIndicator = NO;
    backScrollerView.bouncesZoom = NO;
    [self.view addSubview:backScrollerView];
    [backScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    UIImageView *headerImage = [UIImageView imageViewWithName:@"home_header" superView:backScrollerView];
    [backScrollerView addSubview:headerImage];
    [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.left.and.right.equalTo(backScrollerView);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    
    UIButton *addCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addCarBtn setBackgroundImage:[UIImage imageNamed:@"home_addCar"] forState:UIControlStateNormal];
    addCarBtn.adjustsImageWhenDisabled = NO;
    addCarBtn.adjustsImageWhenHighlighted = NO;
    addCarBtn.tag = 100;
    [addCarBtn addTarget:self action:@selector(HomeClick:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollerView addSubview:addCarBtn];
    [addCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerImage.mas_left).offset(15);
        make.right.equalTo(headerImage.mas_right).offset(-15);
        make.top.equalTo(headerImage.mas_bottom).offset(-20);
        make.height.equalTo(@90);
    }];
    
    UIImageView *addImage = [UIImageView imageViewWithName:@"add_btn" superView:addCarBtn];
    [addImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addCarBtn.mas_centerX);
        make.top.equalTo(addCarBtn.mas_top).offset(20);
        make.width.and.height.equalTo(@20);
    }];
    
    UILabel *addLabel = [UILabel labelWithText:@"点击添加我的爱车" textColor:RGB(109, 109, 109) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    [addCarBtn addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addCarBtn.mas_centerX);
        make.top.equalTo(addImage.mas_bottom).offset(5);
            make.height.equalTo(@20);
    }];

    
    UIView *detailView = [[UIView alloc] init];
    detailView.backgroundColor = [UIColor whiteColor];
    detailView.userInteractionEnabled = YES;
    [backScrollerView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backScrollerView.mas_left);
        make.right.equalTo(backScrollerView.mas_right);
        make.top.equalTo(addCarBtn.mas_bottom).offset(0);
            make.height.equalTo(@210);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];

    
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_bbs",@"home_online",@"im_chat",@"home_repair",@"home_qusetion",@"home_info", nil];
    NSArray *titleArrar = [NSArray arrayWithObjects:@"发现",@"在线订车",@"论坛",@"关注",@"活动",@"资讯", nil];
    
    CGFloat itemWidth = SCREEN_WIDTH/3;
    
    for (int i = 0; i<titleArrar.count; i++) {
        UIButton *itemBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        itemBtn.frame = CGRectMake(itemWidth*(i%3), 100*(i/3), itemWidth, 100);
        itemBtn.tag = 200+i;
        [itemBtn addTarget:self action:@selector(HomeClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *iconLabel = [UILabel labelWithText:[titleArrar objectAtIndex:i] textColor:RGB(134, 134, 134) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
        iconLabel.userInteractionEnabled = YES;
        [itemBtn addSubview:iconLabel];
        [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(itemBtn);
            make.height.equalTo(@20);
            make.bottom.equalTo(itemBtn.mas_bottom).offset(-10);
        }];
        
        UIImageView *iconImage  = [[UIImageView alloc] init];
        iconImage.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        [itemBtn addSubview:iconImage];
        [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(itemBtn.mas_centerX);
            make.centerY.equalTo(itemBtn.mas_centerY).offset(-15);
        }];
        [detailView addSubview:itemBtn];
    }
    
    UIView *lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 10)];
    lightView.backgroundColor = RGB(249, 249, 249);
    [detailView addSubview:lightView];
    
    UIView *bottomView = [[UIView alloc] init];
    [backScrollerView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(backScrollerView);
        make.top.equalTo(detailView.mas_bottom).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(backScrollerView.mas_bottom);
            make.height.equalTo(@80);
    }];
    
    UIImageView *bottomLeftImage = [UIImageView imageViewWithName:@"home_store" superView:bottomView];
    [bottomLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.centerY.equalTo(bottomView.mas_centerY);
            make.width.equalTo(@50);
    }];
    
    UILabel *bottomRightLabel = [UILabel labelWithText:@"在线商城" textColor:RGB(186, 116, 133) font:[UIFont boldSystemFontOfSize:15] backgroundColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    [bottomView addSubview:bottomRightLabel];
    [bottomRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomLeftImage.mas_right).offset(15);
        make.top.equalTo(bottomView.mas_top).offset(35);
        make.height.equalTo(@20);
    }];
}
-(void)HomeClick:(UIButton *)button{
//    TestUserBaseViewController *test = [[TestUserBaseViewController alloc] init];
//    [self.navigationController pushViewController:test animated:YES];
    YYOUCarActivityViewController *activityViewController = [[YYOUCarActivityViewController alloc] init];
    activityViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:activityViewController animated:YES];
    
   /* if (button.tag == 205) {
        YYOUCarInformationViewController *informationView = [[YYOUCarInformationViewController alloc] init];
        informationView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:informationView animated:YES];
    }else if (button.tag == 204){
        YYOUCarActivityViewController *activityViewController = [[YYOUCarActivityViewController alloc] init];
        activityViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityViewController animated:YES];
    }else{
        YYOUCarForumViewController *forumView = [[YYOUCarForumViewController alloc] init];
        forumView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:forumView animated:YES];
    }*/
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
