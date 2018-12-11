//
//  YYOUCarLoginPassWordViewController.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseViewController.h"
typedef enum {
   setUpPassWordViewFromRegister = 0,
    setUpPassWordViewFromPassWord
}setUpPassWordViewFrom;
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarLoginPassWordViewController : YYOUCarBaseViewController
@property(nonatomic,copy) NSString *phoneNum;
@property(nonatomic,assign) setUpPassWordViewFrom viewFrom;
@end

NS_ASSUME_NONNULL_END
