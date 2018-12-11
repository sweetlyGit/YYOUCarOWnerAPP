//
//  YYOUCarLoginPassWordViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarLoginPassWordViewController.h"
#import "YYOUCarTxtFiled+YYOUCarTextsFiled.h"
#import <Toast/Toast.h>
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import "YYOUCarUserInfoManager.h"
#import "YYOUCarLoginViewController.h"
#import "YYOUUserCenterRequestHeader.h"
@interface YYOUCarLoginPassWordViewController ()<UITextFieldDelegate>{
    UIButton *nextStepBtn;
}
@property(nonatomic,strong)YYOUCarTxtFiled *loginPassWordTextfiled;
@end

@implementation YYOUCarLoginPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [super naviGationBarColor:THEME_NAVCOLOR title:@"设置登录密码" titleFont:[UIFont boldSystemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:@""];
    [self ceateViewInfo];

}

-(void)buttonClick{
    if (self.loginPassWordTextfiled.text.length <6 || self.loginPassWordTextfiled.text.length>20) {
        [self.view makeToast:@"密码必须大于6位或者小于20位" duration:0.2 position:CSToastPositionCenter];
    }else{
        NSString *urlString = @"";
        if (self.viewFrom == setUpPassWordViewFromRegister) {
            //注册
        urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,USER_RESGISTER];
        }else{
            //重设密码
            urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,USER_RESET_PASSWORD];
        }
        [self resgisterUserRequestWithUrlString:urlString];
    }
}
-(void)resgisterUserRequestWithUrlString:(NSString *)urlString{
    [MBProgressHUD showMessage:@"正在注册.." toView:self.view];

    WEAK_SELF
     NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.phoneNum,@"phone",self.loginPassWordTextfiled.text,@"password", nil];
    self.requestSuccessBolck = ^(NSDictionary *result) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSString *resultCode = [NSString nullToString:[result objectForKey:@"resultCode"]];
        NSString *errMsg = [NSString nullToString:[result objectForKey:@"errMsg"]];
        if ([resultCode isEqualToString:@"200"]) {
            //        注册成功不赋值用户信息，跳转登录页面，让用户登录
            [weakSelf.view makeToast:@"注册成功，前往登录" duration:0.2 position:CSToastPositionCenter];
            NSArray *viewArray = weakSelf.navigationController.viewControllers;
            for (YYOUCarBaseViewController *viewController in viewArray) {
                if ([viewController isKindOfClass:[YYOUCarLoginViewController class]]) {
                    [weakSelf.navigationController popToViewController:viewController animated:YES];
                    return ;
                }
            }
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }
        
    };
    self.requestFailBolck = ^(NSError *resultError) {
        [weakSelf.view makeToast:@"注册失败，请重新注册" duration:0.2 position:CSToastPositionCenter];
    };
    
    [self postDataRequestUrl:urlString parameters:params requestType:@"1"];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length>0) {
        nextStepBtn.enabled = YES;
    }
    return YES;
}
-(void)ceateViewInfo{
    WEAK_SELF
    self.loginPassWordTextfiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:@"请设置登录密码" borderStyle:UITextBorderStyleNone textColor:RGB(168, 168, 168) textFont:[UIFont systemFontOfSize:12] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad borderColor:RGB(233, 233, 233)];
    self.loginPassWordTextfiled.delegate = self;
    self.loginPassWordTextfiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginPassWordTextfiled];
    
    [self.loginPassWordTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@40);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.height.equalTo(@40);
    }];
    
    nextStepBtn = [UIButton buttonWithText:@"注册" normalColor:[UIColor whiteColor] backGroundColor:RGB(55, 139, 251) font:[UIFont systemFontOfSize:15]];
    if (self.viewFrom == setUpPassWordViewFromRegister) {
        [nextStepBtn setTitle:@"注册" forState:UIControlStateNormal];

    }else{
        [nextStepBtn setTitle:@"设置密码" forState:UIControlStateNormal];
    }
    nextStepBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextStepBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    nextStepBtn.enabled = NO;
    [self.view addSubview:nextStepBtn];
    
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.loginPassWordTextfiled.mas_left);
        make.top.equalTo(weakSelf.loginPassWordTextfiled.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.loginPassWordTextfiled.mas_right);
        make.height.equalTo(@40);
    }];
}
@end
