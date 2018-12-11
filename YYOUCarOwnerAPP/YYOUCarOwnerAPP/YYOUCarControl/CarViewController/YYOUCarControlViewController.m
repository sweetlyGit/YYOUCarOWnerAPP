//
//  YYOUCarControlViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/31.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarControlViewController.h"
@interface YYOUCarControlViewController ()

@end

@implementation YYOUCarControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [super naviGationBarColor:THEME_NAVCOLOR title:@"车辆" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"" rightItem:@""];
    self.view.backgroundColor = RGB(238, 238, 238);
    [self createInfo];
}
-(void)createInfo{
    WEAK_SELF
    UIButton *payButton = [UIButton buttonWithText:@"支付0.01元" normalColor:[UIColor blackColor] selectColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] backGroundColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    [payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.left.equalTo(weakSelf.view.mas_left).offset(20);
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
        make.height.equalTo(@40);

    }];
}
-(void)payClick{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
