//
//  YYOUCarCollectionViewCell.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/17.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarCollectionViewCell.h"
#import "YYOUCommonHeader.h"
#import "UILabel+YYOUCarLabel.h"
#import "NSString+YYOUCarString.h"
@interface YYOUCarCollectionViewCell ()
@property(nonatomic,strong)UILabel *itemLabel;
@property(nonatomic,strong)UIImageView *itemImage;

@end


@implementation YYOUCarCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    if (self) {
        WEAK_SELF
        self = [super initWithFrame:frame];
        self.itemLabel = [UILabel labelWithText:@"111" textColor:RGB(136, 136, 136) font:[UIFont systemFontOfSize:12] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.itemLabel];
        
        [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView.mas_centerX);
            make.height.equalTo(@20);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        }];
        
        self.itemImage = [UIImageView imageViewWithName:@"111"];
        [self.contentView addSubview:self.itemImage];
        [self.itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(20);
            make.centerX.equalTo(weakSelf.contentView.mas_centerX);
            make.width.and.height.equalTo(@50);
        }];
    }
    return self;
}
-(void)setUIWithImageName:(NSString *)imag title:(NSString *)title{
    
    self.itemLabel.text = [NSString stringWithFormat:@"%@",[NSString nullToString:title]];
    self.itemImage.image = [UIImage imageNamed:[NSString nullToString:imag]];
}
@end
