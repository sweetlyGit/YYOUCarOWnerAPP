//
//  YYOUCarUserInfoViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/2.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarUserInfoViewController.h"
#import "NSString+YYOUCarString.h"
#import <PGDatePicker/PGDatePickManager.h>
#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import "YYOUCarAlertView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "YYOUCarUserNameViewController.h"
#import "YYOUCarUIUtils.h"
@interface YYOUCarUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *mainTable;
@property(nonatomic,copy)NSString *headerUrl;
@property(nonatomic,strong)UIImage *headImage;
@property(nonatomic,strong)UIImagePickerController *imagePickerVc;
@end

@implementation YYOUCarUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super naviGationBarColor:THEME_NAVCOLOR title:@"个人资料" titleFont:[UIFont systemFontOfSize:15] titleColor:[UIColor whiteColor] leftItem:@"common_back" rightItem:@""];
    self.headImage = [UIImage imageNamed:@""];
    [self createInfo];
    NSArray *infoArray = @[
    @{@"title":@"姓名",@"hoder":@"请填写您的的姓名"},
    @{@"title":@"性别",@"hoder":@"请填写您的的性别"},
    @{@"title":@"生日",@"hoder":@"请填写您的的生日"},
    @{@"title":@"驾驶证到期日",@"hoder":@"请填写驾驶证到期日"},
    @{@"title":@"住址",@"hoder":@"填写通讯地址，方便寄送礼品"}];
    for (NSDictionary *dict in infoArray) {
        [self.dataArray addObject:dict];
    }
}
-(void)createInfo{
    WEAK_SELF
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTable.backgroundColor = [UIColor whiteColor];
    self.mainTable.delegate = self;
    self.mainTable.dataSource = self;
    [self.view addSubview:self.mainTable];
    [self.mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.and.bottom.equalTo(weakSelf.view);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        
        return self.dataArray.count;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        headerView.backgroundColor = RGB(225, 225, 225);
        return headerView;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 5;
    }else{
        return 0.01;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIdendtifer = @"uploadPhoto";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdendtifer];
        if (cell == nil) {
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdendtifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"头像";
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = RGB(83, 83, 83);
        }
        UIImageView *tempImage = [cell.contentView viewWithTag:1000];
        if (tempImage) {
            [tempImage removeFromSuperview];
        }
        
        UIImageView *headerImage = [[UIImageView alloc] init];
        headerImage.layer.masksToBounds = YES;
        headerImage.layer.cornerRadius = 15.0f;
        [headerImage sd_setImageWithURL:[NSURL URLWithString:[YYOUCarUserInfoManager shareUserInfo].avatar] placeholderImage:[UIImage imageNamed:@"image_header_placehoder.png"]];
        headerImage.tag = 1000;
        [cell.contentView addSubview:headerImage];
        [headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@30);
            make.right.equalTo(cell.contentView.mas_right).offset(-30);
            make.centerY.equalTo(cell.contentView.mas_centerY);
        }];
        return cell;
       
    }else{
        static NSString *cellIdendtifer = @"userInfo";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdendtifer];
        if (cell == nil) {
            cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdendtifer];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [NSString nullToString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"]];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = RGB(83, 83, 83);
        }
        UILabel *tempLabel = [cell.contentView viewWithTag:2000+indexPath.row];
        if (tempLabel) {
            [tempLabel removeFromSuperview];
        }
        UILabel *detailLabel = [UILabel labelWithFont:[UIFont systemFontOfSize:12] textColor:RGB(225, 225, 225) backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
        detailLabel.tag = 2000+indexPath.row;
        detailLabel.text = [NSString nullToString:[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"hoder"]];
        [cell.contentView addSubview:detailLabel];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView.mas_right).offset(-20);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.height.equalTo(@20);
        }];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WEAK_SELF
         [YYOUCarAlertView AlertViewWithTitle:nil message:nil acitons:@[@"拍照",@"从手机相册选择",@"取消"] style:CZAlertViewSheet inView:self itemblock:^(NSInteger itemIndex) {
             //itemIndex 从1开始
             if (itemIndex == 1) {
                 //拍照
                 [weakSelf takePhoto];
             }else if (itemIndex == 2){
                 //从手机相册选择
                 [weakSelf pushTZImagePickerController];
             }else{
                 //从手机相册选择
             }
        }];
    }else{
        if (indexPath.row == 0) {
            WEAK_SELF
            YYOUCarUserNameViewController *userNameView = [[YYOUCarUserNameViewController alloc] init];
            userNameView.fromWhere = userNameViewFromName;
            userNameView.saveNameBlock = ^(NSString * _Nonnull name) {
                [weakSelf reloadUIWithData:[NSString nullToString:name] index:indexPath.row];
            };
            [self.navigationController pushViewController:userNameView animated:YES];
        }else if (indexPath.row == 1){
            //性别
            NSArray *sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
            WEAK_SELF
            [ActionSheetStringPicker showPickerWithTitle:nil rows:sexArray initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                [weakSelf reloadUIWithData:[NSString nullToString:selectedValue] index:indexPath.row];
            } cancelBlock:nil origin:self.view];
        }else if (indexPath.row == 2 || indexPath.row == 3) {
            WEAK_SELF;
                PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
                PGDatePicker *datePicker = datePickManager.datePicker;
                datePicker.datePickerMode = PGDatePickerModeDate;
                datePicker.selectedDate = ^(NSDateComponents *dateComponents) {
                    NSString *timeDate = [NSString stringWithFormat:@"%ld年%ld月%ld日",dateComponents.year,dateComponents.month,dateComponents.day];
                    [weakSelf reloadUIWithData:[NSString nullToString:timeDate] index:indexPath.row];
                };
            [self presentViewController:datePickManager animated:false completion:nil];
        }else{
            //地址
            WEAK_SELF
            YYOUCarUserNameViewController *userNameView = [[YYOUCarUserNameViewController alloc] init];
            userNameView.fromWhere = userNameViewFromAddress;
            userNameView.saveNameBlock = ^(NSString * _Nonnull name) {
                [weakSelf reloadUIWithData:[NSString nullToString:name] index:indexPath.row];
            };
            [self.navigationController pushViewController:userNameView animated:YES];
        }
    }
}
-(void)reloadUIWithData:(NSString *)newValue index:(NSInteger)index{
    NSMutableDictionary *dateDict = [NSMutableDictionary dictionaryWithDictionary:[self.dataArray objectAtIndex:index]];
    [dateDict setValue:newValue forKey:@"hoder"];
    [self.dataArray replaceObjectAtIndex:index withObject:dateDict];
    [self.mainTable reloadData];
}
-(void)pushTZImagePickerController{
    WEAK_SELF
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePicker.allowPickingVideo = NO;//上传头像不允许选择视频
    imagePicker.allowPickingOriginalPhoto = NO;
    [imagePicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //调用上传图片接口
        NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,UPLOADIMAGE_URL];
        [weakSelf uploadImageDataWithImageArray:photos url:urlString];
        weakSelf.requestSuccessBolck  = ^(NSDictionary *result) {
            NSArray *data = [NSArray arrayWithArray:[result objectForKey:@"data"]];
            if (data.count>0) {
                [YYOUCarUserInfoManager shareUserInfo].avatar = [NSString nullToString:[data objectAtIndex:0]];
            }
        };
        [weakSelf.mainTable reloadData];
    }];
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) {
            if (@available(iOS 9.0, *)) {
                tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            } else {
                // Fallback on earlier versions
            }
            if (@available(iOS 9.0, *)) {
                BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
            } else {
                // Fallback on earlier versions
            }
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
-(void)takePhoto{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    }else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    }else{
        [self pushImagePickerController];
    }
}
-(void)pushImagePickerController{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    WEAK_SELF
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImagePNGRepresentation(image);
        NSUInteger sizeOrigin = [imageData length];
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        UIImage *photoImage = [[UIImage alloc]init];
        photoImage = [YYOUCarUIUtils imageKb:sizeOriginKB image:image];
        photoImage = [YYOUCarUIUtils compressionSize:photoImage];
        //调用上传图片接口
        NSArray *photoArr = [NSArray arrayWithObjects:photoImage, nil];
        NSString *urlString = [NSString stringWithFormat:@"%@%@",REQUESTURL,UPLOADIMAGE_URL];
        [weakSelf uploadImageDataWithImageArray:photoArr url:urlString];
        weakSelf.requestSuccessBolck = ^(NSDictionary *result) {
            [YYOUCarUserInfoManager shareUserInfo].avatar = [result objectForKey:@""];
            [weakSelf.mainTable reloadData];
        };
    }
}
@end
