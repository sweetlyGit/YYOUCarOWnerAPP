//
//  YYOUCarRegisterViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarRegisterViewController.h"
#import "YYOUCarTxtFiled+YYOUCarTextsFiled.h"
#import "YYOUCarLoginPassWordViewController.h"
#import "YYOUCarUIUtils.h"
#import "NSString+YYOUCarString.h"
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import <Toast/Toast.h>
#import "YYOUUserCenterRequestHeader.h"
@interface YYOUCarRegisterViewController ()<UITextFieldDelegate>{
    UIButton *nextStepBtn;
}
///注册手机号
@property(nonatomic,strong)YYOUCarTxtFiled *loginPhoneTextfiled;
///注册验证码
@property(nonatomic,strong)YYOUCarTxtFiled *loginCodeTextfiled;
///获取验证码
@property(nonatomic,strong)UIButton *rightCodeBtn;

@end

@implementation YYOUCarRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *titleString = @"";
    if (self.fromWhere == registerViewFromRegister) {
        titleString = @"注册";
    }else{
        titleString = @"找回密码";
    }
    [super naviGationBarColor:THEME_NAVCOLOR title:titleString titleFont:[UIFont boldSystemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:@""];
    [self createViewInfo];
}
-(void)buttonClick:(UIButton *)button{
    if (button.tag == 300) {
        //发送验证码
        if (![YYOUCarUIUtils isPhoneNumber:[NSString nullToString:self.loginPhoneTextfiled.text]]) {
            //手机号不合法
            [MBProgressHUD showSuccess:@"请输入正确的手机号" toView:self.view];
        }else{
            int msgType = 0;
            if (self.fromWhere == registerViewFromRegister) {
                //来自于注册页面
                msgType = 20181001;
            }else{
                //来自于找回密码页面
                msgType = 20181003;
            }
            [self getCheckCodeRequestWithMsgType:msgType];
        }
    }else{
        if (self.loginPhoneTextfiled.text.length>0&&self.loginCodeTextfiled.text.length>0){
            //            20181001 注册验证码
            //            20181002 登录验证码
            //            20181003 忘记密码验证码
            //            20181004 账号验证
            ///调用注册接口，验证验证码
            int msgType = 0;
            if (self.fromWhere == registerViewFromRegister) {
                //来自于注册页面
                msgType = 20181001;
            }else{
                //来自于找回密码页面
                msgType = 20181003;
            }
            [self validationCheckCodeRequestWithType:msgType];
        }
    }
}
-(void)validationCheckCodeRequestWithType:(int)msgType{
    
    [MBProgressHUD showMessage:@"正在验证..." toView:self.view];
    WEAK_SELF
    NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,VALIDATE_CODE];
    NSString *phoneNum = [NSString stringWithFormat:@"%@",self.loginPhoneTextfiled.text];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString nullToString:self.loginCodeTextfiled.text],@"checkCode",phoneNum,@"phone",[NSNumber numberWithInt:msgType],@"msgType", nil];
    [self getDataRequestUrl:urlString parameters:params];
    self.requestSuccessBolck = ^(NSDictionary *result) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSString *resultCode = [NSString nullToString:[result objectForKey:@"resultCode"]];
        NSString *errMsg = [NSString nullToString:[result objectForKey:@"errMsg"]];
        
        if ([resultCode isEqualToString:@"200"]) {
            //设置登录密码页面
            YYOUCarLoginPassWordViewController *loginPassWordViewControl = [[YYOUCarLoginPassWordViewController alloc] init];
            loginPassWordViewControl.phoneNum = [NSString nullToString:weakSelf.loginPhoneTextfiled.text];
            if (weakSelf.fromWhere == registerViewFromRegister) {
                //注册页面
                loginPassWordViewControl.viewFrom = setUpPassWordViewFromRegister;
            }else{
                //找回密码页面
                loginPassWordViewControl.viewFrom = setUpPassWordViewFromPassWord;
            }
            [weakSelf.navigationController pushViewController:loginPassWordViewControl animated:YES];
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }
    };
    self.requestFailBolck = ^(NSError *resultError) {
        [weakSelf.view makeToast:@"验证码错误，请重新输入" duration:0.2 position:CSToastPositionCenter];
    };

}
-(void)getCheckCodeRequestWithMsgType:(int)msgType{
    [MBProgressHUD showMessage:@"正在获取..." toView:self.view];
    WEAK_SELF
    NSString *phoneNum = [NSString stringWithFormat:@"%@",self.loginPhoneTextfiled.text];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:msgType],@"msgType",phoneNum,@"phone", nil];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,GET_CHECK_CODE];
    [self getDataRequestUrl:urlString parameters:params];
    self.requestSuccessBolck = ^(NSDictionary *result) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSString *resultCode = [NSString nullToString:[result objectForKey:@"resultCode"]];
        NSString *errMsg = [NSString nullToString:[result objectForKey:@"errMsg"]];
        
        if ([resultCode isEqualToString:@"200"]) {
                    weakSelf.loginCodeTextfiled.text = [NSString nullToString:[result objectForKey:@"data"]];
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }

    };
    self.requestFailBolck = ^(NSError *resultError) {
        
    };
    
}
#pragma mark *****页面UI
-(void)createViewInfo{
    WEAK_SELF
    self.loginPhoneTextfiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:@"请输入手机号" borderStyle:UITextBorderStyleNone textColor:RGB(168, 168, 168) textFont:[UIFont systemFontOfSize:12] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad borderColor:RGB(233, 233, 233)];
    self.loginPhoneTextfiled.backgroundColor = [UIColor whiteColor];
    self.loginPhoneTextfiled.delegate = self;
    [self.view addSubview:self.loginPhoneTextfiled];
    
    [self.loginPhoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@40);
        make.top.equalTo(self.view.mas_top).offset(20);
    }];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = RGB(225, 225, 225);
    [self.view addSubview:lineLabel];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(weakSelf.loginPhoneTextfiled);
        make.height.equalTo(@1);
        make.top.equalTo(weakSelf.loginPhoneTextfiled.mas_bottom);
    }];
    
    
    
    self.rightCodeBtn = [UIButton buttonWithText:@"获取验证码" normalColor:RGB(45, 146, 255) selectColor:RGB(45, 146, 255) font:[UIFont systemFontOfSize:15] backGroundColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    [self.rightCodeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.rightCodeBtn.enabled = NO;
    self.rightCodeBtn.tag = 300;
    
    [self.view addSubview:self.rightCodeBtn];
    [self.rightCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineLabel.mas_right);
        make.top.equalTo(lineLabel.mas_bottom);
        make.height.equalTo(weakSelf.loginPhoneTextfiled.mas_height);
        make.width.equalTo(@80);
    }];
    
//    UILabel *rightVerLine = [[UILabel alloc] init];
////    rightVerLine.backgroundColor = RGB(255, 255, 255);
//    rightVerLine.backgroundColor = [UIColor redColor];
//    [self.view addSubview:rightVerLine];
//    [rightVerLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineLabel.mas_top).offset(5);
//        make.right.equalTo(weakSelf.rightCodeBtn.mas_left);
//        make.height.equalTo(@20);
//        make.width.equalTo(@1);
//    }];
    
    
    
    self.loginCodeTextfiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:@"请输入验证码" borderStyle:UITextBorderStyleNone textColor:RGB(168, 168, 168) textFont:[UIFont systemFontOfSize:12] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad borderColor:RGB(233, 233, 233)];
    self.loginCodeTextfiled.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginCodeTextfiled];
    
    [self.loginCodeTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineLabel.mas_left);
        make.top.equalTo(lineLabel.mas_bottom);
        make.height.equalTo(weakSelf.loginPhoneTextfiled.mas_height);
        make.right.equalTo(weakSelf.rightCodeBtn.mas_left).offset(-1);
        
    }];
    
    nextStepBtn = [UIButton buttonWithText:@"下一步" normalColor:[UIColor whiteColor] backGroundColor:RGB(55, 139, 251) font:[UIFont systemFontOfSize:15]];
    nextStepBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    nextStepBtn.tag = 301;
    [nextStepBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextStepBtn];
    
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(weakSelf.loginCodeTextfiled.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.loginPhoneTextfiled.mas_right);
        make.height.equalTo(@40);
    }];
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.loginPhoneTextfiled) {
        if (textField.text.length>0) {
            self.rightCodeBtn.enabled = YES;
        }else{
            self.rightCodeBtn.enabled = NO;

        }
    }else{
     
    }
    return YES;
}
@end
