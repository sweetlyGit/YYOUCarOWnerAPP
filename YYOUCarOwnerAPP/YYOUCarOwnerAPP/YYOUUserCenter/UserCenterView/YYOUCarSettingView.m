//
//  YYOUCarSettingView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarSettingView.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@implementation YYOUCarSettingView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if ([YYOUCarUserInfoManager shareUserInfo].userId) {
            [self.dataArray addObject:@"修改密码"];
            [self.dataArray addObject:@"关于"];
            [self.dataArray addObject:@"当前版本"];
        }else{
            [self.dataArray addObject:@"关于"];
            [self.dataArray addObject:@"当前版本"];
        }
        [self addSubview:self.listTable];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
        UILabel *lineLabel = [UILabel labelWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1) text:@"" textColor:[UIColor clearColor] font:[UIFont systemFontOfSize:16] backgroundColor:RGB(224, 224, 224)];
        [cell.contentView addSubview:lineLabel];
    
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = RGB(101, 101, 101);
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([YYOUCarUserInfoManager shareUserInfo].userId) {
        UIView * back_view = [[UIView alloc] init];
        back_view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
        back_view.userInteractionEnabled = YES;
        
        UIButton *logOutBtn = [UIButton buttonWithText:@"退出登录" normalColor:[UIColor whiteColor] selectColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15] backGroundColor:RGB(55, 139, 251)];
        logOutBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [logOutBtn addTarget:self action:@selector(loginOutClick) forControlEvents:UIControlEventTouchUpInside];
        [back_view addSubview:logOutBtn];
        
        [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back_view.mas_left).offset(20);
            make.right.equalTo(back_view.mas_right).offset(-20);
            make.top.equalTo(back_view.mas_top).offset(50);
            make.bottom.equalTo(back_view);
        }];
        return back_view;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([YYOUCarUserInfoManager shareUserInfo].userId) {
        return 40+50;
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(void)loginOutClick{
    //退出的时候删除别名
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        if (iResCode == 0){
            NSLog(@"删除别名成功");
        }
    } seq:1];
    if (self.loginOut) {
        self.loginOut();
    }
}
@end
