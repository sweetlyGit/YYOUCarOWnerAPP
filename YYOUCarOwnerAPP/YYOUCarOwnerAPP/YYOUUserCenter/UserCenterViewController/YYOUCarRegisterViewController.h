//
//  YYOUCarRegisterViewController.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseViewController.h"
typedef enum {
  registerViewFromLookForPassWord = 0,
  registerViewFromRegister
}registerViewFrom;
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarRegisterViewController : YYOUCarBaseViewController
///判断了面来源
@property(assign,nonatomic) registerViewFrom fromWhere;
@end

NS_ASSUME_NONNULL_END
