//
//  ZKRColoumnsViewController.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

/**
 未做: 上拉刷新/下拉加载
 点击跳转
 */

#import "ZKRColoumnsViewController.h"

#import "ZKRFunGroupItem.h"
#import "ZKRFunCellItem.h"
#import "ZKRColumnsViewCell.h"
#import "UIImageView+WebCache.h"
#import "ZKRRefreshHeader.h"
#import "ZKRArticleViewController.h"

static NSString *CGLColumnsCellID = @"CGLColumnsCellID";
@interface ZKRColoumnsViewController ()

@end

@implementation ZKRColoumnsViewController

#pragma mark - ---| init |---
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableHeaderView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZKRColumnsViewCell class]) bundle:nil] forCellReuseIdentifier:CGLColumnsCellID];
    // cell底部分割线去除
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [ZKRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCell)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewCell
{
    [self.tableView.mj_header endRefreshing];
}

 /** 头部滚动视图 (未完) */
- (void)setupTableHeaderView
{
    if (self.cycleURLString) {
    
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGLScreenW, 180)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.cycleURLString]];
        
        self.tableView.tableHeaderView = imageView;
    }
}

#pragma mark - Table view
 /** 组头部高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

 /** 组头部view */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] init];
    
    ZKRFunGroupItem *group = self.groupsArray[section];
    [view sd_setImageWithURL:[NSURL URLWithString:group.banner[@"url"]]];

    return view;
}
 /** 组footer高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

 /** 组footerview */
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    [footer setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZKRFunGroupItem *group = self.groupsArray[section];
    return group.itemsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZKRColumnsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CGLColumnsCellID];
    
    ZKRFunGroupItem *group = self.groupsArray[indexPath.section];
    ZKRFunCellItem *cellItem = group.itemsArray[indexPath.row];
        
    cell.cellItem = cellItem;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ZKRColumnsViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        cell.alpha = 1;
    }];
}

 /** 点击行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZKRArticleViewController *articleVC = [[ZKRArticleViewController alloc] init];
//    articleVC.preVC = NSStringFromClass([[self.view viewController] class]);
//    
//    [[self.view navController] pushViewController:articleVC animated:YES];
    
    
    NSLog(@"%zd",indexPath.row);
}
@end
