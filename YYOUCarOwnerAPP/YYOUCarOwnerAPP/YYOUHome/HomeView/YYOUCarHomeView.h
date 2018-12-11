//
//  YYOUCarHomeView.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseView.h"
@protocol HomeViewJumpDelegate <NSObject>

@optional
-(void)jumpToViewController;
@end

@interface YYOUCarHomeView : YYOUCarBaseView
@property(nonatomic,weak)id<HomeViewJumpDelegate> delegate;
@end
