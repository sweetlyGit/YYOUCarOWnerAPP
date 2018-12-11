//
//  YYOUCarUserNameViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/5.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarUserNameViewController.h"
#import "YYOUCarTxtFiled+YYOUCarTextsFiled.h"
@interface YYOUCarUserNameViewController ()
@property(strong,nonatomic)YYOUCarTxtFiled *nameTextFiled;
@end

@implementation YYOUCarUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleStr = nil;
    if (self.fromWhere == userNameViewFromName) {
        titleStr = @"姓名";
    }else{
        titleStr = @"地址";
    }
    [super naviGationBarColor:THEME_NAVCOLOR title:titleStr titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:@""];
    [self createInfo];
}

-(void)createInfo{
    WEAK_SELF
    NSString *placeHoder = nil;
    NSString *nameString = nil;
    if (self.fromWhere == userNameViewFromName) {
        placeHoder = @"请填写您的姓名";
        nameString = @"姓名";
    }else{
        placeHoder = @"请填写您的地址";
        nameString = @"地址";
    }
    UIView *nameView = [[UIView alloc] init];
    nameView.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(10);
        make.height.equalTo(@40);
    }];
    
    UILabel *nameLabel = [UILabel labelWithText:nameString font:[UIFont systemFontOfSize:13] alignment:NSTextAlignmentCenter];
    [nameView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.bottom.equalTo(nameView);
        make.width.equalTo(@60);
    }];

    
    self.nameTextFiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:placeHoder borderStyle:UITextBorderStyleNone textColor:RGB(255, 255, 255) textFont:[UIFont systemFontOfSize:13] keyboardType:UIKeyboardTypeDefault];
    self.nameTextFiled.textColor = [UIColor blackColor];
    [nameView addSubview:self.nameTextFiled];
    [self.nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.and.bottom.equalTo(nameView);
    }];
    
    UILabel *remindLabel = [UILabel labelWithText:@"请填写真实信息，以方便获得官方优惠" textColor:RGB(157, 157, 157) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [self.view addSubview:remindLabel];
    
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.view).offset(10);
        make.top.equalTo(nameView.mas_bottom).offset(3);
        make.height.equalTo(@20);
    }];
    UIButton *saveBtn = [UIButton buttonWithText:@"保存" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13] backGroundColor:RGB(215, 0, 18)];
    [saveBtn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remindLabel);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.top.equalTo(remindLabel.mas_bottom).offset(10);
        make.height.equalTo(@30);
    }];
    saveBtn.layer.masksToBounds = YES;
    saveBtn.layer.cornerRadius = 5.0f;
}
-(void)saveClick{
    if (self.saveNameBlock) {
        self.saveNameBlock(self.nameTextFiled.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
