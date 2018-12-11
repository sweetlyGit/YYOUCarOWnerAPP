//
//  YYOUCarHomeViewController.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/30.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseViewController.h"
typedef enum {
    HomeViewContrlFromFirst,
    HomeViewContrlFromSecond
}HomeViewContrlFrom;//中枚举内容的命名需要以该Enum类型名称开头

@interface YYOUCarHomeViewController : YYOUCarBaseViewController
@property(nonatomic,assign) HomeViewContrlFrom fromWhere;
@end
