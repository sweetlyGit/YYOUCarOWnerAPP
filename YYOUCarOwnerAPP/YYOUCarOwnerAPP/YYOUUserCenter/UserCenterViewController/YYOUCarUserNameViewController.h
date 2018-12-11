//
//  YYOUCarUserNameViewController.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/5.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    userNameViewFromName = 1,
    userNameViewFromAddress
}userNameViewComeFrom;
@interface YYOUCarUserNameViewController : YYOUCarBaseViewController
@property(nonatomic,copy) void(^saveNameBlock)(NSString *name);
@property(nonatomic,assign) userNameViewComeFrom fromWhere;
@end

NS_ASSUME_NONNULL_END
