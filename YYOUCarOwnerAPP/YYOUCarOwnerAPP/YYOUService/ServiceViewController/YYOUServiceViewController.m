//
//  YYOUServiceViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUServiceViewController.h"
#import "YYOUCarCollectionViewCell.h"
#import "YYOUCarHomeViewController.h"
@interface YYOUServiceViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *serviceCollectionView;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) NSMutableArray *imgArray;

@end

@implementation YYOUServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super naviGationBarColor:THEME_NAVCOLOR title:@"服务" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"" rightItem:@""];
    self.titleArray = [NSMutableArray arrayWithObjects:@"养修预约",@"一键救援",@"问卷",@"用车知识",@"查找经销商",@"违章查询",@"资讯",@"活动",@"发现",@"在线订车",@"客服", nil];
    self.imgArray = [NSMutableArray arrayWithObjects:@"repair_order",@"service_rescue",@"home_qusetion",@"car_knowledge",@"search_shop",@"break_rule",@"home_info",@"service_activity",@"home_bbs",@"home_online",@"im_chat", nil];
    [self.view addSubview:self.serviceCollectionView];
    
}
-(UICollectionView *)serviceCollectionView{
    if(!_serviceCollectionView){
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 1;  //行间距
        flowLayout.minimumInteritemSpacing = 0; //列间距
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-3)/4, 100); //固定的itemsize
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滑动的方向 垂直
        //初始化 UICollectionView
        _serviceCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _serviceCollectionView.delegate = self; //设置代理
        _serviceCollectionView.dataSource = self;   //设置数据来源
        _serviceCollectionView.backgroundColor = RGB(244, 244, 244);
        
        _serviceCollectionView.bounces = YES;   //设置弹跳
        _serviceCollectionView.alwaysBounceVertical = YES;  //只允许垂直方向滑动
        [_serviceCollectionView registerClass:[YYOUCarCollectionViewCell class] forCellWithReuseIdentifier:@"serviceCollection"];
    }
    return _serviceCollectionView;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {

    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;//设置section 个数
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;//根据section设置每个section的item个数
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell的重用，在设置UICollectionView 中注册了cell
    YYOUCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"serviceCollection" forIndexPath:indexPath];
    [cell setUIWithImageName:[self.imgArray objectAtIndex:indexPath.item] title:[self.titleArray objectAtIndex:indexPath.item]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
