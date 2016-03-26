//
//  ZKRMineTableController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRMineTableController.h"
#import "HFStretchableTableHeaderView.h"
#import "ZKRFileCacheManager.h"
#import "ZKRLoginViewController.h"
#import "CNotificationManager.h"
@interface ZKRMineTableController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (nonatomic, strong) HFStretchableTableHeaderView *stretchHeaderView;


@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation ZKRMineTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航条的阴影图片.
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.title = @"我的";
    
    //头像圆形简单处理
    _iconImageView.layer.cornerRadius = _iconImageView.cgl_width * 0.5;
    [_iconImageView.layer masksToBounds];
    
    //    topview点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick)];
    
    [self.topView addGestureRecognizer:tap];
    
    // 改变headerView的偏移量
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:self.topView subViews:nil];
    
    
    [self setupCacheLabel];
}

 /** 显示缓存的label */
- (void)setupCacheLabel
{
    // 获取cache文件夹路径
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    // 获取缓存尺寸
    [ZKRFileCacheManager getCacheSizeOfDirectoriesPath:cachePath completeBlock:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
//        self.cacheLabel.text = [NSString stringWithFormat:@"%zd", totalSize];
        [self.tableView reloadData];
        
        self.cacheLabel.text = [self cacheStr:_totalSize];
//        [SVProgressHUD dismiss];
        
    }];
    
}

 /** 登陆view的点击 */
- (void)topViewClick
{
//    CGLFunc
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = @"账号管理";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

 /** section头部间距 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;//section头部高度
}

 /** section头部视图 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

 /** section底部间距 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

 /** section底部视图 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    
    [view autoresizingMask];
    return view;
}

#pragma mark - ---| tableView delegate |---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {// 清除缓存
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定要清除所有缓存文件吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
        
    } else if (indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 5)){// 登陆
        
        ZKRLoginViewController *loginVC = [[ZKRLoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else { // 跳转
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        vc.title = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - ---| alertView delegate |---
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else {
        // 删除cache缓存
        // 获取cache文件夹路径
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        
        // 真正清空缓存
        [ZKRFileCacheManager removeDirectoriesPath:cachePath];
        
        // 清空数据
        _totalSize = 0;
        
        self.cacheLabel.text = [self cacheStr:self.totalSize];
        
        // 显示清除缓存动画
        [CNotificationManager showMessage:@"已成功清除缓存" withOptions:@{CN_TEXT_COLOR_KEY:[UIColor whiteColor],CN_BACKGROUND_COLOR_KEY:[UIColor colorWithRed:0.19 green:0.83 blue:0.58 alpha:1]} completeBlock:^{
            [self.tableView reloadData];
            
        }];
    }
}

// 获取缓存字符串
- (NSString *)cacheStr:(NSInteger)totalSize
{
    // 获取文件夹缓存尺寸:文件夹比较小,文件夹非常大,获取尺寸比较耗时
    CGFloat cacheSizeF = 0;
    NSString *cacheStr = @"已清除";
    if (totalSize > (1000 * 1000)) { //MB
        cacheSizeF = totalSize / (1000 * 1000);
        cacheStr   = [NSString stringWithFormat:@"当前缓存 %.1fM",cacheSizeF];
        cacheStr   = [cacheStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (totalSize > 1000) { //KB
        cacheSizeF = totalSize / 1000;
        cacheStr   = [NSString stringWithFormat:@"当前缓存 %.1fK",cacheSizeF];
    } else if (totalSize > 0){ // B
        cacheStr   = [NSString stringWithFormat:@"当前缓存 %ldB",totalSize];
    }
    
    return cacheStr;
}

#pragma mark - stretchableTable delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.stretchHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchHeaderView resizeView];
}
@end
