//
//  ZKRMineTableController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/1/29.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRMineTableController.h"
#import "HFStretchableTableHeaderView.h"
@interface ZKRMineTableController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic,strong)HFStretchableTableHeaderView *stretchHeaderView;
@end

@implementation ZKRMineTableController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航条的阴影图片.
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationItem.title = @"我的";
    
    //头像圆形处理
    _iconImageView.layer.cornerRadius = _iconImageView.cgl_width * 0.5;
    [_iconImageView.layer masksToBounds];
    
    //    topview点击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick)];
    
    [self.topView addGestureRecognizer:tap];
    
    // 改变headerView的偏移量
    self.stretchHeaderView = [HFStretchableTableHeaderView new];
    [self.stretchHeaderView stretchHeaderForTableView:self.tableView withView:self.topView subViews:nil];
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
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
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
