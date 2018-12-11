//
//  YYOUCarLoginViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/7.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarLoginViewController.h"
#import "YYOUCarTxtFiled+YYOUCarTextsFiled.h"
#import "YYOUCarRegisterViewController.h"
#import "NSString+YYOUCarString.h"
#import "YYOUCarUIUtils.h"
#import <Toast/Toast.h>
#import "YYOUCarUIUtils.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import <BANetManager/BANetManager.h>
#import <BANetManager/BADataEntity.h>
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import "YYOUCarCommonToolManager.h"
#import "YYOUUserCenterRequestHeader.h"
#endif
@interface YYOUCarLoginViewController ()
///区分快捷登录和账号密码登录
@property(nonatomic,copy)NSString *loginType;
///头部视图
@property(nonatomic,strong)UIView *headView;
///分割线
@property(nonatomic,strong)UILabel *lineLabel;
///登录密码填写
@property(nonatomic,strong)YYOUCarTxtFiled *loginPassTextfiled;
///登录手机号填写
@property(nonatomic,strong)YYOUCarTxtFiled *loginPhoneTextfiled;
@end

@implementation YYOUCarLoginViewController
-(void)viewWillAppear:(BOOL)animated{
[self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [super naviGationBarColor:THEME_NAVCOLOR title:@"登录车主APP" titleFont:[UIFont boldSystemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:@""];
    self.loginType = @"codeLogin";
    [self createInfo];
    
}
-(void)createInfo{
    self.headView = [[UIView alloc] init];
    self.headView.backgroundColor = RGB(241, 241, 241);
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    WEAK_SELF
    NSArray *titleArr = @[@"手机快捷登录",@"账号密码登录"];
    float titleWidth = SCREEN_WIDTH/2;
    for (int i =0; i<titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithText:[titleArr objectAtIndex:i] normalColor:RGB(141, 141, 141) selectColor:RGB(96, 131, 218) font:[UIFont systemFontOfSize:12] backGroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        button.frame = CGRectMake(titleWidth*i, 0, titleWidth, 39);
        button.tag = 200+i;
        [button addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf.headView addSubview:button];
        
        if (i == 0) {
            button.selected  =YES;
            self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2*i, 39, SCREEN_WIDTH/2, 1)];
            self.lineLabel.backgroundColor = RGB(110, 152, 218);
            [self.headView addSubview:self.lineLabel];
        }
    }

    
    UIImageView *leftImge = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 15, 20)];
    leftImge.image = [UIImage imageNamed:@"login_phone.png"];
    
    self.loginPhoneTextfiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:@"请输入您的手机号" borderStyle:UITextBorderStyleRoundedRect textColor:RGB(168, 168, 168) textFont:[UIFont systemFontOfSize:12] secureTextEntry:NO keyboardType:UIKeyboardTypeNumberPad borderColor:RGB(233, 233, 233)];
    self.loginPhoneTextfiled.leftView = leftImge;
    [self.view addSubview:self.loginPhoneTextfiled];
    
    [self.loginPhoneTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@40);
        make.top.equalTo(weakSelf.headView.mas_bottom).offset(20);
    }];
    
    UIImageView *leftImgeTwo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    leftImgeTwo.image = [UIImage imageNamed:@"login_password.png"];
    
    self.loginPassTextfiled = [YYOUCarTxtFiled textFiledWithPlaceHoder:@"请输入验证码" borderStyle:UITextBorderStyleRoundedRect textColor:RGB(168, 168, 168) textFont:[UIFont systemFontOfSize:12] secureTextEntry:YES keyboardType:UIKeyboardTypeNumberPad borderColor:RGB(233, 233, 233)];
    self.loginPassTextfiled.leftView = leftImgeTwo;
    [self.view addSubview:self.loginPassTextfiled];
    
    [self.loginPassTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.loginPhoneTextfiled.mas_left);
        make.right.equalTo(weakSelf.loginPhoneTextfiled.mas_right);
        make.height.equalTo(weakSelf.loginPhoneTextfiled.mas_height);
        make.top.equalTo(weakSelf.loginPhoneTextfiled.mas_bottom).offset(10);
    }];
    
    UIButton *verifiCode = [UIButton buttonWithText:@"发送验证码" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12]];
    verifiCode.backgroundColor = RGB(55, 139, 251);
    verifiCode.frame = CGRectMake(0, 0, 70, 25);
    verifiCode.layer.masksToBounds = YES;
    verifiCode.layer.cornerRadius = 5.0f;
    verifiCode.tag = 202;
    [verifiCode addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginPassTextfiled.rightViewMode = UITextFieldViewModeAlways;
    self.loginPassTextfiled.rightView = verifiCode;
    
    UIButton *loginBtn = [UIButton buttonWithText:@"登录" normalColor:[UIColor whiteColor] backGroundColor:RGB(55, 139, 251) font:[UIFont systemFontOfSize:15]];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginBtn.tag = 203;
    [loginBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginPassTextfiled.mas_left);
        make.top.equalTo(self.loginPassTextfiled.mas_bottom).offset(20);
        make.right.equalTo(self.loginPassTextfiled.mas_right);
        make.height.equalTo(@40);
    }];
    
    
    UIButton *forgetPassBtn = [UIButton buttonWithText:@"忘记密码" normalColor:RGB(145, 144, 145) backGroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:10]];
    forgetPassBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    forgetPassBtn.tag = 204;
    [forgetPassBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassBtn];
    [forgetPassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginBtn.mas_left);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
    UIButton *newUserBtn = [UIButton buttonWithText:@"新用户注册" normalColor:RGB(55, 139, 251) backGroundColor:[UIColor clearColor] font:[UIFont systemFontOfSize:10]];
    newUserBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    newUserBtn.tag = 205;
    [newUserBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newUserBtn];
    [newUserBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    
}
-(void)headClick:(UIButton *)button{
    WEAK_SELF
    if (button.tag<202) {
        for (int i = 200; i<202; i++) {
            UIButton *titleBtn = (UIButton *)[self.headView viewWithTag:i];
            titleBtn.selected = NO;
        }
        if (button.tag == 200) {
            self.loginType = @"codeLogin";
            self.loginPassTextfiled.placeholder = @"请输入验证码";
            self.loginPassTextfiled.rightViewMode = UITextFieldViewModeAlways;
        }else{
            //账号密码登录
            self.loginType = @"phoneLogin";
            self.loginPassTextfiled.placeholder = @"请输入登录密码";
            self.loginPassTextfiled.rightViewMode = UITextFieldViewModeNever;
        }
        button.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.lineLabel.frame = CGRectMake((SCREEN_WIDTH/2)*(button.tag-200), weakSelf.lineLabel.frame.origin.y, weakSelf.lineLabel.frame.size.width, weakSelf.lineLabel.frame.size.height);
        }];
    }else{
        if (button.tag == 202) {
//         快捷登录
//            20181001 注册验证码
//            20181002 登录验证码
//            20181003 忘记密码验证码
//            20181004 账号验证
                if ([YYOUCarUIUtils isPhoneNumber:[NSString nullToString:self.loginPhoneTextfiled.text]]) {
                    [self getCheckCodeRequestWithMsgType:20181002];

                }else{
                    [self.view makeToast:@"请填写正确的手机号" duration:0.2 position:CSToastPositionCenter];
                }
            
        }else if (button.tag == 203){
            //  203
            if (self.loginPhoneTextfiled.text.length>0&&self.loginPassTextfiled.text.length>0) {
                //登录
                [self loginTheAppRequest];
            }else{
                [self.view makeToast:@"请保证信息填写完整" duration:0.2 position:CSToastPositionCenter];
            }
        }
//        else if (button.tag == 204){
//          //忘记密码
//        }
        else{
            //新用户注册
            YYOUCarRegisterViewController *registerViewController = [[YYOUCarRegisterViewController alloc] init];
            if (button.tag == 204) {
                //忘记密码
                registerViewController.fromWhere = registerViewFromLookForPassWord;
            }else{
                //新用户注册
                registerViewController.fromWhere = registerViewFromRegister;
            }
            registerViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:registerViewController animated:YES];
        }
    }
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
            weakSelf.loginPassTextfiled.text = [NSString nullToString:[result objectForKey:@"data"]];
            [weakSelf loginTheAppRequest];
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }

    };
}
-(void)loginTheAppRequest{
    [MBProgressHUD showMessage:@"正在登录..." toView:self.view];

    WEAK_SELF
    NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,USER_LOGIN];
    if ([self.loginType isEqualToString:@"codeLogin"]) {
        //验证码登录
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString nullToString:self.loginPhoneTextfiled.text],@"phone",[NSString nullToString:self.loginPassTextfiled.text],@"checkCode", nil];
        
        [self postDataRequestUrl:urlString parameters:params requestType:@"1"];
    }else{
        //账号密码登录
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString nullToString:self.loginPhoneTextfiled.text],@"phone",[NSString nullToString:self.loginPassTextfiled.text],@"password", nil];
        
        [self postDataRequestUrl:urlString parameters:params requestType:@"1"];
    }

    self.requestSuccessBolck = ^(NSDictionary *result) {
        [MBProgressHUD hideHUDForView:weakSelf.view];

        NSDictionary *dict = [result objectForKey:@"data"];
        NSString *resultCode = [NSString nullToString:[result objectForKey:@"resultCode"]];
        NSString *errMsg = [NSString nullToString:[result objectForKey:@"errMsg"]];
        
        if ([resultCode isEqualToString:@"200"]) {
            NSString *jwtString = [NSString nullToString:[dict objectForKey:@"jwt"]];
            [YYOUCarUIUtils setUserDefaultValue:jwtString ForKey:@"token"];
            [weakSelf getUserInfoRequest];
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }
    };

}
-(void)getUserInfoRequest{
    [MBProgressHUD showMessage:@"正在加载..." toView:self.view];
    WEAK_SELF
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,USER_INFOMATION];
    [self getDataRequestUrl:urlString parameters:params];
    self.requestSuccessBolck = ^(NSDictionary *result) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSString *resultCode = [NSString nullToString:[result objectForKey:@"resultCode"]];
        NSString *errMsg = [NSString nullToString:[result objectForKey:@"errMsg"]];
        if ([resultCode isEqualToString:@"200"]) {
            NSDictionary *data = [NSDictionary dictionaryWithDictionary:[result objectForKey:@"data"]];
            [YYOUCarUserInfoManager configInfo:data];
            [JPUSHService setAlias:[NSString nullToString:[YYOUCarUserInfoManager shareUserInfo].phone] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                if (iResCode == 0) {
                    NSLog(@"添加别名成功");
                }
            } seq:1];
            if (weakSelf.loginSuccessBlock) {
                weakSelf.loginSuccessBlock();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }
    };
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
